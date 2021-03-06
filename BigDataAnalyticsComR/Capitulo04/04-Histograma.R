
# Histogramas

# Obs: Caso tenha problemas com a acentua��o, consulte este link:
# https://support.rstudio.com/hc/en-us/articles/200532197-Character-Encoding

# Configurando o diret�rio de trabalho
# Coloque entre aspas o diret�rio de trabalho que voc� est� usando no seu computador
# N�o use diret�rios com espa�o no nome

setwd("D:/BigDataAnalytics/Capitulo04")
getwd()

# Define os dados

?cars

View(cars)
dados = cars$speed

# Constr�i um histograma

?hist

hist(dados)


# Conforme consta no help, o par�metro breaks pode ser um dos itens abaixo:

# Um vetor para os pontos de quebra entre as c�lulas do histograma
# Uma fun��o para calcular o vetor de breakpoints
# Um �nico n�mero que representa o n�mero de c�lulas para o histograma
# Uma cadeia de caracteres que nomeia um algoritmo para calcular o n�mero de c�lulas 
# Uma fun��o para calcular o n�mero de c�lulas.

hist(dados, breaks = 10, main = "Histograma das Velocidades")
hist(dados, labels = T, breaks = c(0,5,10,20,30), main = "Histograma das Velocidades")
hist(dados, labels = T, breaks = 10, main = "Histograma das Velocidades")
hist(dados, labels = T, ylim = c(0,10), breaks = 10, main = "Histograma das Velocidades")


# Adiciona linhas ao histograma

grafico <- hist(dados, breaks = 10, main = "Histograma das Velocidades")

xaxis = seq(min(dados), max(dados), length = 10)
yaxis = dnorm(xaxis, mean = mean(dados), sd = sd(dados))
yaxis = yaxis * diff(grafico$mids) * length(dados)

lines(xaxis, yaxis, col = "gainsboro")
