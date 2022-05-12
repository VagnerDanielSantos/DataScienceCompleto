
# Remodelagem de Dados com tidyr

# Obs: Caso tenha problemas com a acentuação, consulte este link:
# https://support.rstudio.com/hc/en-us/articles/200532197-Character-Encoding

# Configurando o diretório de trabalho
# Coloque entre aspas o diretório de trabalho que você está usando no seu computador
# Não use diretórios com espaço no nome

setwd("D:/BigDataAnalytics/Capitulo07")
getwd()


# Instala os pacotes

install.packages("tidyr")
library(tidyr)
library(ggplot2)

# Dados de notas em disciplinas

dados <- data.frame(
  Nome = c("Geografia", "Literatura", "Biologia"),
  Regiao_A = c(97, 80, 84),
  Regiao_B = c(86, 90, 91)
)
dados

dados %>%
  gather(Regiao, NotaFinal, Regiao_A:Regiao_B)


# Cria os  dados

dados_dataframe <- data.frame(
                              id = 1:4,
                              acao = sample(rep(c('Controle', 'Tratamento'), each = 2)),
                              work.T1 = runif(4),
                              home.T1 = runif(4),
                              work.T2 = runif(4),
                              home.T2 = runif(4)
                            )

View(dados_dataframe)

# Reshape 01

dados_dataframe_organizado01 <- dados_dataframe %>%
                                  gather(key, time, -id, -acao)

dados_dataframe_organizado01 %>% head(8)

# Reshape 02

dados_dataframe_organizado02 <- dados_dataframe_organizado01 %>%
                                  separate(key, into = c("localidade", "tempo"), sep = "\\.") 

dados_dataframe_organizado02 %>% head(8)

# Mais um exemplo

dataframe01 <- data.frame(
                          participante = c("P1", "P2", "P3", "P4", "P5", "P6"), 
                          info = c("G1m", "G1m", "G1f", "G2m", "G2m", "G2m"),
                          day1score = rnorm(n = 6, mean = 80, sd = 15), 
                          day2score = rnorm(n = 6, mean = 88, sd = 8)
                        )

print(dataframe01)

# Reshape dos dados

dataframe01 %>%
  gather(day, score, c(Day1score, Day2score))


dataframe02 %>%
  gather(day, score, c(Day1score, Day2score)) %>%
  spread(day, score)


dataframe03 %>%
  gather(day, score, c(Day1score, Day2score)) %>%
  separate(col = info, into = c("group", "gender"), sep = 2)


dataframe04 %>%
  gather(day, score, c(Day1score, Day2score)) %>%
  separate(col = info, into = c("group", "gender"), sep = 2) %>%
  unite(infoAgain, group, gender)


dataframe05 %>%
  gather(day, score, c(Day1score, Day2score)) %>%
  separate(col = info, into = c("group", "gender"), sep = 2) %>%
  ggplot(aes(x = day, y = score)) + 
  geom_point() + 
  facet_wrap(~ group) +
  geom_smooth(method = "lm", aes(group = 1), se = F)
