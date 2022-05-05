
# Trabalhando com Arquivos txt

# Obs: Caso tenha problemas com a acentuação, consulte este link:
# https://support.rstudio.com/hc/en-us/articles/200532197-Character-Encoding

# Configurando o diretório de trabalho
# Coloque entre aspas o diretório de trabalho que você está usando no seu computador
# Não use diretórios com espaço no nome

setwd("D:/BigDataAnalytics/Capitulo05")
getwd()

# Usa as funções base do R (pacote utils)

search()

# Importa o arquivo com read.table()

?read.table

dataframe01 <- read.table("D:/BigDataAnalytics/Capitulo05/Arquivos/pedidos.txt")
View(dataframe01)
dim(dataframe01)
#######################################################################################
dataframe02 <- read.table("D:/BigDataAnalytics/Capitulo05/Arquivos/pedidos.txt", 
                          header = TRUE, 
                          sep = ',')

View(dataframe02)
dim(dataframe02)
#######################################################################################
dataframe03 <- read.table("D:/BigDataAnalytics/Capitulo05/Arquivos/pedidos.txt", 
                          header = TRUE, 
                          sep = ',', 
                          col.names = c("var1", "var2", "var3"))

View(dataframe03)
dim(dataframe03)
#######################################################################################
dataframe04 <- read.table("D:/BigDataAnalytics/Capitulo05/Arquivos/pedidos.txt", 
                          header = TRUE, 
                          sep = ',', 
                          col.names = c("var1", "var2", "var3"),
                          na.strings = c('Zico', 'Maradona'))

View(dataframe04)
str(dataframe04)
#######################################################################################
dataframe05 <- read.table("D:/BigDataAnalytics/Capitulo05/Arquivos/pedidos.txt", 
                          header = TRUE, 
                          sep = ',', 
                          col.names = c("var1", "var2", "var3"),
                          na.strings = c('Zico', 'Maradona'),
                          stringsAsFactors = FALSE)

View(dataframe05)
str(dataframe05)
#######################################################################################

# Importa o arquivo com read.csv()

dataframe06 <- read.csv("D:/BigDataAnalytics/Capitulo05/Arquivos/pedidos.txt")

View(dataframe06)
dim(dataframe06)
#######################################################################################
dataframe07 <- read.csv2("D:/BigDataAnalytics/Capitulo05/Arquivos/pedidos.txt")

View(dataframe07)
dim(dataframe07)
#######################################################################################
dataframe08 <- read.csv2("D:/BigDataAnalytics/Capitulo05/Arquivos/pedidos.txt", 
                         sep = ',')

View(dataframe08)
dim(dataframe08)
#######################################################################################

# Importando arquivo com read.delim()
dataframe09 <- read.delim("D:/BigDataAnalytics/Capitulo05/Arquivos/pedidos.txt")
View(dataframe09)

dataframe10 <- read.delim("D:/BigDataAnalytics/Capitulo05/Arquivos/pedidos.txt", 
                          sep = ',')

View(dataframe10)
dim(dataframe10)
#######################################################################################

# Importando / Exportando

# Gera arquivo

write.table(mtcars, file = 'D:/BigDataAnalytics/Capitulo05/Arquivos/mtcars.txt')
dir()

dataframe_mtcars <- read.table("D:/BigDataAnalytics/Capitulo05/Arquivos/mtcars.txt")
View(dataframe_mtcars)
dim(dataframe_mtcars)

write.table(mtcars, file = "D:/BigDataAnalytics/Capitulo05/Arquivos/mtcars2.txt", 
            sep = "|", 
            col.names = NA, 
            qmethod = "double")

list.files()

read.table("D:/BigDataAnalytics/Capitulo05/Arquivos/mtcars2.txt")

dataframe_mtcars2 <- read.table("D:/BigDataAnalytics/Capitulo05/Arquivos/mtcars2.txt")
View(dataframe_mtcars2)

df_mtcars2 <- read.table("D:/BigDataAnalytics/Capitulo05/Arquivos/mtcars2.txt", 
                         sep = '|')

View(dataframe_mtcars2)

df_mtcars2 <- read.table("D:/BigDataAnalytics/Capitulo05/Arquivos/mtcars2.txt", 
                         sep = '|', 
                         encoding = 'UTF-8')

View(dataframe_mtcars2)
