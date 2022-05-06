
# Trabalhando com R e SQLite

# Obs: Caso tenha problemas com a acentuação, consulte este link:
# https://support.rstudio.com/hc/en-us/articles/200532197-Character-Encoding

# Configurando o diretório de trabalho
# Coloque entre aspas o diretório de trabalho que você está usando no seu computador
# Não use diretórios com espaço no nome

setwd("D:/BigDataAnalytics/Capitulo06")
getwd()

# Instalar SQLite

install.packages("RSQLite")
library(RSQLite)

# Remove o Banco de Dados SQLite, caso exista - Não é Obrigatório

system("del D:/BigDataAnalytics/Capitulo06/Arquivos/exemplo.db") # --> no Windows
# system("rm D:/BigDataAnalytics/Capitulo06/Arquivos/exemplo.db")    # --> no Mac e Linux

# Cria um driver e conexão ao Banco de Dados

drive = dbDriver("SQLite")
conexao = dbConnect(drive, dbname = "D:/BigDataAnalytics/Capitulo06/Arquivos/exemplo.db")
dbListTables(conexao)

# Cria uma tabela e carrega com os dados do dataset mtcars

dbWriteTable(conexao, "mtcars", mtcars, row.names = TRUE)

# Lista uma tabela

dbListTables(conexao)
dbExistsTable(conexao,"D:/BigDataAnalytics/Capitulo06/Arquivos/mtcars")
dbExistsTable(conexao,"D:/BigDataAnalytics/Capitulo06/Arquivos/mtcars2")
dbListFields(conexao,"D:/BigDataAnalytics/Capitulo06/Arquivos/mtcars")

# Lê o conteúdo da tabela

dbReadTable(conexao, "D:/BigDataAnalytics/Capitulo06/Arquivos/mtcars")

# Criando apenas a definição da tabela.

dbWriteTable(conexao, "D:/BigDataAnalytics/Capitulo06/Arquivos/mtcars2", 
             mtcars[0, ], 
             row.names = TRUE)

dbListTables(conexao)

dbReadTable(conexao, "D:/BigDataAnalytics/Capitulo06/Arquivos/mtcars2")

# Executa consultas no Banco de Dados

query = "SELECT row_names FROM mtcars"
resultado = dbSendQuery(conexao, query)
dados = fetch(resultado, n = -1)
dados
class(dados)

# Executa consultas no Banco de Dados

query = "SELECT row_names FROM mtcars"
resultado = dbSendQuery(conexao, query)
while (!dbHasCompleted(resultado))
{
  dados = fetch(rs, n = 1)
  print(dados$row_names)
}

# Executa consultas no Banco de Dados

query = "SELECT disp, hp FROM mtcars WHERE disp > 160"
resultado = dbSendQuery(conexao, query)
dados = fetch(resultado, n = -1)
dados

# Executa consultas no Banco de Dados

query = "SELECT row_names, avg(hp) FROM mtcars GROUP BY row_names"
resultado = dbSendQuery(conexao, query)
dados = fetch(resultado, n = -1)
dados

# Cria uma tabela a partir de um arquivo

dbWriteTable(conexao, "D:/BigDataAnalytics/Capitulo06/Arquivos/iris", 
             "D:/BigDataAnalytics/Capitulo06/Arquivos/iris.csv", 
             sep = ",", 
             header = T)

dbListTables(conexao)

dbReadTable(conexao, "D:/BigDataAnalytics/Capitulo06/Arquivos/iris")

# Encerra a Conexão

dbDisconnect(conexao)

# Carrega os dados no Banco de Dados
# http://dados.gov.br/dataset/iq-indice-nacional-de-precos-ao-consumidor-amplo-15-ipca15
# Cria um driver e conexão ao Banco de Dados

driver = dbDriver("SQLite")
conexao = dbConnect(drv, dbname = "D:/BigDataAnalytics/Capitulo06/Arquivos/exemplo.db")

dbWriteTable(conexao,"D:/BigDataAnalytics/Capitulo06/Arquivos/indices", 
             "D:/BigDataAnalytics/Capitulo06/Arquivos/indice.csv",
             sep = "|", 
             header = T)

dbRemoveTable(conexao, "D:/BigDataAnalytics/Capitulo06/Arquivos/indices")

dbWriteTable(conexao,"D:/BigDataAnalytics/Capitulo06/Arquivos/indices", 
             "D:/BigDataAnalytics/Capitulo06/Arquivos/indice.csv",
             sep = "|", 
             header = T)

dbListTables(conexao)
dbReadTable(conexao, "D:/BigDataAnalytics/Capitulo06/Arquivos/indices")

dataframe_indices <- dbReadTable(cconexao, "D:/BigDataAnalytics/Capitulo06/Arquivos/indices")
View(dataframe_indices)
str(dataframe_indices)
sapply(dataframe_indices, class)

hist(dataframe_indices$setembro)
df_mean <- unlist(lapply(dataframe_indices[, c(4, 5, 6, 7, 8)], mean))
df_mean

dbDisconnect(conexao)
