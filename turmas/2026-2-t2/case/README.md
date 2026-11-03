# Case — MaBiYama: manutenção preditiva da frota industrial

**Treinamento:** T2 2026.2 · **Portfólio:** ciencia-de-dados

> Case simulado: cliente, falas e dados são fictícios. Este enunciado resume a proposta que a
> Poli Júnior apresentou ao cliente em 19/10/2026. Vocês são a equipe de consultores do projeto.

## O cliente

Uma empresa industrial com uma frota de **100 máquinas de 4 modelos**, com idades entre 0 e 20
anos. Cada máquina registra, a cada hora, **quatro leituras de sensores**, além de alertas de
erro, histórico de manutenção e histórico de falhas de componentes. Os dados existem há anos e
ficam guardados sem uso.

**Contatos do cliente** (papel no case): a definir pelo organizador do treinamento.

## O problema

A manutenção segue um calendário fixo. Quando uma peça quebra antes do previsto, a linha de
produção para. Em um ano, a frota teve **mais de 700 falhas de componentes**: cada uma foi uma
parada não planejada, com técnico acionado às pressas e peça comprada em caráter de urgência. Ao
mesmo tempo, o calendário troca peças que ainda estavam boas.

Nas palavras do cliente:

- "A gente troca peça que estava boa e deixa quebrar a que estava ruim."
- "Cada parada não planejada desorganiza a semana inteira da produção."
- "Os sensores apitam o tempo todo, ninguém sabe mais o que é alerta de verdade."
- "Eu queria chegar de manhã e saber em qual máquina mexer primeiro."

Por que importa: uma parada não planejada custa muito mais que uma manutenção programada; o
volume de alertas é alto e sem priorização; não se sabe quais máquinas e peças concentram o
risco; e a compra de peças não acompanha o risco real de falha.

## O que o cliente espera

Um modelo de Machine Learning que, **toda manhã às 05:00**, estime a probabilidade de **cada peça
de cada máquina falhar até as 06:00 do dia seguinte**, e uma interface web onde a equipe do
cliente sobe os dados do dia e recebe a lista de máquinas e peças priorizadas para manutenção,
junto com um diagnóstico da qualidade da base recebida.

## Escopo

**Dentro:** integrar as fontes de dados numa visão única por máquina; limpeza reprodutível;
análise exploratória; modelo preditivo; interface web publicada; recomendação de política de
manutenção.

**Fora:** o que não está nas etapas abaixo. Dúvida de escopo vira pergunta ao cliente (o
validador faz esse papel) e decisão registrada em `context/`.

## Etapas e entregáveis

Duração total prevista: **17 dias úteis** (cerca de 3,5 semanas). Report 1 ao fim da Análise
Exploratória e Report 2 na Apresentação Final.

| # | Etapa | Duração | O que entregar |
|---|---|---|---|
| 1 | Imersão no contexto | 1 dia | Dicionário de dados, unidade de previsão e métrica validados pelo cliente |
| 2 | Limpeza e integração dos dados | 3 dias | Script de limpeza reprodutível e relatório de qualidade dos dados |
| 3 | Análise exploratória | 3 dias | Notebook de EDA com todas as análises e conclusões, apresentado no **Report 1** |
| 4 | Modelagem preditiva | 7 dias | Notebook de modelagem com o comparativo entre modelos e o modelo final validado |
| 5 | Interface web | 2 dias | Interface publicada e funcionando |
| 6 | Validação e apresentação final | 1 dia | **Report 2**: apresentação final, notebooks e código no repositório |

O que cada etapa pede:

1. **Imersão.** Transformar o pedido numa pergunta de ciência de dados: o que conta como falha,
   com que antecedência é preciso avisar, quanto custa uma parada e quanto custa uma manutenção.
   Entender o que cada linha de cada tabela representa e como elas se relacionam. Configurar o
   ambiente (GitHub, Python).
2. **Limpeza e integração.** Mapear as relações entre telemetria, erros, operação, falhas,
   manutenção e máquinas. Diagnosticar duplicatas, valores impossíveis, lacunas na série e
   inconsistências de formato e nomenclatura. Justificar o tratamento de cada problema. A limpeza
   é um **script reutilizável**, não um notebook isolado: tem que rodar em qualquer base nova do
   cliente.
3. **Análise exploratória.** Comportamento dos sensores nas horas e nos dias antes de cada falha,
   por peça; cruzamento dos tipos de erro com as falhas; ciclos de manutenção e de falha por
   modelo e idade da máquina; desbalanceamento entre dias com e sem falha.
4. **Modelagem.** Base de modelagem com **uma linha por máquina por dia**, usando só o que se
   sabe até as 05:00; variáveis por janela de tempo (sensores, erros, manutenção, perfil da
   máquina); **validação temporal**; comparação justa de algoritmos na mesma validação
   (scikit-learn e bibliotecas à escolha da equipe); análise de erros e justificativa do modelo.
5. **Interface web.** Aba de previsão (sobe a base bruta e recebe a lista priorizada) e aba de
   análise (qualidade da base recebida e visão de sensores e erros por máquina); validação da
   entrada com mensagens claras para bases fora do padrão; publicação com link de acesso.
6. **Validação e apresentação.** Demonstração ao vivo com uma base nova do cliente; resultados em
   linguagem de negócio; recomendação de política de manutenção: **a partir de que risco
   intervir** e a **economia estimada em R$**.

## Dados e acessos

Base bruta em **6 tabelas** (telemetria, erros, operação, falhas, manutenção e máquinas). O
validador entrega os arquivos por fora do GitHub. **Dados do cliente não entram no repositório**:
ficam em `pipeline/data/raw/`, que o `.gitignore` e o CI já barram. Credencial nunca vai aqui;
fica no `.env`.

## Rituais

Planning, weekly e review: datas e participantes definidos pelo organizador do treinamento. O
projeto não roda nas semanas de prova da Escola Politécnica.

## Datas

Início e marcos: a definir pelo organizador do treinamento.
