
# Limpeza, Formatação e Manipulação de Dados em R 
# dplyr - Transformação de Dados

# Obs: Caso tenha problemas com a acentuação, consulte este link:
# https://support.rstudio.com/hc/en-us/articles/200532197-Character-Encoding

# Configurando o diretório de trabalho
# Coloque entre aspas o diretório de trabalho que você está usando no seu computador
# Não use diretórios com espaço no nome

setwd("D:/BigDataAnalytics/Capitulo07")
getwd()


# Instala os pacotes

install.packages("readr")
install.packages("dplyr")
library(readr)
library(dplyr)


# Carrega o dataset

sono_dataframe <- read_csv("D:/BigDataAnalytics/Capitulo07/Arquivos/sono.csv")
View(sono_dataframe)
head(sono_dataframe)
class(sono_dataframe)
str(sono_dataframe)


# Função glimpse() pode ser usada no lugar da Função str()

glimpse(sono_dataframe)


# Funcão mutate()

glimpse(mutate(sono_dataframe, peso_libras = sono_total / 0.45359237))


# Contagem e histograma

count(sono_dataframe, cidade)
hist(sono_dataframe$sono_total)


# Amostragem

sample_n(sono_dataframe, size = 10)


# Função select()

sleepData <- select(sono_dataframe, nome, sono_total)
head(sleepData)
class(sleepData)
select(sono_dataframe, nome)
select(sono_dataframe, nome:cidade)
select(sono_dataframe, nome:pais)


# Função filter()

filter(sono_dataframe, sono_total >= 16)
filter(sono_dataframe, sono_total >= 16, peso >= 80)
filter(sono_dataframe, cidade %in% c("Recife", "Curitiba"))


# Função arrange()

sono_dataframe01 <- sono_dataframe %>% arrange(cidade) %>% head

sono_dataframe02 <- sono_dataframe %>% 
                      select(nome, cidade, sono_total) %>%
                      arrange(cidade, sono_total) %>% 
                      View(sono_dataframe02)

sono_dataframe03 <- sono_dataframe %>% 
                      select(nome, cidade, sono_total) %>%
                      arrange(cidade, sono_total) %>% 
                      filter(sono_total >= 16)

sono_dataframe04 <- sono_dataframe %>% 
                      select(nome, cidade, sono_total) %>%
                      arrange(cidade, desc(sono_total)) %>% 
                      filter(sono_total >= 16)


# Função mutate()

View(sono_dataframe)

sono_dataframe05 <- sono_dataframe %>% 
                      mutate(novo_indice = sono_total / peso) %>%
                      head

View(sono_dataframe05)


sono_dataframe06 <- sono_dataframe %>% 
                      mutate(novo_indice = sono_total / peso, 
                             peso_libras = peso / 0.45359237) %>%
                      head


# Função summarize()

sono_dataframe07 <- sono_dataframe %>% 
                      summarise(media_sono = mean(sono_total))

sono_dataframe08 <- sono_dataframe %>% 
                      summarise(media_sono = mean(sono_total), 
                                min_sono = min(sono_total),
                                max_sono = max(sono_total),
                                total = n())


# Função group_by()

sono_dataframe09 <- sono_dataframe %>% 
                      group_by(cidade) %>%
                      summarise(avg_sono = mean(sono_total), 
                                min_sono = min(sono_total), 
                                max_sono = max(sono_total),
                                total = n())


# Operador: %>%

head(select(sono_dataframe, nome, sono_total))

sono_dataframe10 <- sono_dataframe %>% 
                      select(nome, sono_total) %>% 
                      head


sono_dataframe11 <- sono_dataframe %>%
                      mutate(novo_indice = round(sono_total * peso)) %>%
                      arrange(desc(novo_indice)) %>%
                      select(cidade, novo_indice)


sono_dataframe11
View(sono_dataframe11)


sono_dataframe12 <- sono_dataframe %>%
                      mutate(novo_indice = round(sono_total * peso)) %>%
                      arrange(desc(novo_indice)) %>%
                      select(cidade, novo_indice)

View(sono_dataframe12)
