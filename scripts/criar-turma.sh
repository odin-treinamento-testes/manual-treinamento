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

criar_time() {
  gh api "orgs/$ORG/teams/$1" >/dev/null 2>&1 \
    || gh api "orgs/$ORG/teams" -f name="$1" -f privacy=closed >/dev/null
}

criar_time validadores

for i in $(seq 1 "$N"); do
  EQUIPE="$TURMA-equipe-$(printf '%02d' "$i")"

  if ! gh repo view "$ORG/$EQUIPE" >/dev/null 2>&1; then
    gh repo create "$ORG/$EQUIPE" --private --template "$TEMPLATE" >/dev/null
  fi
  gh repo edit "$ORG/$EQUIPE" --add-topic "$TURMA" >/dev/null

  # Time da equipe: escreve só no próprio repositório.
  criar_time "$EQUIPE"
  gh api -X PUT "orgs/$ORG/teams/$EQUIPE/repos/$ORG/$EQUIPE" -f permission=push >/dev/null

  # Validadores: aprovam os PRs de todas as equipes da turma.
  gh api -X PUT "orgs/$ORG/teams/validadores/repos/$ORG/$EQUIPE" -f permission=maintain >/dev/null

  echo "ok  $EQUIPE"
done

echo "Turma $TURMA pronta. Filtro: https://github.com/orgs/$ORG/repositories?q=topic%3A$TURMA"
