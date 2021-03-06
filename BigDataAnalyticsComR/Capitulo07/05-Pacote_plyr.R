
# Split-Apply-Combine - plyr

# Obs: Caso tenha problemas com a acentua��o, consulte este link:
# https://support.rstudio.com/hc/en-us/articles/200532197-Character-Encoding

# Configurando o diret�rio de trabalho
# Coloque entre aspas o diret�rio de trabalho que voc� est� usando no seu computador
# N�o use diret�rios com espa�o no nome

setwd("D:/BigDataAnalytics/Capitulo07")
getwd()

# Instala os pacotes

install.packages("plyr")
install.packages("gapminder")

# https://www.gapminder.org

library(plyr)
library(gapminder)

?gapminder

# Split-Apply-Combine

?ddply

dataframe01 <- ddply(gapminder, ~ continent, 
                     summarize, 
                     max_le = max(lifeExp))

str(dataframe01)
head(dataframe01)
View(dataframe01)
levels(dataframe01$continent)

# Split-Apply-Combine

ddply(gapminder, ~ continent, 
      summarize, 
      n_uniq_countries = length(unique(country)))


ddply(gapminder, ~ continent, 
      function(x) c(n_uniq_countries = length(unique(x$country))))


ddply(gapminder, ~ continent, 
      summarize,
      min = min(lifeExp), 
      max = max(lifeExp),
      median = median(gdpPercap))


# Dataset do ggplot

library(ggplot2)

data(mpg)
str(mpg)

?mpg

# Trabalhando com um subset do Dataset

data <- mpg[,c(1,7:9)]
str(data)
View(data)

# Sumariza e Agrega os Dados

ddply(data, .(manufacturer), 
      summarize, 
      avgcty = mean(cty))


# V�rias fun��es em uma �nica chamada

ddply(data, .(manufacturer), 
      summarize, 
      avgcty = mean(cty), 
      sdcty = sd(cty), 
      maxhwy = max(hwy))


# Sumariza os Dados pela combina��o de vari�veis/fatores

ddply(data, .(manufacturer, drv), 
      summarize, 
      avgcty = mean(cty), 
      sdcty = sd(cty),
      maxhwy = max(hwy))
