# Como criar um módulo

Para o membro do núcleo que vai escrever um módulo novo ou trazer um do Notion.

## 1. Escolha o módulo

Pegue um módulo "a migrar" ou "a criar" no README do portfólio. Se ele não estiver na lista,
acrescente a linha no mesmo PR.

## 2. Escreva

1. Copie o [modelo de módulo](_modelo-de-modulo.md) para a pasta do portfólio, com nome curto e
   sem acento (`extracao-html-estatico.md`).
2. Se vier do Notion, traga o conteúdo e revise: link quebrado, ferramenta que mudou, print que
   não abre. Ponha a página de origem no campo `origem`.
3. A explicação escrita precisa funcionar sem o vídeo.
4. Nada de dado de cliente, credencial ou chave de API, nem em exemplo.

## 3. Grave o vídeo

- Grave a tela num exemplo de treino, nunca num repositório de cliente.
- Prefira vídeos curtos, ou um vídeo com capítulos que batam com as seções do passo a passo.
- Suba no lugar combinado pelo núcleo e ponha o link no campo `video`. O vídeo não vai para o
  GitHub.

Sem vídeo ainda? Publique o texto com status "sem vídeo" e grave depois.

## 4. Abra o PR

```powershell
git switch -c conhecimentos/<nome-do-modulo>
git add conhecimentos/
git commit -m "conhecimentos: <nome do módulo>"
git push -u origin conhecimentos/<nome-do-modulo>
```

No PR, atualize o status na tabela do README do portfólio. Quem revisa confere se um trainee
consegue seguir o módulo sozinho.
