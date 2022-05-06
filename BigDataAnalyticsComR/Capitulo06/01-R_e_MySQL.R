
# Carregando e Analisando Dados do MySQL com Linguagem R

# Obs: Caso tenha problemas com a acentuação, consulte este link:
# https://support.rstudio.com/hc/en-us/articles/200532197-Character-Encoding

# Configurando o diretório de trabalho
# Coloque entre aspas o diretório de trabalho que você está usando no seu computador
# Não use diretórios com espaço no nome

setwd("D:/BigDataAnalytics/Capitulo06")
getwd()

install.packages('RMySQL')
install.packages("ggplot2")
install.packages("dbplyr")
library(RMySQL)
library(ggplot2)
library(dbplyr)
library(dplyr)

# Antes de trabalha com MySQL e R, acesse o shell do MySQL (no prompt ou terminal) e digite:
# ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY '(Digitar Senha)';

# Conexão com o Banco de Dados

?dbConnect

conexao01 = dbConnect(MySQL(), user = "root", password = "(Digitar Senha)", dbname = "titanicDB", host = "localhost")

# Query

query <- "SELECT pclass, survived, avg(age) as media_idade FROM tbltitanic where survived = 1 GROUP BY pclass, survived;"
dbGetQuery(conexao01, query)



# Plot

dados01 <- dbGetQuery(conexao01, query)
head(dados01)
class(dados01)
ggplot(dados01, aes(pclass, media_idade)) + geom_bar(stat = "identity")


# Conecta no MySQL com dplyr

?src_mysql
conexao02 <- src_mysql(dbname = "titanicdb", user = "root", password = "(Digitar senha)", host = "localhost")


# Coleta e agrupa os dados

dados2 <- conexao %>%
  tbl("tbltitanic") %>%
  select(pclass, sex, age, survived, fare) %>%
  filter(survived == 0) %>%
  collect()

head(dados2)


# Manipula os Dados

dados2 <- conexão02 %>%
  tbl("tbltitanic") %>%
  select(pclass, sex, survived) %>%
  group_by(pclass, sex) %>%
  summarise(survival_ratio = avg(survived)) %>%
  collect() 

View(dados2)


# Plot

ggplot(dados2, aes(pclass,survival_ratio, color=sex, group=sex)) +
  geom_point(size=3) + geom_line()


# Sumariza os dados

dados2 <- con2 %>%
  tbl("tbltitanic") %>% 
  filter(fare > 150) %>%
  select(pclass,sex,age,fare) %>%
  group_by(pclass,sex) %>% 
  summarise(avg_age = avg(age),
            avg_fare = avg(fare))

head(dados2)


# --> Para outros bancos de dados, use RODBC
