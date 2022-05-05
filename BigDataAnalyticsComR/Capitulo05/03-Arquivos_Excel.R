
# Manipulação de Arquivos Excel

# Obs: Caso tenha problemas com a acentuação, consulte este link:
# https://support.rstudio.com/hc/en-us/articles/200532197-Character-Encoding

# Configurando o diretório de trabalho
# Coloque entre aspas o diretório de trabalho que você está usando no seu computador
# Não use diretórios com espaço no nome

setwd("D:/BigDataAnalytics/Capitulo05")
getwd()

# Instalar o Java - JDK 
# https://www.oracle.com/technetwork/java/javase/downloads/index.html

# Windows
# Faça o download do JDK gratuitamente no site da Oracle
# Instale no seu computador
# Configure a variável de ambiente JAVA_HOME apontantando para o diretório de instalação do JDK
# Inclua o diretório JAVA_HOME/bin na variável de ambiente PATH

# Mac e Linux
# Faça o download do JDK gratuitamente no site da Oracle
# Instale no seu computador
# Abra um terminal e execute: sudo R CMD javareconf

# ********** Pacotes que requerem Java **********
# XLConnect
# xlsx
# rJava 

# ********** Pacotes que requerem Perl **********
# É necessário instalar o interpretador da linguagem Perl e adicionar o diretório bin da instalação do Perl
# na variável de ambiente PATH
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
# pois alguns pacotes possuem o mesmo nome de funções (que são diferentes entre os pacotes). 
# Para evitar problemas, carregue e use os pacotes de forma individual 
# (não carregue todos os pacotes de uma única vez).

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
