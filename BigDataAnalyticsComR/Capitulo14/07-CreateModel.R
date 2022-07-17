
# Cria um modelo preditivo usando RandomForest

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

## Função para tratar as Datas

set.asPOSIXct <- function(inFrame) { 
  dteday <- as.POSIXct(
    as.integer(inFrame$dteday), 
    origin = "1970-01-01")
  
  as.POSIXct(strptime(
    paste(as.character(dteday), 
          " ", 
          as.character(inFrame$hr),
          ":00:00", 
          sep = ""), 
    "%Y-%m-%d %H:%M:%S"))
}

char.toPOSIXct <-   function(inFrame) {
  as.POSIXct(strptime(
    paste(inFrame$dteday, " ", 
          as.character(inFrame$hr),
          ":00:00", 
          sep = ""), 
    "%Y-%m-%d %H:%M:%S")) }


set.asPOSIXct2 <- function(inFrame) { 
  dteday <- as.POSIXct(
    as.integer(inFrame$dteday), 
    origin = "1970-01-01")
}

# Variável que controla a execução do Script

Azure <- FALSE

if(Azure)
  {
    dataset$dteday <- set.asPOSIXct(dataset)
  }else
  {
    bikes <- bikes
  }

# Instala e Carrega pacote 

install.packages('randomForest')
require(randomForest)

# Cria o modelo

modelo01 <- randomForest(cnt ~ xformworkHr + dteday + temp + hum,
                         data = bikes, # Alterar o nome do objeto data para 'dataset' se estiver trabalhando no Azure Machine Learning
                         ntree = 40,
                         nodesize = 5)

print(modelo01)
