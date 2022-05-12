
# Estudo de Caso - Limpando, Transformando e Manipulando Dados de Voos

# Obs: Caso tenha problemas com a acentuação, consulte este link:
# https://support.rstudio.com/hc/en-us/articles/200532197-Character-Encoding

# Configurando o diretório de trabalho
# Coloque entre aspas o diretório de trabalho que você está usando no seu computador
# Não use diretórios com espaço no nome

setwd("D:/BigDataAnalytics/Capitulo07")
getwd()


# Instala o pacote hflights (Dados de voos de Houston)

install.packages("hflights")
library(hflights)
library(dplyr)
?hflights


# Cria um objeto tbl()

?tbl_df

flights <- tbl_df(hflights)
flights
View(flights)


# Resume os dados

str(hflights)
glimpse(hflights)


# Visualiza como dataframe

data.frame(head(flights))

# Filtra os dados com slice()

flights[1,1]
flights[flights$Month == 1 & flights$DayofMonth == 1, ]

# Aplica a função filter()

filter(flights, Month == 1, DayofMonth == 1)
filter(flights, UniqueCarrier == "AA" | UniqueCarrier == "UA")
filter(flights, UniqueCarrier %in% c("AA", "UA"))


# Função Select()

select(flights, Year:DayofMonth, contains("Taxi"), contains("Delay"))

# Organiza os dados

flights %>%
  select(UniqueCarrier, DepDelay) %>%
  arrange(DepDelay)

flights %>%
  select(Distance, AirTime) %>%
  mutate(Speed = Distance/AirTime*60)

head(with(flights, tapply(ArrDelay, Dest, mean, na.rm = TRUE)))
head(aggregate(ArrDelay ~ Dest, flights, mean))

flights %>%
  group_by(Month, DayofMonth) %>%
  tally(sort = TRUE)
