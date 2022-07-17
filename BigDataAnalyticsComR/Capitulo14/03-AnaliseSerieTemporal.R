
# Análise de Série Temporal - Este código contém comandos para análise de Série Temporal.

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

# Avalia a demanda por aluguel de bikes ao longo do tempo.
# Contrói uma Time-Series plot para alguns determinados horários em dias
# úteis e final de semana.

# Vetor que representa algumas horas do dia

times <- c(6, 7, 8, 9, 12, 15, 18, 20, 22, 23)

# Time Series Plot

install.packages('ggplot2')
library(ggplot2)

plotseries.plot <- function(times)
  {
    ggplot(bikes[bikes$workTime == times, ], aes(x = dteday, y = cnt)) +
    geom_line() +
    ylab('Número de Bikes') +
    labs(title = paste('Demanda de Bikes às: ', as.character(times), ':00', sep = "")) +
    theme(text = element_text(size = 20))
  }

lapply(times, plotseries.plot)

# Gera saída no Azure Machine Learning

if(Azure) maml.mapOutputPort('bikes')
