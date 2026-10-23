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
| O coordenador aprova o PR | O validador da sua equipe aprova o PR |

## 0. Uma vez, antes do primeiro dia

1. Aceite o convite da org no e-mail do GitHub.
2. Instale o Git e o VS Code (tutorial do treinamento) e clone o repositório da equipe:
   ```powershell
   git clone https://github.com/<org>/<turma>-equipe-NN.git
   ```
3. No claude.ai, ligue **Configurações → Capacidades → Execução de código e criação de arquivos**
   e instale as skills do repositório `skills-navegador` (passo a passo no README dele).

## 1. Montar o Projeto no Claude

1. No claude.ai, crie um Projeto com o nome da sua equipe.
2. Em **Instruções do projeto**, cole o texto de [instrucoes-do-projeto.md](instrucoes-do-projeto.md).
3. Em **Conhecimento do projeto**, clique em **+ → GitHub**. A lista de repositórios pode não
   mostrar a org: clique no ícone de link, cole a URL do repositório da equipe
   (`https://github.com/<org>/<turma>-equipe-NN`), marque a raiz e clique em **Add files**. Se der
   erro de acesso, avise o validador: o app do Claude precisa estar instalado na org.

O Claude do Projeto só **lê** o repositório. Ele não escreve, não abre PR e não vê o histórico.
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

## 4. Fluxo de PR

Nada entra na `main` sem o validador.

```powershell
git switch -c <tipo>/<assunto>      # ex.: feat/extracao-farmacia-x
git add <arquivos>
git commit -m "<o que mudou>"
git push -u origin <tipo>/<assunto>
```

Abra o PR no GitHub. O validador é marcado sozinho pelo `CODEOWNERS`. Corrija o que ele pedir na
mesma branch e faça push de novo.

## O que nunca fazer

- Colar senha, token ou chave de API no chat ou no repositório. Credencial fica no `.env`, que o
  `.gitignore` já deixa de fora.
- Subir para o Claude ou para o repositório dado pessoal de alguém.
- Aceitar código do Claude sem entender e sem rodar.
