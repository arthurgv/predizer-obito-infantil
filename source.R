#####################################################################################################
#####################################################################################################
### Autor: Arthur Gomes da Vitoria                      #############################################
### Tarefa Final: Projeto SIM e SINAC                   #############################################
### Data de Inicio:  05/08/2019                         #############################################
#####################################################################################################
#####################################################################################################
#####################################################################################################

set.seed(99)

# Direcionar o diretorio do trabalho de onde estão so arquivos
setwd("C:/Users/WINDOWS10/Documents/IFES_Campus_Serra/Mestrado_Profissional_Computacao _Aplicada/Disciplinas/Inteligencial_Artificial/Projeto_Final")

#install.packages("read.dbc") # Caso não tenha o pacote instalado no computador
require(read.dbc)
DNES16 <- read.dbc("DNES2016.dbc", as.is= TRUE) # as.is não ler variáveis como factors
DNES17 <- read.dbc("DNES2017.dbc", as.is= TRUE)
DOES16 <- read.dbc("DOES2016.dbc", as.is= TRUE)
DOES17 <- read.dbc("DOES2017.dbc", as.is= TRUE)

DNES1617 <- rbind(DNES16,DNES17)
DNES1617[which(DNES1617$GRAVIDEZ == 3),which(colnames(DNES1617) %in% c("GRAVIDEZ"))] <- 2
DOES1617 <- rbind(DOES16,DOES17)

NUMDN <- DOES1617[which(is.na(DOES1617$DTNASC)),
                  c(which(colnames(DOES1617)=="NUMERODN"))] #NUMERODN
NUMDN <- NUMDN[!is.na(NUMDN)] #NUMERODN

NUMDO <- DOES1617[DOES1617$NUMERODN %in% NUMDN,
                  c(which(colnames(DOES1617)=="NUMERODO"))] #NUMERODN

DOES1617[DOES1617[,which(colnames(DOES1617)=="NUMERODN")]%in%NUMDN,
           which(colnames(DOES1617)=="DTNASC")] <- DNES1617[DNES1617[,which(colnames(DNES1617)=="NUMERODN")]%in%NUMDN,
                                                            which(colnames(DNES1617)=="DTNASC")]

DOES1617$DIFFON <- as.Date(DOES1617$DTOBITO, format = "%d%m%Y") - as.Date(DOES1617$DTNASC, format = "%d%m%Y")
DOES1617$Desfecho <- ifelse(DOES1617$DIFFON < 365, 1, 0)

DO <- DOES1617[(which((as.Date(DOES1617$DTNASC, format = "%d%m%Y") >= "2016-01-01") & (as.Date(DOES1617$DTNASC, format = "%d%m%Y") <= "2017-01-01") & (DOES1617$Desfecho == 1))), ]
DO <- DO[which(!is.na(DO$NUMERODN) == TRUE),]

BD1 <- DNES1617[which(DNES1617$NUMERODN %in% unique(DO$NUMERODN)),]
BD1$Desfecho <- 1

DN <- DNES1617[-which(DNES1617$NUMERODN %in% unique(DO$NUMERODN)),]
DN <- DN[(which((as.Date(DN$DTNASC, format = "%d%m%Y") >= "2016-01-01") & (as.Date(DN$DTNASC, format = "%d%m%Y") <= "2017-01-01"))), ]

BD0 <- DN[sample(nrow(DN), nrow(BD1)), ]
BD0$Desfecho <- 0

BDTREINO0 <- BD0[sample(nrow(BD0), nrow(BD0)*0.7), ]
BDTESTE0  <- BD0[-which((BD0$NUMERODN %in% BDTREINO0$NUMERODN)), ]

BDTREINO1 <- BD1[sample(nrow(BD1), nrow(BD1)*0.7), ]
BDTESTE1  <- BD1[-which((BD1$NUMERODN %in% BDTREINO1$NUMERODN)), ]

BDTESTE <- rbind(BDTESTE1,BDTESTE0)
BDTREINO <- rbind(BDTREINO1,BDTREINO0)

BDTREINO <- BDTREINO[, -(which(colnames(BDTREINO) %in% 
                     c("NUMERODN", "CODINST", "ORIGEM", "CODMUNNASC", "CODOCUPMAE", "NUMERODV","PREFIXODN",
                      "CODESTAB", "DTNASC", "HORANASC", "DTCADASTRO",  "CODANOMAL","NUMEROLOTE",
                      "VERSAOSIST", "DTRECEBIM",  "DIFDATA", "DTRECORIGA", "CODMUNNATU",
                      "CODUFNATU", "ESCMAE2010", "SERIESCMAE", "DTNASCMAE", "DTULTMENST",
                      "SEMAGESTAC", "TPMETESTIM", "CONSPRENAT", "MESPRENAT", "TPAPRESENT",
                      "STTRABPART", "STCESPARTO", "TPNASCASSI", "TPFUNCRESP",
                      "TPDOCRESP", "DTDECLARAC", "ESCMAEAGR1", "STDNEPIDEM", "STDNNOVA",
                      "CODPAISRES", "TPROBSON", "PARIDADE", "KOTELCHUCK", "CODMUNRES", "NATURALMAE"
                      )))]

BDTREINO[(which(BDTREINO$ESTCIVMAE == "9"))
         ,which(colnames(BDTREINO) %in% c("ESTCIVMAE"))] <-NA

BDTREINO[(which(BDTREINO$ESCMAE == "9"))
         ,which(colnames(BDTREINO) %in% c("ESCMAE"))] <-NA

BDTREINO[(which(BDTREINO$CONSULTAS == "9"))
              ,which(colnames(BDTREINO) %in% c("CONSULTAS"))] <-NA

BDTREINO[(which(BDTREINO$APGAR1 == "99"))
         ,which(colnames(BDTREINO) %in% c("APGAR1"))] <-NA

BDTREINO[(which(BDTREINO$APGAR5 == "99"))
         ,which(colnames(BDTREINO) %in% c("APGAR5"))] <-NA

BDTREINO[(which(BDTREINO$IDANOMAL == "9"))
         ,which(colnames(BDTREINO) %in% c("IDANOMAL"))] <-NA

cols <- c("LOCNASC", "ESTCIVMAE", "ESCMAE", "GESTACAO", "GRAVIDEZ", "PARTO",
          "SEXO", "CONSULTAS", "RACACOR", "IDANOMAL", "RACACORMAE", "Desfecho")

BDTREINO[cols] <- lapply(BDTREINO[cols], factor)  ## as.factor() could also be used

BDTREINO[!sapply(BDTREINO, is.factor)] <- lapply(BDTREINO[!sapply(BDTREINO, is.factor)],
                                                  as.numeric)

Mode <- function (x, na.rm) {
  xtab <- table(x)
  xmode <- names(which(xtab == max(xtab)))
  if (length(xmode) > 1) xmode <- ">1 mode"
  return(xmode)
}

Preproc <- matrix(NA, 1, ncol(BDTREINO))

colnames(Preproc) <- colnames(BDTREINO)

for (var in 1:ncol(BDTREINO)) {
  if (class(BDTREINO[,var])=="numeric") {
    BDTREINO[is.na(BDTREINO[,var]),var] <- round(x = mean(BDTREINO[,var], na.rm = TRUE),
                                                 digits = 0)
    Preproc[1,var] <- round(x = mean(BDTREINO[,var], na.rm = TRUE),
                            digits = 0)
  } else if (class(BDTREINO[,var]) %in% c("character", "factor")) {
    BDTREINO[is.na(BDTREINO[,var]),var] <- Mode(BDTREINO[,var], na.rm = TRUE)
    Preproc[1,var] <- Mode(BDTREINO[,var], na.rm = TRUE)
  }
}

table(BDTREINO$LOCNASC)
table(BDTREINO$IDADEMAE)
table(BDTREINO$ESTCIVMAE)
table(BDTREINO$ESCMAE)
table(BDTREINO$QTDFILVIVO)
table(BDTREINO$QTDFILMORT)
table(BDTREINO$GESTACAO)
table(BDTREINO$GRAVIDEZ)
table(BDTREINO$PARTO)
table(BDTREINO$CONSULTAS)
table(BDTREINO$SEXO)
table(BDTREINO$APGAR1)
table(BDTREINO$APGAR5)
table(BDTREINO$RACACOR)
table(BDTREINO$PESO)
table(BDTREINO$IDANOMAL)
table(BDTREINO$RACACORMAE)
table(BDTREINO$QTDGESTANT)
table(BDTREINO$QTDPARTNOR)
table(BDTREINO$QTDPARTCES)
table(BDTREINO$IDADEPAI)
table(BDTREINO$Desfecho)

table(BDTREINO$LOCNASC,BDTREINO$Desfecho) # Fisher
table(BDTREINO$ESTCIVMAE,BDTREINO$Desfecho) # Fisher
table(BDTREINO$ESCMAE,BDTREINO$Desfecho) # Fisher
table(BDTREINO$GESTACAO,BDTREINO$Desfecho) # Fisher
table(BDTREINO$GRAVIDEZ,BDTREINO$Desfecho) # Fisher
table(BDTREINO$PARTO,BDTREINO$Desfecho) # Teste Chi Squared Corrigido
table(BDTREINO$CONSULTAS,BDTREINO$Desfecho) # Teste Chi Squared Corrigido
table(BDTREINO$SEXO,BDTREINO$Desfecho) # Teste Chi Squared Corrigido
table(BDTREINO$RACACOR,BDTREINO$Desfecho) # Fisher
table(BDTREINO$IDANOMAL,BDTREINO$Desfecho) # Teste Chi Squared Corrigido
table(BDTREINO$RACACORMAE,BDTREINO$Desfecho) # Fisher

# SAI 

fisher.test(BDTREINO$LOCNASC,BDTREINO$Desfecho) # Fisher
fisher.test(BDTREINO$ESTCIVMAE,BDTREINO$Desfecho) # Fisher
fisher.test(BDTREINO$ESCMAE,BDTREINO$Desfecho) # Fisher
chisq.test(BDTREINO$PARTO,BDTREINO$Desfecho, correct = TRUE) # Teste Chi Squared Corrigido
chisq.test(BDTREINO$SEXO,BDTREINO$Desfecho, correct = TRUE) # Teste Chi Squared Corrigido
fisher.test(BDTREINO$RACACOR,BDTREINO$Desfecho) # Fisher
fisher.test(BDTREINO$RACACORMAE,BDTREINO$Desfecho) # Fisher

# FICA

fisher.test(BDTREINO$GESTACAO,BDTREINO$Desfecho, simulate.p.value = TRUE) # Fisher
fisher.test(BDTREINO$GRAVIDEZ,BDTREINO$Desfecho) # Fisher
chisq.test(BDTREINO$CONSULTAS,BDTREINO$Desfecho, correct = TRUE) # Teste Chi Squared Corrigido
chisq.test(BDTREINO$IDANOMAL,BDTREINO$Desfecho, correct = TRUE) # Teste Chi Squared Corrigido

# IDADEMAE

boxplot(BDTREINO$IDADEMAE ~ BDTREINO$Desfecho, ylab = "Idade da mãe (em anos)")
plot(BDTREINO$IDADEMAE, BDTREINO$Desfecho, pch = 20)
tapply(BDTREINO$IDADEMAE,BDTREINO$Desfecho,summary)
tapply(BDTREINO$IDADEMAE,BDTREINO$Desfecho,sd)

bartlett.test(BDTREINO$IDADEMAE~BDTREINO$Desfecho)
qqnorm(BDTREINO$IDADEMAE)

library(nortest)
ks.test(BDTREINO$IDADEMAE, "pnorm")
lillie.test(BDTREINO$IDADEMAE)
shapiro.test(BDTREINO$IDADEMAE) 

wilcox.test(BDTREINO$IDADEMAE ~ BDTREINO$Desfecho) # Sai
#t.test(BDTREINO$IDADEMAE ~ BDTREINO$Desfecho)

# QTDFILVIVO

boxplot(BDTREINO$QTDFILVIVO ~ BDTREINO$Desfecho)
plot(BDTREINO$QTDFILVIVO, BDTREINO$Desfecho, pch = 20)
tapply(BDTREINO$QTDFILVIVO,BDTREINO$Desfecho,summary)
tapply(BDTREINO$QTDFILVIVO,BDTREINO$Desfecho,sd)

bartlett.test(BDTREINO$QTDFILVIVO~BDTREINO$Desfecho)
qqnorm(BDTREINO$QTDFILVIVO)

library(nortest)
ks.test(BDTREINO$QTDFILVIVO, "pnorm")
lillie.test(BDTREINO$QTDFILVIVO)
shapiro.test(BDTREINO$QTDFILVIVO) 

wilcox.test(BDTREINO$QTDFILVIVO ~ BDTREINO$Desfecho) #Sai
#t.test(BDTREINO$QTDFILVIVO ~ BDTREINO$Desfecho)

# QTDFILMORT

boxplot(BDTREINO$QTDFILMORT ~ BDTREINO$Desfecho)
plot(BDTREINO$QTDFILMORT, BDTREINO$Desfecho, pch = 20)
tapply(BDTREINO$QTDFILMORT,BDTREINO$Desfecho,summary)
tapply(BDTREINO$QTDFILMORT,BDTREINO$Desfecho,sd)

bartlett.test(BDTREINO$QTDFILMORT~BDTREINO$Desfecho)
qqnorm(BDTREINO$QTDFILMORT)

library(nortest)
ks.test(BDTREINO$QTDFILMORT, "pnorm")
lillie.test(BDTREINO$QTDFILMORT)
shapiro.test(BDTREINO$QTDFILMORT) 

wilcox.test(BDTREINO$QTDFILMORT ~ BDTREINO$Desfecho) #Sai
#t.test(BDTREINO$QTDFILMORT ~ BDTREINO$Desfecho)

# APGAR1

boxplot(BDTREINO$APGAR1 ~ BDTREINO$Desfecho)
plot(BDTREINO$APGAR1, BDTREINO$Desfecho, pch = 20)
tapply(BDTREINO$APGAR1,BDTREINO$Desfecho,summary)
tapply(BDTREINO$APGAR1,BDTREINO$Desfecho,sd)

bartlett.test(BDTREINO$APGAR1~BDTREINO$Desfecho)
qqnorm(BDTREINO$APGAR1)

library(nortest)
ks.test(BDTREINO$APGAR1, "pnorm")
lillie.test(BDTREINO$APGAR1)
shapiro.test(BDTREINO$APGAR1) 

wilcox.test(BDTREINO$APGAR1 ~ BDTREINO$Desfecho) #FICA
#t.test(BDTREINO$APGAR1 ~ BDTREINO$Desfecho)

# APGAR5

boxplot(BDTREINO$APGAR5 ~ BDTREINO$Desfecho)
plot(BDTREINO$APGAR5, BDTREINO$Desfecho, pch = 20)
tapply(BDTREINO$APGAR5,BDTREINO$Desfecho,summary)
tapply(BDTREINO$APGAR5,BDTREINO$Desfecho,sd)

bartlett.test(BDTREINO$APGAR5~BDTREINO$Desfecho)
qqnorm(BDTREINO$APGAR5)

library(nortest)
ks.test(BDTREINO$APGAR5, "pnorm")
lillie.test(BDTREINO$APGAR5)
shapiro.test(BDTREINO$APGAR5) 

wilcox.test(BDTREINO$APGAR5 ~ BDTREINO$Desfecho) #FICA
#t.test(BDTREINO$APGAR5 ~ BDTREINO$Desfecho)

# PESO

boxplot(BDTREINO$PESO ~ BDTREINO$Desfecho)
plot(BDTREINO$PESO, BDTREINO$Desfecho, pch = 20)
tapply(BDTREINO$PESO,BDTREINO$Desfecho,summary)
tapply(BDTREINO$PESO,BDTREINO$Desfecho,sd)

bartlett.test(BDTREINO$PESO~BDTREINO$Desfecho)
qqnorm(BDTREINO$PESO)

library(nortest)
ks.test(BDTREINO$PESO, "pnorm")
lillie.test(BDTREINO$PESO)
shapiro.test(BDTREINO$PESO) 

wilcox.test(BDTREINO$PESO ~ BDTREINO$Desfecho) #FICA
#t.test(BDTREINO$PESO ~ BDTREINO$Desfecho)

# QTDGESTANT

boxplot(BDTREINO$QTDGESTANT ~ BDTREINO$Desfecho)
plot(BDTREINO$QTDGESTANT, BDTREINO$Desfecho, pch = 20)
tapply(BDTREINO$QTDGESTANT,BDTREINO$Desfecho,summary)
tapply(BDTREINO$QTDGESTANT,BDTREINO$Desfecho,sd)

bartlett.test(BDTREINO$QTDGESTANT~BDTREINO$Desfecho)
qqnorm(BDTREINO$QTDGESTANT)

library(nortest)
ks.test(BDTREINO$QTDGESTANT, "pnorm")
lillie.test(BDTREINO$QTDGESTANT)
shapiro.test(BDTREINO$QTDGESTANT) 

wilcox.test(BDTREINO$QTDGESTANT ~ BDTREINO$Desfecho) #Sai
#t.test(BDTREINO$QTDGESTANT ~ BDTREINO$Desfecho)

# QTDPARTNOR

boxplot(BDTREINO$QTDPARTNOR ~ BDTREINO$Desfecho)
plot(BDTREINO$QTDPARTNOR, BDTREINO$Desfecho, pch = 20)
tapply(BDTREINO$QTDPARTNOR,BDTREINO$Desfecho,summary)
tapply(BDTREINO$QTDPARTNOR,BDTREINO$Desfecho,sd)

bartlett.test(BDTREINO$QTDPARTNOR~BDTREINO$Desfecho)
qqnorm(BDTREINO$QTDPARTNOR)

library(nortest)
ks.test(BDTREINO$QTDPARTNOR, "pnorm")
lillie.test(BDTREINO$QTDPARTNOR)
shapiro.test(BDTREINO$QTDPARTNOR) 

wilcox.test(BDTREINO$QTDPARTNOR ~ BDTREINO$Desfecho) #Sai
#t.test(BDTREINO$QTDPARTNOR ~ BDTREINO$Desfecho)

# QTDPARTNOR

boxplot(BDTREINO$QTDPARTNOR ~ BDTREINO$Desfecho)
plot(BDTREINO$QTDPARTNOR, BDTREINO$Desfecho, pch = 20)
tapply(BDTREINO$QTDPARTNOR,BDTREINO$Desfecho,summary)
tapply(BDTREINO$QTDPARTNOR,BDTREINO$Desfecho,sd)

bartlett.test(BDTREINO$QTDPARTNOR~BDTREINO$Desfecho)
qqnorm(BDTREINO$QTDPARTNOR)

library(nortest)
ks.test(BDTREINO$QTDPARTNOR, "pnorm")
lillie.test(BDTREINO$QTDPARTNOR)
shapiro.test(BDTREINO$QTDPARTNOR) 

wilcox.test(BDTREINO$QTDPARTNOR ~ BDTREINO$Desfecho) #Sai
#t.test(BDTREINO$QTDPARTNOR ~ BDTREINO$Desfecho)

# QTDPARTCES

boxplot(BDTREINO$QTDPARTCES~ BDTREINO$Desfecho)
plot(BDTREINO$QTDPARTCES, BDTREINO$Desfecho, pch = 20)
tapply(BDTREINO$QTDPARTCES,BDTREINO$Desfecho,summary)
tapply(BDTREINO$QTDPARTCES,BDTREINO$Desfecho,sd)

bartlett.test(BDTREINO$QTDPARTCES~BDTREINO$Desfecho)
qqnorm(BDTREINO$QTDPARTCES)

library(nortest)
ks.test(BDTREINO$QTDPARTCES, "pnorm")
lillie.test(BDTREINO$QTDPARTCES)
shapiro.test(BDTREINO$QTDPARTCES) 

wilcox.test(BDTREINO$QTDPARTCES~ BDTREINO$Desfecho) #Sai
#t.test(BDTREINO$QTDPARTCES~ BDTREINO$Desfecho)

# IDADEPAI

boxplot(BDTREINO$IDADEPAI~ BDTREINO$Desfecho)
plot(BDTREINO$IDADEPAI, BDTREINO$Desfecho, pch = 20)
tapply(BDTREINO$IDADEPAI,BDTREINO$Desfecho,summary)
tapply(BDTREINO$IDADEPAI,BDTREINO$Desfecho,sd)

bartlett.test(BDTREINO$IDADEPAI~BDTREINO$Desfecho)
qqnorm(BDTREINO$IDADEPAI)

library(nortest)
ks.test(BDTREINO$IDADEPAI, "pnorm")
lillie.test(BDTREINO$IDADEPAI)
shapiro.test(BDTREINO$IDADEPAI) 

wilcox.test(BDTREINO$IDADEPAI~ BDTREINO$Desfecho) #Sai
#t.test(BDTREINO$IDADEPAI~ BDTREINO$Desfecho)

BDTREINO <- BDTREINO[, -(which(colnames(BDTREINO) %in% 
                                 c("LOCNASC","ESTCIVMAE","ESCMAE","PARTO",
                                   "SEXO","RACACOR","RACACORMAE","IDADEMAE",
                                   "QTDFILVIVO","QTDFILMORT","QTDGESTANT",
                                   "QTDPARTNOR", "QTDPARTNOR","QTDPARTCES",
                                   "IDADEPAI"
                                 )))]

cor(BDTREINO[,(which(colnames(BDTREINO) %in% 
                       c("APGAR1","APGAR5","PESO"
                       )))], method = "spearman")

library(caTools) 
# Feature Scaling 
BDTREINO$APGAR1 = scale(BDTREINO$APGAR1)
BDTREINO$APGAR5 = scale(BDTREINO$APGAR5) 
BDTREINO$PESO = scale(BDTREINO$PESO) 

# Pré processamento dados de teste
BDTESTE <- BDTESTE[, (which(colnames(BDTESTE)%in%colnames(BDTREINO)))]

BDTESTE[(which(BDTESTE$GESTACAO == "9"))
        ,which(colnames(BDTESTE) %in% c("GESTACAO"))] <- as.numeric(Preproc[,which(colnames(Preproc) %in% "GESTACAO")])

BDTESTE[(which(BDTESTE$GRAVIDEZ == "9"))
        ,which(colnames(BDTESTE) %in% c("GRAVIDEZ"))] <- as.numeric(Preproc[,which(colnames(Preproc) %in% "GRAVIDEZ")])

BDTESTE[(which(BDTESTE$CONSULTAS == "9"))
         ,which(colnames(BDTESTE) %in% c("CONSULTAS"))] <- as.numeric(Preproc[,which(colnames(Preproc) %in% "CONSULTAS")])

BDTESTE[(which(is.na(BDTESTE$APGAR1)))
        ,which(colnames(BDTESTE) %in% c("APGAR1"))] <- as.numeric(Preproc[,which(colnames(Preproc) %in% "APGAR1")])

BDTESTE[(which(is.na(BDTESTE$APGAR5)))
        ,which(colnames(BDTESTE) %in% c("APGAR5"))] <-as.numeric(Preproc[,which(colnames(Preproc) %in% "APGAR5")])

BDTESTE[(which(BDTESTE$APGAR1 == "99"))
         ,which(colnames(BDTESTE) %in% c("APGAR1"))] <- as.numeric(Preproc[,which(colnames(Preproc) %in% "APGAR1")])

BDTESTE[(which(BDTESTE$APGAR5 == "99"))
         ,which(colnames(BDTESTE) %in% c("APGAR5"))] <-as.numeric(Preproc[,which(colnames(Preproc) %in% "APGAR5")])

BDTESTE[(which(is.na(BDTESTE$PESO)))
        ,which(colnames(BDTESTE) %in% c("PESO"))] <- as.numeric(Preproc[,which(colnames(Preproc) %in% "PESO")])

BDTESTE[(which(BDTESTE$IDANOMAL == 9))
        ,which(colnames(BDTESTE) %in% c("IDANOMAL"))] <- as.numeric(Preproc[,which(colnames(Preproc) %in% "IDANOMAL")])

cols_teste <- names(which(sapply(BDTREINO, is.factor)))

BDTESTE[cols_teste] <- lapply(BDTESTE[cols_teste], factor)  ## as.factor() could also be used

BDTESTE[!sapply(BDTESTE, is.factor)] <- lapply(BDTESTE[!sapply(BDTESTE, is.factor)],
                                               as.numeric)

BDTESTE$APGAR1 = scale(BDTESTE$APGAR1)
BDTESTE$APGAR5 = scale(BDTESTE$APGAR5) 
BDTESTE$PESO = scale(BDTESTE$PESO) 

# Fitting SVM to the Training set 
#install.packages('e1071') 
library(e1071) 

model_SVM = svm(formula = BDTREINO$Desfecho ~ ., 
                 data = BDTREINO, 
                 type = 'C-classification', 
                 kernel = 'linear') 

#install.packages("class")
require("class") # load pre-installed package

PREDKNN <- knn(train=BDTREINO[,-(which(colnames(BDTREINO) %in% "Desfecho"))],
              cl=BDTREINO$Desfecho, k=16,
              test = BDTESTE[,-(which(colnames(BDTESTE) %in% "Desfecho"))],
              prob = TRUE)

model_naiveBayes <- naiveBayes(BDTREINO[,(which(colnames(BDTREINO) %in% "Desfecho"))] ~ ., 
                               BDTREINO[,-(which(colnames(BDTREINO) %in% "Desfecho"))])
                               
PREDNB  <- predict(model_naiveBayes,BDTESTE[,-(which(colnames(BDTESTE) %in% "Desfecho"))])
PREDSVM <- predict(model_SVM, newdata = BDTESTE[,-(which(colnames(BDTESTE) %in% "Desfecho"))])

# SVM
predict_SVM <- as.numeric(levels(PREDSVM)[PREDSVM])
true_SVM <- as.numeric(levels(BDTESTE[,(which(colnames(BDTESTE) %in% "Desfecho"))])[BDTESTE[,(which(colnames(BDTREINO) %in% "Desfecho"))]])
retrieved_SVM <- sum(predict_SVM)
precision_SVM <- sum(predict_SVM & true_SVM) / retrieved_SVM
recall_SVM <- sum(predict_SVM & true_SVM) / sum(true_SVM)
Fmeasure_SVM <- 2 * precision_SVM * recall_SVM / (precision_SVM + recall_SVM)
precision_SVM; recall_SVM; Fmeasure_SVM

# KNN
predict_KNN <- as.numeric(levels(PREDKNN)[PREDKNN])
true_KNN <- as.numeric(levels(BDTESTE[,(which(colnames(BDTESTE) %in% "Desfecho"))])[BDTESTE[,(which(colnames(BDTREINO) %in% "Desfecho"))]])
retrieved_KNN <- sum(predict_KNN)
precision_KNN <- sum(predict_KNN & true_KNN) / retrieved_KNN
recall_KNN <- sum(predict_KNN & true_KNN) / sum(true_KNN)
Fmeasure_KNN <- 2 * precision_KNN * recall_KNN / (precision_KNN + recall_KNN)
precision_KNN; recall_KNN; Fmeasure_KNN 

# NB
predict_NB <- as.numeric(levels(PREDNB)[PREDNB])
true_NB <- as.numeric(levels(BDTESTE[,(which(colnames(BDTESTE) %in% "Desfecho"))])[BDTESTE[,(which(colnames(BDTREINO) %in% "Desfecho"))]])
retrieved_NB <- sum(predict_NB)
precision_NB <- sum(predict_NB & true_NB) / retrieved_NB
recall_NB <- sum(predict_NB & true_NB) / sum(true_NB)
Fmeasure_NB <- 2 * precision_NB * recall_NB / (precision_NB + recall_NB)
precision_NB; recall_NB; Fmeasure_NB 

#############################
######### CURVA ROC #########
#############################

#install.packages("pROC")
library(pROC)
desfecho <- as.numeric(levels(BDTESTE[,(which(colnames(BDTESTE) %in% "Desfecho"))])[BDTESTE[,(which(colnames(BDTESTE) %in% "Desfecho"))]])

pred_SVM <- as.numeric(levels(PREDSVM)[PREDSVM])
pred_KNN <- as.numeric(levels(PREDKNN)[PREDKNN])
pred_NB <- as.numeric(levels(PREDNB)[PREDNB])

roc_SVM <- roc(desfecho ~ pred_SVM)
roc_KNN <- roc(desfecho ~ pred_KNN)
roc_NB <- roc(desfecho ~ pred_NB)

plot.roc(roc_SVM, legacy.axes=TRUE,lwd=2,xlab="1 -  especificidade",
         ylab="Sensibilidade",cex.axis=1.2,cex.lab=1.2,print.auc = TRUE)

plot.roc(roc_KNN, legacy.axes=TRUE,lwd=2,xlab="1 -  especificidade",
         ylab="Sensibilidade",cex.axis=1.2,cex.lab=1.2,print.auc = TRUE)

plot.roc(roc_NB, legacy.axes=TRUE,lwd=2,xlab="1 -  especificidade",
         ylab="Sensibilidade",cex.axis=1.2,cex.lab=1.2,print.auc = TRUE)

###########################
#### MATRIZ DE CONFUSÃO ###
###########################

mat_conf_SVM <- table(BDTESTE[,(which(colnames(BDTESTE) %in% "Desfecho"))],
                      as.numeric(PREDSVM));mat_conf_SVM

prop_acerto_SVM <- sum(diag(mat_conf_SVM))/nrow(BDTESTE);prop_acerto_SVM
