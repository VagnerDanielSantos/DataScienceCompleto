
# Este código contém comandos para filtrar e plotar os dados de aluguel de bikes, 
# dados que estao em nosso dataset
# Este codigo foi criado para executar tanto no Azure, quanto no RStudio.
# Para executar no Azure, altere o valor da variavel Azure para TRUE. Se o valor for FALSE, o codigo sera executado no RStudio.

# Obs: Caso tenha problemas com a acentuação, consulte este link:
# https://support.rstudio.com/hc/en-us/articles/200532197-Character-Encoding

# Configurando o diretório de trabalho
# Coloque entre aspas o diretório de trabalho que você está usando no seu computador
# Não use diretórios com espaço no nome

setwd("D:/BigDataAnalytics/Capitulo13")
getwd()

# Variável que controla a execução do script

Azure <- FALSE

if(Azure){
  source("src/Tools.R")
  Bikes <- maml.mapInputPort(1)
  Bikes$dteday <- set.asPOSIXct(Bikes)
}else{
  source("D:/BigDataAnalytics/Capitulo13/Arquivos/Tools.R")
  Bikes <- read.csv("D:/BigDataAnalytics/Capitulo13/Arquivos/bikes.csv", 
                    sep = ",", 
                    header = T, 
                    stringsAsFactors = F )
  
  Bikes$dteday <- char.toPOSIXct(Bikes)
}

install.packages('dplyr')
require(dplyr)

Bikes <- Bikes %>% filter(hr == 9)

# ggplot2

install.packages('ggplot2')
require(ggplot2)

ggplot(Bikes, aes(x = dteday, y = cnt)) +
  geom_line() +
  ylab("Numero de Bikes") +
  xlab("Linha do Tempo") +
  ggtitle("Demanda por Bikes as 09:00") +
  theme(text = element_text(size = 20))
