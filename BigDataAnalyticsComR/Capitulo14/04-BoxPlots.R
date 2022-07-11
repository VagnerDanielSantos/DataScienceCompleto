
# Análisa BoxPlots.

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
  bikes <- manl.mapInputPort(1)
  bikes$dteday <- set.asPOSIXct(bikes)
}else
{
  bikes <- bikes
}

# Converte a variável "dayweek" para fator ordenado e plota em ordem de tempo.

bikes$dayweek <- fact.conv(bikes$dayweek)

# Demanda de bikes x potenciais variáveis preditoras.

labels <- list('Boxplots - Demanda de Bikes por Hora', 
               'Boxplots - Demanda de Bikes por Estação',
               'Boxplots - Demanda de Bikes por Dia Útil',
               'Boxplots - Demanda de Bikes por Dia da Semana')

xAxis <- list('hr', 'weathersit', 'isworking', 'dayweek')

# Função para criar os BoxPlots

plot.boxes <- function(X, label)
  {
    ggplot(bikes, aes_string(x = X, y = 'cnt', group = X)) +
    geom_boxplot() +
    ggtitle(label) +
    theme(text = element_text(size = 18))
  }

Map(plot.boxes, xAxis, labels)

# Gera saída no Azure Machine Learning

if(Azure) maml.mapOutputPort('bikes')
