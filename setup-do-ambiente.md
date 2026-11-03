# Setup do ambiente (Windows)

Para as equipes de **Ciência de Dados**, cujo repositório vem do `boilerplate-treinamento`
(cópia do `boilerplate-CD` do núcleo). Faça uma vez por máquina, antes do primeiro dia. Todos os
comandos são em PowerShell.

## 1. O que instalar

| Ferramenta | Para quê | Como conferir |
|---|---|---|
| Git | clonar, commitar, abrir PR | `git --version` |
| VS Code | editar os arquivos | abre pelo menu Iniciar |
| Python 3.11 ou mais novo (python.org, marcando **Add python.exe to PATH**) | rodar `tools/init.py` e `tools/check.py`, que usam só a biblioteca padrão | `python --version` |
| `uv` | cria o ambiente do projeto (baixa o Python 3.11 do projeto sozinho) e roda o pipeline | `uv --version` |

Instalar o `uv` (instalador oficial da Astral):

```powershell
powershell -ExecutionPolicy ByPass -c "irm https://astral.sh/uv/install.ps1 | iex"
```

Feche e abra o PowerShell depois. Se preferir: `winget install --id=astral-sh.uv -e`.

No Windows o comando é `python`, não `python3`: onde um arquivo do repositório disser `python3`,
troque.

## 2. Clonar e conferir

```powershell
git clone https://github.com/<org>/<turma>-equipe-NN.git
cd <turma>-equipe-NN
python tools/check_estrutura.py
```

Deve aparecer `OK: contrato respeitado`.

## 3. Primeiro PR da equipe: inicializar o projeto

**Só uma pessoa da equipe faz isso**, e uma única vez. O `init` renomeia e apaga arquivos, e
depois some do repositório.

1. Confira que a árvore está limpa: `git status` sem nada pendente.
2. Crie a branch: `git switch -c feat/inicializar-projeto`.
3. Rode `python tools/init.py` e responda:
   - **nome do projeto**: o nome do case;
   - **Vai usar Databricks?**: **N** (o treinamento roda local);
   - **nome do primeiro modelo**: em `snake_case`, conforme o case (ex.: `churn_mensal`).
4. Instale o ambiente e rode os testes:
   ```powershell
   uv sync
   uv run pytest
   ```
5. No `CLAUDE.md`, troque os `<...>` da seção **Contexto geral do projeto** pelo que o enunciado
   em `context/00_case/` diz (cliente, objetivo, escopo, duração).
6. Rode o portão do CI localmente: `python tools/check.py`. O bloco **CONTRATO** precisa estar
   `OK`; o **CONSELHO** só avisa.
7. Commit, push e PR (fluxo na [trilha do trainee](trilha-do-trainee.md)). O validador aprova.

Quando a primeira pessoa mergear, o resto da equipe dá `git pull` e segue de lá.

## 4. Rodar o pipeline

```powershell
uv run python pipeline/entrypoints/run_local.py --config pipeline/config/<modelo>.yaml
```

A saída mostra o `run_id` e as métricas. O que cada pasta faz está em `docs/GUIA-DO-ANALISTA.md`
do repositório da equipe, e as regras que não podem ser quebradas, em `docs/rules/`.

## Se algo der errado

| Sintoma | O que fazer |
|---|---|
| `python` abre a Microsoft Store | Instale o Python pelo python.org ou desligue o atalho em **Configurações → Aplicativos → Configurações avançadas de aplicativos → Aliases de execução de aplicativo** |
| `uv` não é reconhecido | Feche e abra o PowerShell. Se continuar, confira se `%USERPROFILE%\.local\bin` está no PATH |
| `init.py` diz "alterações não commitadas" | Rode `git status`, commite ou descarte o que apareceu, e tente de novo |
| `init.py` diz "já foi inicializado" | Alguém da equipe já fez. Dê `git pull` |
| Erro de acesso ao repositório no Claude | Avise o validador: o app do Claude precisa estar instalado na org |
