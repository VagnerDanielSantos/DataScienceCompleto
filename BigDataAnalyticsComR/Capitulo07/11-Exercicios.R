
# Lista de Exercícios - Capítulo 07

# Obs: Caso tenha problemas com a acentuação, consulte este link:
# https://support.rstudio.com/hc/en-us/articles/200532197-Character-Encoding

# Configurando o diretório de trabalho
# Coloque entre aspas o diretório de trabalho que você está usando no seu computador
# Não use diretórios com espaço no nome

setwd("D:/BigDataAnalytics/Capitulo07/Exercicios")
getwd()

# Formata os Dados de uma página web

library(rvest)
library(stringr)
library(tidyr)

# Exercício 01 - Faça a leitura da url abaixo e grave no objeto pagina
# http://forecast.weather.gov/MapClick.php?lat=42.31674913306716&lon=-71.42487878862437&site=all&smap=1#.VRsEpZPF84I

pagina01 <- read_html("http://forecast.weather.gov/MapClick.php?lat=42.31674913306716&lon=-71.42487878862437&site=all&smap=1#.VRsEpZPF84I")
print(pagina01)

# Exercício 02 - Da página coletada no item anterior, extraia o texto que contenha as tags:
# "#detailed-forecast-body b  e .forecast-text"

pagina02 <- html_nodes(pagina01, "#detailed-forecast-body b ,  .forecast-text")
View(pagina02)
print(pagina02)

# Exercício 03 - Transforme o item anterior em texto

texto01 <- pagina02 %>% html_text(trim = TRUE)
print(texto01)

# Exercício 04 - Extraímos a página web abaixo. Agora faça a coleta da tag "table"

url <- 'http://espn.go.com/nfl/superbowl/history/winners'
pagina <- read_html(url)
print(pagina)

tag_table <- html_nodes(pagina, "table")
print(tag_table)

# Exercício 05 - Converta o item anterior em um dataframe

?html_table

dataframe_table  <- html_table(tag_table)[[1]]
print(dataframe_table)
class(dataframe_table)
View(dataframe_table)

# Exercício 06 - Remova as duas primeiras linhas e adicione nomes as colunas

remove_linhas <- dataframe_table[-(1:2), ]
View(remove_linhas)

colnames(remove_linhas) <- c("Numero", "Data", "Site", "Resultado")
View(remove_linhas)

# Exercício 07 - Converta de algarismos romanos para números inteiros

converte_numeros <- remove_linhas
converte_numeros$Numero <- 1:56 
View(converte_numeros)

altera_formato_data <- converte_numeros
altera_formato_data$Data <- as.Date(altera_formato_data$Data, "%B. %d, %Y")
View(altera_formato_data)

# Exercício 08 - Divida as colunas em 4 colunas

resultado <- altera_formato_data %>%
  separate(Resultado, c("Winner", "Loser"), sep = ", ", remove = TRUE)

View(resultado)

# Exercício 09 - Inclua mais 2 colunas com o score dos "Vencedores" e "Perdedores"
# Dica: Faça mais uma divisão nas colunas

padrao_numero <- "\\d+$"

resultado$WinnerScore <- as.numeric(str_extract(resultado$Winner, padrao_numero))
resultado$Winner <- gsub(padrao_numero, " ", resultado$Winner)

resultado$LoserScore <- as.numeric(str_extract(resultado$Loser, padrao_numero))
resultado$Loser <- gsub(padrao_numero, " ", resultado$Loser)

View(resultado)

# Exercício 10 - Grave o resultado em um arquivo .csv

write.csv(resultado, 
          "D:/BigDataAnalytics/Capitulo07/Exercicios/superbow.csv", 
          row.names = FALSE)
