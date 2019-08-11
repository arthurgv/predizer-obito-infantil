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


Este repositório contém a implementação desenvolvida para Tarefa 04 que tem como objetivo geral avaliar o desempenho dos algoritmos de classificação para predição do óbito infantil, isto é, antes de completar 1 ano de idade, de forma a subsidiar o médico na tomada de decisão. No Brasil o monitoramento da mortalidade infantil é realizado por meio dos dados disponibilizados pelo Sistema de Informação sobre Mortalidade (SIM) e Sistema de Informação sobre Nascidos Vivos (SINASC), ambos implantados pelo Ministério da Saúde diante da carência no conhecimento do perfil epidemiológico dos óbitos e nascimentos da nação (JORGE;LAURENTI; GOTLIEB, 2007). Nos casos de óbitos menores de um ano, a variável Declaração de Óbito é preenchida com o número de Declaração de Nascido Vivo para associação com o SINASC. 

Por essa razão, será utilizada uma adaptação da metodologia apresentada por Santos (2018) consistindo nas seguintes etapas: coleta dos dados; integração das bases; construção da variável de interesse; solucionar o desbalanceamento do conjunto de dados; seleção aleatória do conjunto de dados em treinamento e teste; pré-processamento dos dados de treinamento; análise exploratória e descritiva; aprendizado e seleção de modelos nos dados de treinamento; aplicação do pré-processamento nos dados de teste; predição da resposta de interesse em dados de teste e avaliação dos modelos candidatos para seleção.

Dessa forma, a primeira etapa do processo, consistirá em coletar os dados dos nascidos vivos e óbitos infantis que nasceram no período entre 01 de janeiro de 2016 e 01 de janeiro de 2017 residentes no Estado do ES do SINASC e SIM, respectivamente. Além disso, nos óbitos infantis, serão considerados somente os que faleceram, independente da causa, entre 01 dejaneiro de 2016 e 31 de dezembro de 2017. O período escolhido está relacionado à última atualização de dados disponíveis no DATASUS, isto é, 2017 para ambos sistemas.

As fontes serão relacionadas utilizando a técnica de pareamento (*linkage*), aplicando os métodos determinístico e probabilístico. O desfecho, variável resposta, será calculada de forma que recém-nascidos com mais de 364 dias de vida serão considerados não óbitos e o contrário óbito. Espera-se que o desfecho óbito apresente uma proporção muito menor comparado aos não óbitos e diante disso, técnicas de redução do impacto desse desbalanceamento serão aplicados. O banco de dados será dividido em treinamento e teste e a proporção para cada componente variará de acordo com a quantidade de registros disponíveis. Após a seleção, os dados de treinamento serão pré-processados, isto é, descarte de preditores não informativos; imputação de dados faltantes; análise de multicolinearidade; transformação dos preditores quantitativos; e transformação dos preditores qualitativos. 

Com intuito de ter conhecimento sobre o conjunto de dados, análises exploratórias serão realizadas identificando possíveis associações entre as variáveis e presença de observações discrepantes. Diante desse conhecimento, algoritmos como *Support Vector Machine* (CORTES; VAPNIK, 1995) , *K Nearest Neighbor* (ALTMAN, 1992), vistos na disciplina de Inteligência Artificial, e *Naive Bayes* (DUDA;HART; STORK, 2012), melhor modelo selecionado em um conjunto de dados similar, serão ajustados aos dados de treinamento. E por fim, os dados de teste serão pré-processados de acordo com o aplicado nos de treinamento e preditos. De posse dos desfechos preditos e os reais, os modelos candidatos serão avaliados por meio das métricas: área abaixo da curva Característica de Operação do Receptor (AUC ROC); Matriz de Confusao; acuracia; *recall*; precisao; e *F1-Score*.

Ao fim da tarefa pretende-se comparar os resultados obtidos com os apresentados por Silva et al. (2017).

### Bibliografia

ALTMAN, Naomi S. An introduction to kernel and nearest-neighbor nonparametricregression.The American Statistician, Taylor & Francis Group, v. 46, n. 3, p. 175–185,1992.

CORTES, Corinna; VAPNIK, Vladimir. Support-vector networks.Machine learning,Springer, v. 20, n. 3, p. 273–297, 1995.

DUDA, Richard O; HART, Peter E; STORK, David G.Pattern classification. [S.l.]: JohnWiley & Sons, 2012.

JORGE, Maria Helena Prado de Mello; LAURENTI, Ruy; GOTLIEB, SabinaLéa Davidson. Análise da qualidade das estatísticas vitais brasileiras: a experiência deimplantação do sim e do sinasc.Ciência & Saúde Coletiva, SciELO Public Health, v. 12,p. 643–654, 2007.

R Core Team (2019). R: A language and environment for statistical computing. R Foundation for Statistical Computing, Vienna, Austria. URL
https://www.R-project.org/.

SANTOS, Hellen Geremias dos.Comparação da performance de algoritmos de machinelearning para a análise preditiva em saúde pública e medicina. 2018. Tese (Doutorado) —Universidade de São Paulo, 2018.

SILVA, Cristiano Lima da et al. Usando o classificador naive bayes para geração de alertasde risco de óbito infantil.Revista Electronica de Sistemas de Informaçao, FaculdadeCenecista de Campo Largo-FACECLA, v. 16, n. 2, p. 1–15, 2017.
