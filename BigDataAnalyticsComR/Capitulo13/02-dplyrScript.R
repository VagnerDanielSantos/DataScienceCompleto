
# Este código contém comandos para filtrar e plotar os dados de aluguel de bikes, 
# dados que estão em nosso dataset.
# Este código foi criado para executar tanto no Azure, quanto no RStudio.
# Para executar no Azure, altere o valor da variavel Azure para TRUE. 
# Se o valor for FALSE, o codigo sera executado no RStudio.

# Obs: Caso tenha problemas com a acentuação, consulte este link:
# https://support.rstudio.com/hc/en-us/articles/200532197-Character-Encoding

# Configurando o diretório de trabalho
# Coloque entre aspas o diretório de trabalho que você está usando no seu computador
# Não use diretórios com espaço no nome

setwd("D:/BigDataAnalytics/Capitulo13")
getwd()

# Variável que controla a execução do script

Azure = FALSE

if(Azure){
  restaurantes <- maml.mapInputPort(1)
  ratings <- maml.mapInputPort(2) 
}else{
  restaurantes  <- read.csv("D:/BigDataAnalytics/Capitulo13/Arquivos/Restaurant-features.csv", 
                            sep = ",", 
                            header = T, 
                            stringsAsFactors = F )
  
  ratings <- read.csv("D:/BigDataAnalytics/Capitulo13/Arquivos/Restaurant-ratings.csv", 
                      sep = ",", 
                      header = T, 
                      stringsAsFactors = F)
}

# Filtra o Dataset restaurantes

restaurantes <- restaurantes[restaurantes$franchise == 'f' 
                             & restaurantes$alcohol != 'No_Alcohol_Served', ]

install.packages('dplyr')
require(dplyr)

# Combina os Datasets com base em regras

dataframe <- as.data.frame(restaurantes %>%
                       inner_join(ratings, by = 'placeID') %>%
                       select(name, rating) %>%
                       group_by(name) %>%
                       summarize(ave_Rating = mean(rating)) %>%
                       arrange(desc(ave_Rating))) 

print(dataframe)
View(dataframe)

if(Azure) maml.mapOutputPort("dataframe")
