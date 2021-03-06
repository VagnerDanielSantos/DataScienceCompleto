
# Big Data na pr�tica - An�lise de s�ries Temporais no Mercado Financeiro

# Obs: Caso tenha problemas com a acentua��o, consulte este link:
# https://support.rstudio.com/hc/en-us/articles/200532197-Character-Encoding

# Configurando o diret�rio de trabalho
# Coloque entre aspas o diret�rio de trabalho que voc� est� usando no seu computador
# N�o use diret�rios com espa�o no nome

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


# Sele��o do per�odo de an�lise

startDate = as.Date("2022-01-02")
endDate = as.Date("2022-04-20")


# Download dos dados do per�odo
# Obs: O Yahoo Finance est� passando por mudan�as 
# e o servi�o de cota��es online pode estar inst�vel

?getSymbols

getSymbols("PETR4.SA", src = "yahoo", from = startDate, to = endDate, auto.assign = T)
# PETR4.SA = readRDS("PETR4.SA.rds")


# Checa o tipo de Dado retornado

class(PETR4.SA)
is.xts(PETR4.SA)


# Mostra os primeiros registros para as a��es da Petrobr�s

head(PETR4.SA)
View(PETR4.SA)


# Analisa os Dados de fechamento 

PETR4.SA.Close <- PETR4.SA[, "PETR4.SA.Close"]
is.xts(PETR4.SA.Close)

?Cl

head(Cl(PETR4.SA),5)


# Agora, vamos plotar o gr�fico da Petrobr�s
# Gr�fico de candlestick da Petrobras

?candleChart

candleChart(PETR4.SA)


# Plot do fechamento

plot(PETR4.SA.Close, main = "Fechamento di�rio das a��es da Petrobr�s",
     col = "red", xlab = "Data", ylab = "Pre�o", major.ticks = 'months',
     minor.ticks = FALSE)


# Adiciona as bandas de bollinger ao gr�fico, com m�dia de 20 per�odos e 2 desvios
# Bollinger Band
# Como o desvio padr�o � uma medida de volatilidade, 
# Bollinger Bands ajustam-se �s condi��es de mercado. Mercados mais vol�teis, 
# possuem as bandas mais distantes da m�dia, enquanto mercados menos vol�teis possuem as
# bancas mais pr�ximas da m�dia.

?addBBands

addBBands(n = 20, sd = 2)


# Adicionando o indicador ADX, m�dia 11 do tipo exponencial

?addADX

addADX(n = 11, maType = "EMA")


# Calcula logs di�rios

?log

PETR4.SA.ret <- diff(log(PETR4.SA.Close), lag = 1)


# Remove valores "NA" na posi��o 1

PETR4.SA.ret <- PETR4.SA.ret[-1] 


# Plota a taxa de retorno

plot(PETR4.SA.ret, main = "Fechamento di�rio das a��es da Petrobr�s",
     col = "red", xlab = "Data", ylab = "Retorno", major.ticks = 'months',
     minor.ticks = FALSE)


# Calcula algumas medidas estat�sticas

statNames <- c("Mean", "Standard Deviation", "Skewness", "Kurtosis")

PETR4.SA.stats <- c(mean(PETR4.SA.ret), sd(PETR4.SA.ret), skewness(PETR4.SA.ret), kurtosis(PETR4.SA.ret))
names(PETR4.SA.stats) <- statNames
PETR4.SA.stats


# Salva os Dados em um arquivo .rds (arquivo em formato bin�rio do R)
# getSymbols("PETR4.SA", src = 'yahoo')

saveRDS(PETR4.SA, file = "D:/BigDataAnalytics/Capitulo07/Arquivos/PETR4.SA.rds") # Salva os dados em formato bin�rio
Ptr = readRDS("D:/BigDataAnalytics/Capitulo07/Arquivos/PETR4.SA.rds")
dir("D:/BigDataAnalytics/Capitulo07/Arquivos")
head(Ptr)
View(Ptr)
