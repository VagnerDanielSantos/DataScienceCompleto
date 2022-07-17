
# Feature Selection -- Este código contém comandos para Feature Selection.

## Este código foi criado para executar tanto no Azure quanto no RStudio.
## Para executar no Azure, é necessário alterar o valor da variável "Azure" para TRUE.
## Se o valor for FALSE, o código será executado no RStudio

# Obs: Caso tenha problemas com a acentuação, consulte este link:
# https://support.rstudio.com/hc/en-us/articles/200532197-Character-Encoding

# Configura o diretório de trabalho
# Coloque entre aspas o diretório de trabalho que você está usando no seu computador
# Não use diretórios com espaço no nome

setwd("D:/BigDataAnalytics/Capitulo14")
getwd()

# Variável que controla a execução do Script

Azure <- FALSE

if(Azure)
{
  source('src/Tools.R')
  bikes <- maml.mapInputPort(1)
  bikes$dteday <- set.asPOSIXct(bikes)
}else
{
  bikes <- bikes
}

dim(bikes)
any(is.na(bikes))

# Cria um modelo para identificar os atributos com maior importância para o modelo preditivo.

install.packages('randomForest')
library(randomForest)

# Avalia a importância de todas as variáveis

modelo01 <- randomForest(cnt ~ .,
                         data = bikes,
                         ntree = 100,
                         nodesize = 10,
                         importance = TRUE)

# Remove variáveis colineares

modelo01 <- randomForest(cnt ~ .
                         - mnth
                         - hr
                         - workingday
                         - isworking
                         - dayweek
                         - xformHr
                         - workTime
                         - holiday
                         - windspeed
                         - monthCount
                         - weathersit,
                         data = bikes,
                         ntree = 100,
                         nodesize = 10,
                         importance = TRUE)

# Plota as variáveis por grau de importância

varImpPlot(modelo01)

# Grava o resultado

dataframe_saida <- bikes[ , c('cnt', rownames(modelo01$importance))]

# Gera saída no Azure Machine Learning

if(Azure) maml.mapOutputPort('bikes')
