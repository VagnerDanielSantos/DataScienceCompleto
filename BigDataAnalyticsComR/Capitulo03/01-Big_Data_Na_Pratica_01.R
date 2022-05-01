
# Big Data na prática 01 - Analisando a Temperatura média nas cidades brasileiras

# Obs: Caso tenha problemas com a acentuação, consulte este link:
# https://support.rstudio.com/hc/en-us/articles/200532197-Character-Encoding

# Configurando o diretório de trabalho
# Coloque entre aspas o diretório de trabalho que você está usando no seu computador
# Não use diretórios com espaço no nome

setwd("D:/BigDataAnalytics/Capitulo03")
getwd()

#### Dataset:
# Berkeley Earth
# http://berkeleyearth.org/data
# TemperaturasGlobais.csv ~ 78 MB (zip) ~ 496 MB (unzip)
# Faça o download do arquivo zip no link abaixo e descompacte na mesma pasta onde 
# está este script. 
# https://drive.google.com/open?id=1nSwP3Y0V7gncbnG_DccNhrTRxmUNqMqa

# Instala e Carrega os pacotes
# Obs: os pacotes precisam ser instalados apenas uma vez. 
# Se já instalou em outros scripts, não é necessário instalar novamente!

install.packages("readr")
install.packages("data.table")
install.packages("dplyr")
install.packages("ggplot2")
library(readr)
library(dplyr)
library(ggplot2)
library(scales)
library(data.table)


# Carrega os dados (Usando um timer para comparar o tempo de carregamento com diferentes funções)

# Função read.csv2()
system.time(df_teste01 <- read.csv2("D:/BigDataAnalytics/Capitulo03/Arquivos/TemperaturasGlobais.csv"))

# Função read.table()
system.time(df_teste02 <- read.table("D:/BigDataAnalytics/Capitulo03/Arquivos/TemperaturasGlobais.csv"))

# Função fread()
?fread
system.time(df_teste03 <- fread("D:/BigDataAnalytics/Capitulo03/Arquivos/TemperaturasGlobais.csv"))

# Cria um subsets dos Dados carregados

cidadesBrasil <- subset(df, Country == 'Brazil')
cidadesBrasil <- na.omit(cidadesBrasil)
head(cidadesBrasil)
nrow(df)
nrow(cidadesBrasil)
dim(cidadesBrasil)


# Preparaçãoe e Organização

# Converte as Datas

cidadesBrasil$dt <- as.POSIXct(cidadesBrasil$dt,format='%Y-%m-%d')
cidadesBrasil$Month <- month(cidadesBrasil$dt)
cidadesBrasil$Year <- year(cidadesBrasil$dt)

# Carrega os subsets

# Palmas
plm <- subset(cidadesBrasil, City == 'Palmas')
plm <- subset(plm, Year %in% c(1796,1846,1896,1946,1996,2012))

# Curitiba
crt <- subset(cidadesBrasil, City == 'Curitiba')
crt <- subset(crt, Year %in% c(1796,1846,1896,1946,1996,2012))

# Recife
recf <- subset(cidadesBrasil, City=='Recife')
recf <- subset(recf,Year %in% c(1796,1846,1896,1946,1996,2012))


# Constroi os Plots

plot_plm <- ggplot(plm, aes(x = (Month), y = AverageTemperature, color = as.factor(Year))) +
  geom_smooth(se = FALSE,fill = NA, size = 2) +
  theme_light(base_size = 20) +
  xlab("Mês")+
  ylab("Temperatura Média") +
  scale_color_discrete("") +
  ggtitle("Temperatura média ao longo dos anos em Palmas") +
  theme(plot.title = element_text(size = 18))

plot_crt <- ggplot(crt, aes(x = (Month), y = AverageTemperature, color = as.factor(Year))) +
  geom_smooth(se = FALSE,fill = NA, size = 2) +
  theme_light(base_size = 20) +
  xlab("Mês")+
  ylab("Temperatura") +
  scale_color_discrete("") +
  ggtitle("Temperatura média ao longo dos anos em Curitiba") +
  theme(plot.title = element_text(size = 18))

plot_recf <- ggplot(recf, aes(x = (Month), y = AverageTemperature, color = as.factor(Year))) +
  geom_smooth(se = FALSE,fill = NA, size = 2) +
  theme_light(base_size = 20) +
  xlab("Mês")+
  ylab("Temperatura Média") +
  scale_color_discrete("") +
  ggtitle("Temperatura média ao longo dos anos em Recife") +
  theme(plot.title = element_text(size = 18))


# Plotagem

plot_plm

plot_crt

plot_recf
