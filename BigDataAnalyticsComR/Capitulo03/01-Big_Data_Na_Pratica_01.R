
# Big Data na pr�tica 01 - Analisando a Temperatura m�dia nas cidades brasileiras

# Obs: Caso tenha problemas com a acentua��o, consulte este link:
# https://support.rstudio.com/hc/en-us/articles/200532197-Character-Encoding

# Configurando o diret�rio de trabalho
# Coloque entre aspas o diret�rio de trabalho que voc� est� usando no seu computador
# N�o use diret�rios com espa�o no nome

setwd("D:/BigDataAnalytics/Capitulo03")
getwd()

#### Dataset:
# Berkeley Earth
# http://berkeleyearth.org/data
# TemperaturasGlobais.csv ~ 78 MB (zip) ~ 496 MB (unzip)
# Fa�a o download do arquivo zip no link abaixo e descompacte na mesma pasta onde 
# est� este script. 
# https://drive.google.com/open?id=1nSwP3Y0V7gncbnG_DccNhrTRxmUNqMqa

# Instala e Carrega os pacotes
# Obs: os pacotes precisam ser instalados apenas uma vez. 
# Se j� instalou em outros scripts, n�o � necess�rio instalar novamente!

install.packages("readr")
install.packages("data.table")
install.packages("dplyr")
install.packages("ggplot2")
library(readr)
library(dplyr)
library(ggplot2)
library(scales)
library(data.table)


# Carrega os dados (Usando um timer para comparar o tempo de carregamento com diferentes fun��es)

# Fun��o read.csv2()
system.time(df_teste01 <- read.csv2("D:/BigDataAnalytics/Capitulo03/Arquivos/TemperaturasGlobais.csv"))

# Fun��o read.table()
system.time(df_teste02 <- read.table("D:/BigDataAnalytics/Capitulo03/Arquivos/TemperaturasGlobais.csv"))

# Fun��o fread()
?fread
system.time(df_teste03 <- fread("D:/BigDataAnalytics/Capitulo03/Arquivos/TemperaturasGlobais.csv"))

# Cria um subsets dos Dados carregados

cidadesBrasil <- subset(df, Country == 'Brazil')
cidadesBrasil <- na.omit(cidadesBrasil)
head(cidadesBrasil)
nrow(df)
nrow(cidadesBrasil)
dim(cidadesBrasil)


# Prepara��oe e Organiza��o

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
  xlab("M�s")+
  ylab("Temperatura M�dia") +
  scale_color_discrete("") +
  ggtitle("Temperatura m�dia ao longo dos anos em Palmas") +
  theme(plot.title = element_text(size = 18))

plot_crt <- ggplot(crt, aes(x = (Month), y = AverageTemperature, color = as.factor(Year))) +
  geom_smooth(se = FALSE,fill = NA, size = 2) +
  theme_light(base_size = 20) +
  xlab("M�s")+
  ylab("Temperatura") +
  scale_color_discrete("") +
  ggtitle("Temperatura m�dia ao longo dos anos em Curitiba") +
  theme(plot.title = element_text(size = 18))

plot_recf <- ggplot(recf, aes(x = (Month), y = AverageTemperature, color = as.factor(Year))) +
  geom_smooth(se = FALSE,fill = NA, size = 2) +
  theme_light(base_size = 20) +
  xlab("M�s")+
  ylab("Temperatura M�dia") +
  scale_color_discrete("") +
  ggtitle("Temperatura m�dia ao longo dos anos em Recife") +
  theme(plot.title = element_text(size = 18))


# Plotagem

plot_plm

plot_crt

plot_recf
