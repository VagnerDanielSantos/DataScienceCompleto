
# Limpeza, Formata��o e Manipula��o de Dados em R 
# dplyr - Transforma��o de Dados

# Obs: Caso tenha problemas com a acentua��o, consulte este link:
# https://support.rstudio.com/hc/en-us/articles/200532197-Character-Encoding

# Configurando o diret�rio de trabalho
# Coloque entre aspas o diret�rio de trabalho que voc� est� usando no seu computador
# N�o use diret�rios com espa�o no nome

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


# Fun��o glimpse() pode ser usada no lugar da Fun��o str()

glimpse(sono_dataframe)


# Func�o mutate()

glimpse(mutate(sono_dataframe, peso_libras = sono_total / 0.45359237))


# Contagem e histograma

count(sono_dataframe, cidade)
hist(sono_dataframe$sono_total)


# Amostragem

sample_n(sono_dataframe, size = 10)


# Fun��o select()

sleepData <- select(sono_dataframe, nome, sono_total)
head(sleepData)
class(sleepData)
select(sono_dataframe, nome)
select(sono_dataframe, nome:cidade)
select(sono_dataframe, nome:pais)


# Fun��o filter()

filter(sono_dataframe, sono_total >= 16)
filter(sono_dataframe, sono_total >= 16, peso >= 80)
filter(sono_dataframe, cidade %in% c("Recife", "Curitiba"))


# Fun��o arrange()

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


# Fun��o mutate()

View(sono_dataframe)

sono_dataframe05 <- sono_dataframe %>% 
                      mutate(novo_indice = sono_total / peso) %>%
                      head

View(sono_dataframe05)


sono_dataframe06 <- sono_dataframe %>% 
                      mutate(novo_indice = sono_total / peso, 
                             peso_libras = peso / 0.45359237) %>%
                      head


# Fun��o summarize()

sono_dataframe07 <- sono_dataframe %>% 
                      summarise(media_sono = mean(sono_total))

sono_dataframe08 <- sono_dataframe %>% 
                      summarise(media_sono = mean(sono_total), 
                                min_sono = min(sono_total),
                                max_sono = max(sono_total),
                                total = n())


# Fun��o group_by()

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
