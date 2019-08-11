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
</div>

Neste trabalho, algoritmos de classificação serão aplicados com intuito de estimar o risco do recém-nascido vir à óbito. Por essa razão, será utilizada uma adaptação da metodologia apresentada por Santos (2018) consistindo nas seguintes etapas: coleta dos dados; integração das bases; construção da variável de interesse; solucionar o desbalanceamento do conjunto de dados; seleção aleatória do conjunto de dados em treinamento e teste; pré-processamento dos dados de treinamento; análise exploratória e descritiva; aprendizado e seleção de modelos nos dados de treinamento; aplicação do pré-processamento nos dados de teste; predição da resposta de interesse em dados de teste e avaliação dos modelos candidatos para seleção.

Dessa forma, a primeira etapa do processo, consistirá em coletar os dados dos nascidos vivos e óbitos infantis que nasceram no período entre 01 de janeiro de 2016 e 01 de janeiro de 2017 residentes no Estado do ES do SINASC e SIM, respectivamente. Além disso, nos óbitos infantis, serão considerados somente os que faleceram, independente da causa, entre 01 dejaneiro de 2016 e 31 de dezembro de 2017. O período escolhido está relacionado à última atualização de dados disponíveis no DATASUS, isto é, 2017 para ambos sistemas.

As fontes serão relacionadas utilizando a técnica de pareamento (*linkage*), aplicando os métodos determinístico e probabilístico. O desfecho, variável resposta, óbito ou não óbito, será calculada em que recém-nascidos com mais de 364 dias de vida serão considerados não óbitos e o contrário óbito. Espera-se que o desfecho óbito apresente uma proporção muito menor comparado aos não óbitos e diante disso, técnicas de redução do impacto desse desbalanceamento serão aplicados. O banco de dados será dividido em treinamento e teste e a proporção considerada variará de acordo com a quantidade de registros disponíveis. Após a seleção, os dados de teste serão pré-processados, isto é, descarte de preditores não informativos; imputação de dados faltantes; análise de multicolinearidade; transformação dos preditores quantitativos; e transformação dos preditores qualitativos. Após a estratificação
 

