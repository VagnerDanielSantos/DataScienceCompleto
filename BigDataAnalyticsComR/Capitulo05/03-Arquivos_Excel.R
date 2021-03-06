
# Manipula��o de Arquivos Excel

# Obs: Caso tenha problemas com a acentua��o, consulte este link:
# https://support.rstudio.com/hc/en-us/articles/200532197-Character-Encoding

# Configurando o diret�rio de trabalho
# Coloque entre aspas o diret�rio de trabalho que voc� est� usando no seu computador
# N�o use diret�rios com espa�o no nome

setwd("D:/BigDataAnalytics/Capitulo05")
getwd()

# Instalar o Java - JDK 
# https://www.oracle.com/technetwork/java/javase/downloads/index.html

# Windows
# Fa�a o download do JDK gratuitamente no site da Oracle
# Instale no seu computador
# Configure a vari�vel de ambiente JAVA_HOME apontantando para o diret�rio de instala��o do JDK
# Inclua o diret�rio JAVA_HOME/bin na vari�vel de ambiente PATH

# Mac e Linux
# Fa�a o download do JDK gratuitamente no site da Oracle
# Instale no seu computador
# Abra um terminal e execute: sudo R CMD javareconf

# ********** Pacotes que requerem Java **********
# XLConnect
# xlsx
# rJava 

# ********** Pacotes que requerem Perl **********
# � necess�rio instalar o interpretador da linguagem Perl e adicionar o diret�rio bin da instala��o do Perl
# na vari�vel de ambiente PATH
# Download: https://www.activestate.com/products/activeperl/

# gdata

# Instala os pacotes

install.packages('rJava')
install.packages("xlsx")
install.packages("XLConnect")
install.packages("readxl")
install.packages("gdata")

# Este pacote deve estar carregado para poder usar todos os pacotes que requerem Java

library(rJava)

# Obs: Ao carregar todos os pacotes que manipulam excel, pode gerar problema de namespace, 
# pois alguns pacotes possuem o mesmo nome de fun��es (que s�o diferentes entre os pacotes). 
# Para evitar problemas, carregue e use os pacotes de forma individual 
# (n�o carregue todos os pacotes de uma �nica vez).

# Pacote readxl

library(readxl)

# Lista as worksheet no arquivo Excel

excel_sheets("UrbanPop.xlsx")

# Lendo a planilha do Excel
read_excel("UrbanPop.xlsx")
head(read_excel("UrbanPop.xlsx"))
read_excel("UrbanPop.xlsx", sheet = "Period2")
read_excel("UrbanPop.xlsx", sheet = 3)
read_excel("UrbanPop.xlsx", sheet = 4)

# Importando uma worksheet para um dataframe
dataframe01 <- read_excel("D:/BigDataAnalytics/Capitulo05/Arquivos/UrbanPop.xlsx", sheet = 3)
View(dataframe01)

# Importando todas as worksheets

dataframe_todas <- lapply(excel_sheets("D:/BigDataAnalytics/Capitulo05/Arquivos/UrbanPop.xlsx"), 
                   read_excel, 
                   path = 'D:/BigDataAnalytics/Capitulo05/Arquivos/UrbanPop.xlsx')

View(dataframe_todas)
class(dataframe_todas)


# Pacote XLConnect

detach(package:readxl)
library(XLConnect)

# Namespace

arquivo01 = XLConnect::loadWorkbook("D:/BigDataAnalytics/Capitulo05/Arquivos/UrbanPop.xlsx")

dataframe02 <- readWorksheet(arquivo01, 
                             sheet = "D:/BigDataAnalytics/Capitulo05/Arquivos/Period1", 
                             header = TRUE)

View(dataframe02)
class(dataframe02)

# Pacote xlsx
detach(package:XLConnect)
library(xlsx)
?xlsx

?read.xlsx

dataframe03 <- read.xlsx("D:/BigDataAnalytics/Capitulo05/Arquivos/UrbanPop.xlsx", 
                         sheetIndex = 1)

View(dataframe03)
class(dataframe03)


# Pacote gdata

detach(package:xlsx)
library(gdata)

arquivo02 <- xls2csv("D:/BigDataAnalytics/Capitulo05/Arquivos/planilha1.xlsx",
              sheet = 1,
              na.strings = "EMPTY")

View(arquivo02)
read.csv(arquivo02)
