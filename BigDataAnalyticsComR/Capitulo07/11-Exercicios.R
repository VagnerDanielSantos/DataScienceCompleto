
# Lista de Exerc�cios - Cap�tulo 07

# Obs: Caso tenha problemas com a acentua��o, consulte este link:
# https://support.rstudio.com/hc/en-us/articles/200532197-Character-Encoding

# Configurando o diret�rio de trabalho
# Coloque entre aspas o diret�rio de trabalho que voc� est� usando no seu computador
# N�o use diret�rios com espa�o no nome

setwd("D:/BigDataAnalytics/Capitulo07/Exercicios")
getwd()

# Formata os Dados de uma p�gina web

library(rvest)
library(stringr)
library(tidyr)

# Exerc�cio 01 - Fa�a a leitura da url abaixo e grave no objeto pagina
# http://forecast.weather.gov/MapClick.php?lat=42.31674913306716&lon=-71.42487878862437&site=all&smap=1#.VRsEpZPF84I

pagina01 <- read_html("http://forecast.weather.gov/MapClick.php?lat=42.31674913306716&lon=-71.42487878862437&site=all&smap=1#.VRsEpZPF84I")
print(pagina01)

# Exerc�cio 02 - Da p�gina coletada no item anterior, extraia o texto que contenha as tags:
# "#detailed-forecast-body b  e .forecast-text"

pagina02 <- html_nodes(pagina01, "#detailed-forecast-body b ,  .forecast-text")
View(pagina02)
print(pagina02)

# Exerc�cio 03 - Transforme o item anterior em texto

texto01 <- pagina02 %>% html_text(trim = TRUE)
print(texto01)

# Exerc�cio 04 - Extra�mos a p�gina web abaixo. Agora fa�a a coleta da tag "table"

url <- 'http://espn.go.com/nfl/superbowl/history/winners'
pagina <- read_html(url)
print(pagina)

tag_table <- html_nodes(pagina, "table")
print(tag_table)

# Exerc�cio 05 - Converta o item anterior em um dataframe

?html_table

dataframe_table  <- html_table(tag_table)[[1]]
print(dataframe_table)
class(dataframe_table)
View(dataframe_table)

# Exerc�cio 06 - Remova as duas primeiras linhas e adicione nomes as colunas

remove_linhas <- dataframe_table[-(1:2), ]
View(remove_linhas)

colnames(remove_linhas) <- c("Numero", "Data", "Site", "Resultado")
View(remove_linhas)

# Exerc�cio 07 - Converta de algarismos romanos para n�meros inteiros

converte_numeros <- remove_linhas
converte_numeros$Numero <- 1:56 
View(converte_numeros)

altera_formato_data <- converte_numeros
altera_formato_data$Data <- as.Date(altera_formato_data$Data, "%B. %d, %Y")
View(altera_formato_data)

# Exerc�cio 08 - Divida as colunas em 4 colunas

resultado <- altera_formato_data %>%
  separate(Resultado, c("Winner", "Loser"), sep = ", ", remove = TRUE)

View(resultado)

# Exerc�cio 09 - Inclua mais 2 colunas com o score dos "Vencedores" e "Perdedores"
# Dica: Fa�a mais uma divis�o nas colunas

padrao_numero <- "\\d+$"

resultado$WinnerScore <- as.numeric(str_extract(resultado$Winner, padrao_numero))
resultado$Winner <- gsub(padrao_numero, " ", resultado$Winner)

resultado$LoserScore <- as.numeric(str_extract(resultado$Loser, padrao_numero))
resultado$Loser <- gsub(padrao_numero, " ", resultado$Loser)

View(resultado)

# Exerc�cio 10 - Grave o resultado em um arquivo .csv

write.csv(resultado, 
          "D:/BigDataAnalytics/Capitulo07/Exercicios/superbow.csv", 
          row.names = FALSE)
