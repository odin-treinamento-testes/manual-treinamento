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
CASE_DIR="$(cd "$(dirname "$0")/.." && pwd)/turmas/$TURMA/case"

criar_time() {  # criar_time <nome> [id do time pai]
  gh api "orgs/$ORG/teams/$1" >/dev/null 2>&1 \
    || gh api "orgs/$ORG/teams" -f name="$1" -f privacy=closed >/dev/null
  if [ -n "${2:-}" ]; then
    gh api -X PATCH "orgs/$ORG/teams/$1" -F parent_team_id="$2" >/dev/null
  fi
}

copiar_case() {  # copiar_case <repo>: turmas/<turma>/case/ → context/00_case/, só o que mudou
  local REPO="$1" ARQ REL DESTINO SHA_LOCAL SHA_REMOTO
  [ -d "$CASE_DIR" ] || return 0
  # O repo recém-criado do template pode demorar alguns segundos para ter a main.
  for _ in 1 2 3 4 5; do
    gh api "repos/$ORG/$REPO/commits/main" >/dev/null 2>&1 && break
    sleep 3
  done
  while IFS= read -r ARQ; do
    REL="${ARQ#"$CASE_DIR"/}"
    DESTINO="context/00_case/$REL"
    SHA_LOCAL=$(git hash-object "$ARQ")
    SHA_REMOTO=$(gh api "repos/$ORG/$REPO/contents/$DESTINO" --jq .sha 2>/dev/null || true)
    [ "$SHA_LOCAL" = "$SHA_REMOTO" ] && continue
    ARGS=(-f message="case: $REL" -f content="$(base64 -w0 "$ARQ")")
    [ -n "$SHA_REMOTO" ] && ARGS+=(-f sha="$SHA_REMOTO")
    gh api -X PUT "repos/$ORG/$REPO/contents/$DESTINO" "${ARGS[@]}" >/dev/null
    echo "    case: $REL"
  done < <(find "$CASE_DIR" -type f | sort)
}

[ -d "$CASE_DIR" ] || echo "aviso: $CASE_DIR não existe; os repositórios saem sem o case."

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
  copiar_case "$EQUIPE"

  # Time da equipe: escreve só no próprio repositório.
  criar_time "$EQUIPE" "$TURMA_ID"
  gh api -X PUT "orgs/$ORG/teams/$EQUIPE/repos/$ORG/$EQUIPE" -f permission=push >/dev/null

  # Validadores: acessam o repositório de todas as equipes da turma para aprovar as etapas.
  gh api -X PUT "orgs/$ORG/teams/validadores/repos/$ORG/$EQUIPE" -f permission=maintain >/dev/null

  echo "ok  $EQUIPE"
done

echo "Turma $TURMA pronta. Filtro: https://github.com/orgs/$ORG/repositories?q=topic%3A$TURMA"
