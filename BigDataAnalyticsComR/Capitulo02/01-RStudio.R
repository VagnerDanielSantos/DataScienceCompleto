
# Primeiros Passos na Linguagem R

# Obs: Caso tenha problemas com a acentua��o, consulte este link:
# https://support.rstudio.com/hc/en-us/articles/200532197-Character-Encoding

# Configurando o diret�rio de trabalho
# Coloque entre aspas o diret�rio de trabalho que voc� est� usando no seu computador
# N�o use diret�rios com espa�o no nome

setwd("D:/BigDataAnalytics/Capitulo02")
getwd()


# Nome dos Contributors

contributors()

# Licen�a

license()

# Informa��es sobre a sess�o

sessionInfo()

# Imprimir na tela

print('Estou iniciando minha caminhada na carreira de Cientista de Dados')


# Criar gr�ficos
plot(1:25)


# Instalar pacotes

install.packages('randomForest')
install.packages('ggplot2')
install.packages("dplyr")
install.packages("devtools")

# Carregar o pacote

library(ggplot2)

# Descarregar o pacote

detach(package:ggplot2)


# Se souber o nome da fun��o

help(mean)
?mean

# Para buscar mais op��es sobre uma fun��o, use o pacote SOS

install.packages("sos")
library(sos)
findFn("fread")


# Se n�o souber o nome da fun��o

help.search('randomForest')
help.search('matplot')
??matplot
RSiteSearch('matplot')
example('matplot')


# Sair

q()
