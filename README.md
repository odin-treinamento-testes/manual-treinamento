# ODIN Treinamentos

O ODIN dos treinamentos do NDados. Os trainees trabalham aqui do jeito que o núcleo trabalha na
org principal (`ODIN-NDados-Poli-Junior`): repositório criado do boilerplate, contexto em
`context/`, tudo por PR revisado. Quem termina o treinamento e vira analista entra na org
principal.

> **Org de teste.** Esta org existe para validar a proposta com a Artefato. Se aprovada, a org de
> verdade é da Poli Júnior, e esta é apagada.

## O que tem aqui

| Repositório | O que é |
|---|---|
| `manual-treinamento` | Este manual: a trilha do trainee, os [conhecimentos](conhecimentos/) (módulos com vídeo e explicação), o [case de cada turma](turmas/) e o script que cria a turma |
| `skills-navegador` | As skills de plano, sessão e ata para o Claude gratuito |
| `boilerplate-treinamento` | O template das equipes, copiado do `boilerplate-projetogenerico` |
| `<semestre>-<treinamento>-equipe-NN` | Um repositório por equipe, por exemplo `2026-2-t2-equipe-01` |

Cada turma tem um tópico (`2026-2-t2`). Na página de repositórios da org, o filtro
`topic:2026-2-t2` mostra só aquela turma. No fim do treinamento, os repositórios são arquivados.

## Qual é o seu papel?

| Papel | Comece por |
|---|---|
| Trainee | [Trilha do trainee](trilha-do-trainee.md) |
| Validador | [Trilha do trainee](trilha-do-trainee.md), para saber o que a equipe faz, e revise os PRs pelo time `validadores` |
| Dono da org | [Script da turma](scripts/criar-turma.sh) |

## Times

- `<turma>`: o time da turma (ex.: `2026-2-t2`); só lê o `manual-treinamento` e o
  `skills-navegador`.
- `<turma>-equipe-NN`: os trainees da equipe, dentro do time da turma; escrevem só no repositório
  da equipe.
- `validadores`: acessam os repositórios da turma em curso e aprovam os PRs (`CODEOWNERS`).

A permissão básica da org é **nenhuma**: membro só vê o que o time dele libera. Time filho herda o
acesso do pai, por isso as equipes ficam dentro do time da turma (que só dá leitura aos repos
fixos) e nunca dentro de `validadores`, que veria os repositórios de todas as equipes.
