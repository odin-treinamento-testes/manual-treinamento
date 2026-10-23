#!/usr/bin/env bash
# Cria os repositórios e os times de uma turma de treinamento.
#
# Uso:   ./criar-turma.sh <org> <turma> <numero-de-equipes>
# Ex.:   ./criar-turma.sh odin-treinamento-testes 2026-2-t2 9
#
# Precisa do gh logado como dono da org, com o escopo admin:org
# (gh auth refresh -h github.com -s admin:org). Pode rodar de novo: o que já existe é pulado.
set -euo pipefail

ORG="$1"
TURMA="$2"
N="$3"
TEMPLATE="$ORG/boilerplate-treinamento"
FIXOS=(manual-treinamento skills-navegador)

criar_time() {  # criar_time <nome> [id do time pai]
  gh api "orgs/$ORG/teams/$1" >/dev/null 2>&1 \
    || gh api "orgs/$ORG/teams" -f name="$1" -f privacy=closed >/dev/null
  if [ -n "${2:-}" ]; then
    gh api -X PATCH "orgs/$ORG/teams/$1" -F parent_team_id="$2" >/dev/null
  fi
}

# Membro sem time não vê nenhum repositório. Sem isso, todo trainee lê os repos das outras equipes.
gh api -X PATCH "orgs/$ORG" -f default_repository_permission=none >/dev/null

# Time da turma: só lê os repositórios fixos. Os times das equipes ficam dentro dele e herdam isso.
criar_time "$TURMA"
TURMA_ID=$(gh api "orgs/$ORG/teams/$TURMA" --jq .id)
criar_time validadores
for REPO in "${FIXOS[@]}"; do
  gh api -X PUT "orgs/$ORG/teams/$TURMA/repos/$ORG/$REPO" -f permission=pull >/dev/null
  gh api -X PUT "orgs/$ORG/teams/validadores/repos/$ORG/$REPO" -f permission=pull >/dev/null
done

for i in $(seq 1 "$N"); do
  EQUIPE="$TURMA-equipe-$(printf '%02d' "$i")"

  if ! gh repo view "$ORG/$EQUIPE" >/dev/null 2>&1; then
    gh repo create "$ORG/$EQUIPE" --private --template "$TEMPLATE" >/dev/null
  fi
  gh repo edit "$ORG/$EQUIPE" --add-topic "$TURMA" >/dev/null

  # Time da equipe: escreve só no próprio repositório.
  criar_time "$EQUIPE" "$TURMA_ID"
  gh api -X PUT "orgs/$ORG/teams/$EQUIPE/repos/$ORG/$EQUIPE" -f permission=push >/dev/null

  # Validadores: aprovam os PRs de todas as equipes da turma.
  gh api -X PUT "orgs/$ORG/teams/validadores/repos/$ORG/$EQUIPE" -f permission=maintain >/dev/null

  echo "ok  $EQUIPE"
done

echo "Turma $TURMA pronta. Filtro: https://github.com/orgs/$ORG/repositories?q=topic%3A$TURMA"
