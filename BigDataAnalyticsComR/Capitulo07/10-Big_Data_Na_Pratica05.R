
# Big Data na prática - Análise de séries Temporais no Mercado Financeiro

# Obs: Caso tenha problemas com a acentuação, consulte este link:
# https://support.rstudio.com/hc/en-us/articles/200532197-Character-Encoding

# Configurando o diretório de trabalho
# Coloque entre aspas o diretório de trabalho que você está usando no seu computador
# Não use diretórios com espaço no nome

setwd("D:/BigDataAnalytics/Capitulo07")
getwd()

# http://www.quantmod.com


# Instala e carrega os pacotes

install.packages("quantmod")
install.packages("xts")
install.packages("moments")
library(quantmod)
library(xts)
library(moments)


# Seleção do período de análise

startDate = as.Date("2022-01-02")
endDate = as.Date("2022-04-20")


# Download dos dados do período
# Obs: O Yahoo Finance está passando por mudanças 
# e o serviço de cotações online pode estar instável

?getSymbols

getSymbols("PETR4.SA", src = "yahoo", from = startDate, to = endDate, auto.assign = T)
# PETR4.SA = readRDS("PETR4.SA.rds")


# Checa o tipo de Dado retornado

class(PETR4.SA)
is.xts(PETR4.SA)


# Mostra os primeiros registros para as ações da Petrobrás

head(PETR4.SA)
View(PETR4.SA)


# Analisa os Dados de fechamento 

PETR4.SA.Close <- PETR4.SA[, "PETR4.SA.Close"]
is.xts(PETR4.SA.Close)

?Cl

head(Cl(PETR4.SA),5)


# Agora, vamos plotar o gráfico da Petrobrás
# Gráfico de candlestick da Petrobras

?candleChart

candleChart(PETR4.SA)


# Plot do fechamento

plot(PETR4.SA.Close, main = "Fechamento diário das ações da Petrobrás",
     col = "red", xlab = "Data", ylab = "Preço", major.ticks = 'months',
     minor.ticks = FALSE)


# Adiciona as bandas de bollinger ao gráfico, com média de 20 períodos e 2 desvios
# Bollinger Band
# Como o desvio padrão é uma medida de volatilidade, 
# Bollinger Bands ajustam-se ás condições de mercado. Mercados mais voláteis, 
# possuem as bandas mais distantes da média, enquanto mercados menos voláteis possuem as
# bancas mais próximas da média.

?addBBands

addBBands(n = 20, sd = 2)


# Adicionando o indicador ADX, média 11 do tipo exponencial

?addADX

addADX(n = 11, maType = "EMA")


# Calcula logs diários

?log

PETR4.SA.ret <- diff(log(PETR4.SA.Close), lag = 1)


# Remove valores "NA" na posição 1

PETR4.SA.ret <- PETR4.SA.ret[-1] 


# Plota a taxa de retorno

plot(PETR4.SA.ret, main = "Fechamento diário das ações da Petrobrás",
     col = "red", xlab = "Data", ylab = "Retorno", major.ticks = 'months',
     minor.ticks = FALSE)


# Calcula algumas medidas estatísticas

statNames <- c("Mean", "Standard Deviation", "Skewness", "Kurtosis")

PETR4.SA.stats <- c(mean(PETR4.SA.ret), sd(PETR4.SA.ret), skewness(PETR4.SA.ret), kurtosis(PETR4.SA.ret))
names(PETR4.SA.stats) <- statNames
PETR4.SA.stats


# Salva os Dados em um arquivo .rds (arquivo em formato binário do R)
# getSymbols("PETR4.SA", src = 'yahoo')

saveRDS(PETR4.SA, file = "D:/BigDataAnalytics/Capitulo07/Arquivos/PETR4.SA.rds") # Salva os dados em formato binário
Ptr = readRDS("D:/BigDataAnalytics/Capitulo07/Arquivos/PETR4.SA.rds")
dir("D:/BigDataAnalytics/Capitulo07/Arquivos")
head(Ptr)
View(Ptr)
