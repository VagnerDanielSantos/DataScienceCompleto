
# Lista de Exerc�cios - Cap�tulo 06

# Obs: Caso tenha problemas com a acentua��o, consulte este link:
# https://support.rstudio.com/hc/en-us/articles/200532197-Character-Encoding

# Configurando o diret�rio de trabalho
# Coloque entre aspas o diret�rio de trabalho que voc� est� usando no seu computador
# N�o use diret�rios com espa�o no nome

setwd("D:/BigDataAnalytics/Capitulo06/Exercicios")
getwd()


# Exerc�cio 01 - Instale a carregue os pacotes necess�rios para trabalhar com SQLite e R

install.packages("RSQLite")
library(RSQLite)

install.packages("dbplyr")
library(dbplyr)

install.packages("dplyr")
library(dplyr)

# Exerc�cio 02 - Crie a conex�o para o arquivo mamiferos.sqlite em anexo a este script

drive <- dbDriver("SQLite")
conexao <- dbConnect(drive, dbname = "D:/BigDataAnalytics/Capitulo06/Exercicios/mamiferos.sqlite")
dbListTables(conexao)

# Exerc�cio 03 - Qual a vers�o do SQLite usada no Banco de Dados?
# Dica: Consulte o help da fun��o src_dbi()

install.packages("dbplyr")
library(dbplyr)

?src_dbi
src_dbi(conexao)

# Exerc�cio 04 - Execute a query abaixo no Banco de Dados e grave em um objeto em R:
# SELECT year, species_id, plot_id FROM surveys

?tbl
query <- tbl(conexao, sql("SELECT year, species_id, plot_id FROM surveys"))

# Exerc�cio 05 - Qual o tipo de objeto criado no item anterior?

class(query)

# Exerc�cio 06 - J� carregamos a tabela abaixo. Selecione as colunas species_id, sex e weight com a seguinte condi��o:
# Condi��o: weight < 5

pesquisas <- tbl(conexao, "surveys")

pesquisas_nova <- pesquisas %>%
  filter(weight <5) %>%
  select(species_id, sex, weight)

View(pesquisas_nova)
class(pesquisas_nova)

# Exerc�cio 07 - Grave o resultado do item anterior em um objeto R. 
# O objeto final deve ser um dataframe

pesquisa_dataframe <- as.data.frame(pesquisas_nova)
View(pesquisa_dataframe)
class(pesquisa_dataframe)

# Exerc�cio 08 - Liste as tabelas do Banco de Dados carregado

dbListTables(conexao, pesquisa_dataframe)

# Exerc�cio 09 - A partir do Dataframe criado no item 7, crie uma tabela no banco de dados

pesquisa_tabela <- dbWriteTable(conexao, 
                                "D:/BigDataAnalytics/Capitulo06/Exercicios/nova_pesquisa_dataframe", 
                                pesquisa_dataframe, 
                                row.names = TRUE )

dbListTables(conexao, pesquisa_tabela)

# Exerc�cio 10 - Imprima os dados da tabela criada no item anterior

dbReadTable(conexao, "D:/BigDataAnalytics/Capitulo06/Exercicios/nova_pesquisa_dataframe")

dbListTables(conexao, pesquisa_tabela)
dbListFields(conexao, pesquisa_tabela)


