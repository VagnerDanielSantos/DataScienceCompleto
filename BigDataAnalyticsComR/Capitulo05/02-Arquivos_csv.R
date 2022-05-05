
# Trabalhando com arquivos csv

# Obs: Caso tenha problemas com a acentuação, consulte este link:
# https://support.rstudio.com/hc/en-us/articles/200532197-Character-Encoding

# Configurando o diretório de trabalho
# Coloque entre aspas o diretório de trabalho que você está usando no seu computador
# Não use diretórios com espaço no nome

setwd("D:/BigDataAnalytics/Capitulo05")
getwd()

# Instala o pacote readr 

install.packages("readr")
library(readr)

# Abre o promt para escolher o arquivo

meu_arquivo <- read_csv(file.choose())


# Importa arquivos

dataframe01 <- read_table("D:/BigDataAnalytics/Capitulo05/Arquivos/temperaturas.txt", 
                          col_names = c("DAY","MONTH","YEAR","TEMP"))

head(dataframe01)
View(dataframe01)
str(dataframe01)

read_lines("D:/BigDataAnalytics/Capitulo05/Arquivos/temperaturas.txt", skip = 0, n_max = -1L)

read_file("D:/BigDataAnalytics/Capitulo05/Arquivos/temperaturas.txt")

# Exportando e Importando

write_csv(iris, "D:/BigDataAnalytics/Capitulo05/Arquivos/iris.csv")
dir()

# col_integer(): 
# col_double(): 
# col_logical(): 
# col_character(): 
# col_factor(): 
# col_skip(): 
@@@@@@# col_date() (alias = ), col_datetime() (alias = ), col_time() () 

dataframe_iris <- read_csv("D:/BigDataAnalytics/Capitulo05/Arquivos/iris.csv", col_types = list(
  Sepal.Length = col_double(),
  Sepal.Width = col_double(),
  Petal.Length = col_double(),
  Petal.Width = col_double(),
  Species = col_factor(c("setosa", "versicolor", "virginica"))
))

dim(dataframe_iris)
str(dataframe_iris)


# Manipula arquivos csv

dataframe_cadastro <- read_csv("D:/BigDataAnalytics/Capitulo05/Arquivos/cadastro.csv")

View(ddataframe_cadastrof_cad)
class(dataframe_cadastro)


install.packages("dplyr")
library(dplyr)
#options(warn=-1)

dataframe_cadastro <- tbl_df(dataframe_cadastro)
head(dataframe_cadastro)
View(dataframe_cadastro)

write.csv(dataframe_cadastro, 
          "D:/BigDataAnalytics/Capitulo05/Arquivos/dataframe_cadastro_bkp.csv")

# Importa vários arquivos simultaneamente

list.files()
lista_arquivos <- list.files('D:/BigDataAnalytics/Capitulo05/Arquivos', full.names = TRUE)
class(lista_arquivos)
lista_arquivos

lista_arquivos2 <- lapply(lista_arquivos, read_csv)
class(lista_arquivos2)
View(lista_arquivos2)


# Parsing

parse_date("01/02/15", "%m/%d/%y")
parse_date("01/02/15", "%d/%m/%y")
parse_date("01/02/34", "%y/%m/%d")


locale("en")
locale("fr")
locale("pt")
