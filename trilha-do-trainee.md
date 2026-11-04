# Trilha do trainee

Você vai trabalhar no case do treinamento do mesmo jeito que o núcleo trabalha nos projetos de
verdade. A diferença é a ferramenta: o núcleo usa o Claude Code com o plugin `ndados`, e você usa
o Claude gratuito no navegador. O método é o mesmo.

| No núcleo (Claude Code) | No treinamento (Claude no navegador) |
|---|---|
| O Claude lê o `CLAUDE.md` e o `context/` sozinho | Um Projeto no claude.ai com o repositório da equipe conectado |
| O orquestrador planeja e pede o ok | A skill `odin-plano` |
| `session-summary` e `ata-report` gravam em `context/` | `odin-sessao` e `odin-ata` geram o arquivo; você salva e commita |
| O Claude Code roda o git | Você roda o git |
| O coordenador aprova o PR | Você sobe direto na `main`, e o validador aprova o entregável de cada etapa |

## 0. Uma vez, antes do primeiro dia

1. Aceite o convite da org no e-mail do GitHub.
2. Instale o Git, o VS Code, o Python e o `uv`, e clone o repositório da equipe. Passo a passo
   em [setup-do-ambiente.md](setup-do-ambiente.md) (equipes de Ciência de Dados). O
   **primeiro commit da equipe**, que inicializa o projeto, também está lá.
3. No claude.ai, ligue **Configurações → Capacidades → Execução de código e criação de arquivos**
   e instale as skills do repositório `skills-navegador` (passo a passo no README dele).

## 1. Montar o Projeto no Claude

1. No claude.ai, crie um Projeto com o nome da sua equipe.
2. Em **Instruções do projeto**, cole o texto de [instrucoes-do-projeto.md](instrucoes-do-projeto.md).
3. Em **Conhecimento do projeto**, clique em **+ → GitHub**. A lista de repositórios pode não
   mostrar a org: clique no ícone de link, cole a URL do repositório da equipe
   (`https://github.com/<org>/<turma>-equipe-NN`), marque a raiz e clique em **Add files**. Se der
   erro de acesso, avise o validador: o app do Claude precisa estar instalado na org.

O Claude do Projeto só **lê** o repositório. Ele não escreve, não commita e não vê o histórico.
Depois de cada `git push`, atualize o repositório no conhecimento do Projeto para o Claude ver a
versão nova.

## 2. Uma sessão de trabalho

1. **Comece pelo plano.** Peça a tarefa e deixe a `odin-plano` montar o plano: objetivo,
   contexto, critério de aceite, o que não mexer. Só aprove quando entender cada passo.
2. **Execute em partes.** Rode o código na sua máquina e traga o erro para o Claude quando der
   errado. Entenda o que entra no repositório: quem responde pelo código é você.
3. **Feche a sessão.** Peça "fechar sessão": a `odin-sessao` gera o resumo. Salve em
   `context/sessions/` e commite.

O plano gratuito tem limite de uso. Conversa longa gasta o limite mais rápido e piora a resposta.
Feche a sessão e abra uma conversa nova a cada tarefa.

## 3. Reuniões

Depois de planning, weekly, review ou reunião com o cliente do case, cole as anotações e peça
"gerar ata". A `odin-ata` gera a ata, e ela vai para `context/sessions/` também.

## 4. Subir o trabalho

A equipe trabalha direto na `main`.

```powershell
git pull                            # traz o que a sua dupla já subiu
python tools/check.py               # o mesmo que o CI roda: o CONTRATO tem que estar OK
git add <arquivos>
git commit -m "<o que mudou>"
git push
```

Se o push for recusado, a sua dupla subiu algo antes: `git pull` e push de novo. Ao fim de cada
etapa, avise o validador. A etapa só está pronta quando ele aprova o entregável; o que ele pedir,
você corrige e sobe na `main` de novo.

## O que nunca fazer

- Colar senha, token ou chave de API no chat ou no repositório. Credencial fica no `.env`, que o
  `.gitignore` já deixa de fora.
- Subir para o Claude ou para o repositório dado pessoal de alguém. Dados do case ficam em
  `pipeline/data/raw/` etc., que o CI barra se forem versionados.
- Aceitar código do Claude sem entender e sem rodar.
