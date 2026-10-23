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
| `manual-treinamento` | Este manual: a trilha do trainee e o script de cada turma |
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

- `<turma>-equipe-NN`: os trainees da equipe; acessam só o repositório dela.
- `validadores`: acessam os repositórios da turma em curso e aprovam os PRs (`CODEOWNERS`).

Os times das equipes não ficam dentro do time `validadores`. Time filho herda o acesso do pai, e
cada trainee passaria a ver os repositórios das outras equipes.
