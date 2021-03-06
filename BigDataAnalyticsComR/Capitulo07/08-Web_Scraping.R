
# Estudo de Caso - Extraindo Dados da Web com Web Scraping em R

# Web Crawling - "rastejar" por uma web page ou site buscando dados
# Web Scraping - "raspar" os dados de uma web page


# Obs: Caso tenha problemas com a acentua��o, consulte este link:
# https://support.rstudio.com/hc/en-us/articles/200532197-Character-Encoding

# Configurando o diret�rio de trabalho
# Coloque entre aspas o diret�rio de trabalho que voc� est� usando no seu computador
# N�o use diret�rios com espa�o no nome

setwd("D:/BigDataAnalytics/Capitulo07")
getwd()


# Pacotes R para Web Scraping
# RCurl
# httr
# XML
# rvest

# Pacote rvest - �til para quem n�o conhece HTML e CSS

install.packages('rvest')
library(rvest)
install.packages("lubridate")
library(lubridate)

library(stringr)
library(dplyr)
library(readr)
library(xml2)

# Leitura da web page - Retorna um documento xml

webpage <- read_html("https://www.nytimes.com/interactive/2017/06/23/opinion/trumps-lies.html")
webpage


# Extrai os registros
# Cada elemento na web page acima tem o seguinte formato em html:
# <span class="short-desc"><strong> DATE </strong> LIE <span class="short-truth"><a href="URL"> EXPLANATION </a></span></span>

?html_nodes

results <- webpage %>% html_nodes(".short-desc")
print(results)

# Constr�i o Dataset

records <- vector("list", length = length(results))
print(records)

?xml_contents

for (i in seq_along(results)) {
  date <- str_c(results[i] %>% 
                  html_nodes("strong") %>% 
                  html_text(trim = TRUE), ', 2017')
  
  lie <- str_sub(xml_contents(results[i])[2] %>% html_text(trim = TRUE), 2, -2)
  
  explanation <- str_sub(results[i] %>% 
                           html_nodes(".short-truth") %>% 
                           html_text(trim = TRUE), 2, -2)
  
  url <- results[i] %>% html_nodes("a") %>% html_attr("href")
  
  records[[i]] <- tibble(date = date, lie = lie, explanation = explanation, url = url)
}

# Dataset final

dataset_final <- bind_rows(records)

# Transformando o campo data para o formato Date em R

??mdy

dataset_final$date <- mdy(dataset_final$date)

# Exportando para CSV

write_csv(dataset_final, "D:/BigDataAnalytics/Capitulo07/Arquivos/mentiras_trump.csv")

# Lendo os dados

dataframe_trump <- read_csv("D:/BigDataAnalytics/Capitulo07/Arquivos/mentiras_trump.csv")
View(dataframe_trump)
