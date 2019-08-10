# Avaliando o desempenho de algoritmos de classificação para predição do óbito infantil
----

#### Tarefa 04 - Trabalho Final de IA
**Disciplina**: Inteligência Artificial (IA)

**Professor**: Dr. Jefferson Oliveira Andrade

**Programa**: Mestrado Profissional em Computação Aplicada

**Aluno**: Arthur Gomes da Vitoria

**Data de entrega**: 08/09/2019

**Linguagem**:  R version 3.6.0 (2019-04-26) Copyright (C) 2019 The R Foundation for Statistical Computing (R Core Team, 2019)

**Ambiente de programação**: Version 1.0.143 – © 2009-2016 RStudio, Inc.

----

<div style="text-align: justify"> 
Este repositório contém a implementação desenvolvida para Tarefa 04 que tem como objetivo geral avaliar o desempenho dos algoritmos de classificação para predição do óbito infantil, isto é, antes de completar 1 ano de idade, de forma a subsidiar o médico na tomada de decisão. No Brasil o monitoramento da mortalidade infantil é realizado por meio dos dados disponibilizados pelo Sistema de Informação sobre Mortalidade (SIM) e Sistema de Informação sobre Nascidos Vivos (SINASC), ambos implantados pelo Ministério da Saúde diante da carência no conhecimento do perfil epidemiológico dos óbitos e nascimentos da nação (JORGE;LAURENTI; GOTLIEB, 2007). Nos casos de óbitos menores de um ano, a variável Declaração de Óbito é preenchida com o número de Declaração de Nascido Vivo para associação com o SINASC. 
  
Dessa forma, a primeira etapa do processo, consistirá em coletar os dados dos nascidos vivos e óbitos infantis que nasceram no período entre 01 de janeiro de 2016 e 01 de janeiro de 2017 residentes no Estado do ES do SINASC e SIM, respectivamente. Além disso, nos óbitos infantis, serão considerados somente os que faleceram, independente da causa, entre 01 dejaneiro de 2016 e 31 de dezembro de 2017. O período escolhido está relacionado à última atualização de dados disponíveis no DATASUS, isto é, 2017 para ambos sistemas.

As fontes serão relacionadas utilizando a técnica de pareamento (*linkage*), aplicando os métodos determinístico e probabilístico, conforme \citeonline{de2017uso}. Primeiramente, a associação determinística será utilizada identificando a variável chave comum aos dois sistemas, isto é, o número DN. Neste estagio, para os registros não pareados a junção probabilística será usada apoiando-se nos campos existentes nos dois sistemas, de forma a identificar a probabilidade de um par de registros serem da mesma pessoa. E por fim, o conjunto de dados será obtido.

 
</div>
