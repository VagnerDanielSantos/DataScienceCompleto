
# Análise de Correlação - Este código contém comandos para análise de correlação.

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

View(bikes)

# Define as colunas para a análise de correlação

cols <- c('mnth', 'hr', 'holiday', 'workingday', 'weathersit', 'temp', 'xformHr', 'workTime',
          'hum', 'windspeed', 'isworking', 'monthCount', 'dayweek', 'cnt')

##### MÉTODOS DE CORRELAÇÃO #####

## PEARSON ==> Coeficiente usado para medir o grau de relacionamento entre duas
# variáveis com relação linear.

## SPEARMAN ==> Teste não paramétrico, para medir o grau de relacionamento entre 
# duas variáveis.

## KENDALL ==> Teste não paramétrico, para medir a força de dependência entre 
# duas variáveis.

# Vetor com os métodos de correlação

metodos <- c('pearson', 'spearman')

# Aplica os métodos de Correlação com a Função 'cor()'

correlacao <- lapply(metodos, function(method)
  (cor(bikes[ , cols], method = method)))

head(correlacao)

# Prepara o PLOT

install.packages('lattice')
library(lattice)

plot.correlacao <- function(x, labs)
  {
    diag(x) <- 0.0
    plot(levelplot(x,
                   main = paste('Plot de Correlação usando Método', labs),
                   scales = list(x = list(rot = 90), cex = 1.0)))
}

# Mapa de Correlação

Map(plot.correlacao, correlacao, metodos)

# Gera saída no Azure Machine Learning

if(Azure) maml.mapOutputPort('bikes')
