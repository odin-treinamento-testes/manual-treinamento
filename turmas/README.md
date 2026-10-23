# Turmas

Uma pasta por turma, com o nome da turma (`2026-2-t2`). Dentro dela, `case/` tem o enunciado do
case: o `criar-turma.sh` copia o conteúdo para `context/00_case/` de cada repositório de equipe.
Todas as equipes começam com o mesmo enunciado, versionado, e o Claude do Projeto lê pelo GitHub.

```
turmas/
└── 2026-2-t2/
    └── case/
        ├── README.md      ← o enunciado (modelo: _modelo-de-case.md)
        └── <anexos>       ← proposta, canvas, base de exemplo (opcional)
```

Mudou o enunciado no meio da turma? Edite aqui e rode o script de novo: ele atualiza só os
arquivos que mudaram, com um commit em cada repositório.

> **Só o que o trainee pode ver.** Os trainees da turma leem este repositório, e o conteúdo vai
> para o repositório deles. Gabarito, dicas de validador e dinâmicas surpresa do cliente ficam
> fora do GitHub dos treinamentos.
