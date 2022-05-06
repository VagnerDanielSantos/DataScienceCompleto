
# Trabalhando com R e MongoDB

# Obs: Caso tenha problemas com a acentuação, consulte este link:
# https://support.rstudio.com/hc/en-us/articles/200532197-Character-Encoding

# Configurando o diretório de trabalho
# Coloque entre aspas o diretório de trabalho que você está usando no seu computador
# Não use diretórios com espaço no nome

setwd("D:/BigDataAnalytics/Capitulo06")
getwd()


# RMongoDB
# Instalação do Pacote

install.packages("devtools")
library("devtools")
install_github("mongosoup/rmongodb", force = TRUE)
library(rmongodb)

# Cria a conexão

help("mongo.create")
mongo <- mongo.create()
mongo

# Checa a conexão

mongo.is.connected(mongo)

if(mongo.is.connected(mongo) == TRUE) {
  mongo.get.databases(mongo)
}

# Armazena o nome de uma das coleções

colecao <- "D:/BigDataAnalytics/Capitulo06/Arquivos/users.contatos"

# Conta os registros em uma conexão

help("mongo.count")
mongo.count(mongo, colecao)

# Busca um registro em uma coleção

mongo.find.one(mongo, colecao)

# Obtendo um vetor de valores distintos das chaves de uma coleção

res <- mongo.distinct(mongo, colecao, "D:/BigDataAnalytics/Capitulo06/Arquivos/city")
head(res)

# Obtém um vetor de valores distintos das chaves de uma coleção
# E gera um histograma

pop <- mongo.distinct(mongo, colecao, "D:/BigDataAnalytics/Capitulo06/Arquivos/pop")
hist(pop)

# Conta os elementos

nr <- mongo.count(mongo, colecao, list('D:/BigDataAnalytics/Capitulo06/Arquivos/pop' = list('$lte' = 2)))
print( nr )

# Busca todos os elementos

pops <- mongo.find.all(mongo, colecao, list('D:/BigDataAnalytics/Capitulo06/Arquivos/pop' = list('$lte' = 2)))
head(pops, 2)

# Encerra a conexão

mongo.destroy(mongo)

# Cria e valida um arquivo json

library(jsonlite)

json_arquivo <- '{"D:/BigDataAnalytics/Capitulo06/Arquivos/pop":{"$lte":2}, "D:/BigDataAnalytics/Capitulo06/Arquivos/pop":{"$gte":1}}'
cat(prettify(json_arquivo))

validate(json_arquivo)
