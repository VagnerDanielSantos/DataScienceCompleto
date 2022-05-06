
# Lista de Exercícios - Capítulo 06

# Obs: Caso tenha problemas com a acentuação, consulte este link:
# https://support.rstudio.com/hc/en-us/articles/200532197-Character-Encoding

# Configurando o diretório de trabalho
# Coloque entre aspas o diretório de trabalho que você está usando no seu computador
# Não use diretórios com espaço no nome

setwd("D:/BigDataAnalytics/Capitulo06/Exercicios")
getwd()


# Exercício 01 - Instale a carregue os pacotes necessários para trabalhar com SQLite e R

install.packages("RSQLite")
library(RSQLite)

install.packages("dbplyr")
library(dbplyr)

install.packages("dplyr")
library(dplyr)

# Exercício 02 - Crie a conexão para o arquivo mamiferos.sqlite em anexo a este script

drive <- dbDriver("SQLite")
conexao <- dbConnect(drive, dbname = "D:/BigDataAnalytics/Capitulo06/Exercicios/mamiferos.sqlite")
dbListTables(conexao)

# Exercício 03 - Qual a versão do SQLite usada no Banco de Dados?
# Dica: Consulte o help da função src_dbi()

install.packages("dbplyr")
library(dbplyr)

?src_dbi
src_dbi(conexao)

# Exercício 04 - Execute a query abaixo no Banco de Dados e grave em um objeto em R:
# SELECT year, species_id, plot_id FROM surveys

?tbl
query <- tbl(conexao, sql("SELECT year, species_id, plot_id FROM surveys"))

# Exercício 05 - Qual o tipo de objeto criado no item anterior?

class(query)

# Exercício 06 - Já carregamos a tabela abaixo. Selecione as colunas species_id, sex e weight com a seguinte condição:
# Condição: weight < 5

pesquisas <- tbl(conexao, "surveys")

pesquisas_nova <- pesquisas %>%
  filter(weight <5) %>%
  select(species_id, sex, weight)

View(pesquisas_nova)
class(pesquisas_nova)

# Exercício 07 - Grave o resultado do item anterior em um objeto R. 
# O objeto final deve ser um dataframe

pesquisa_dataframe <- as.data.frame(pesquisas_nova)
View(pesquisa_dataframe)
class(pesquisa_dataframe)

# Exercício 08 - Liste as tabelas do Banco de Dados carregado

dbListTables(conexao, pesquisa_dataframe)

# Exercício 09 - A partir do Dataframe criado no item 7, crie uma tabela no banco de dados

pesquisa_tabela <- dbWriteTable(conexao, 
                                "D:/BigDataAnalytics/Capitulo06/Exercicios/nova_pesquisa_dataframe", 
                                pesquisa_dataframe, 
                                row.names = TRUE )

dbListTables(conexao, pesquisa_tabela)

# Exercício 10 - Imprima os dados da tabela criada no item anterior

dbReadTable(conexao, "D:/BigDataAnalytics/Capitulo06/Exercicios/nova_pesquisa_dataframe")

dbListTables(conexao, pesquisa_tabela)
dbListFields(conexao, pesquisa_tabela)


