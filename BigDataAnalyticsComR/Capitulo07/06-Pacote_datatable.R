
# Data.table

# Obs: Caso tenha problemas com a acentuação, consulte este link:
# https://support.rstudio.com/hc/en-us/articles/200532197-Character-Encoding

# Configurando o diretório de trabalho
# Coloque entre aspas o diretório de trabalho que você está usando no seu computador
# Não use diretórios com espaço no nome

setwd("D:/BigDataAnalytics/Capitulo07")
getwd()

# Instala os pacotes

install.packages("data.table")
library(data.table)


# Cria 2 vetores

vetor01 <- c(1, 2, 3, 4)
vetor02 <- c('Vermelho', 'Verde', 'Marrom', 'Laranja')


# Cria um data.table

?data.table

datatable01 <- data.table(vetor01, vetor02)
View(datatable01)
class(datatable01)

# Slicing do data.table

datatable02 <- data.table(A = 1:9, B = c("Z", "W", "Q"), C = rnorm(9), D = TRUE)
View(datatable02)
class(datatable01)
datatable02[1,1]
datatable02[3:5,]
datatable02[, .(B, C)]

# Aplica função ao data.table

datatable02[, .(Total = sum(A), Mean = mean(C))]
datatable02[, plot(A, C)]
datatable02[, .(MySum = sum(A)), by = .(Grp = A%%2)]

# Define valores por grupos

datatable03 <- data.table(B = c("a", "b", "c", "d", "e", "a", "b", "c", "d", "e"), 
                          val = as.integer(c(6:10, 1:5)))

View(datatable03)

# Operações com data.tables

datatable04 <- data.table(A = rep(letters[2:1], each = 4L), 
                          B = rep(1:4, each = 2L), 
                          C = sample(8))

View(datatable04)

new_datatable04 <- datatable04[, sum(C), by = A]
View(new_datatable04)
class(new_datatable04)
new_datatable04[order(A)]

new_datatable04 <- datatable04[, sum(B), by = A][order(A)]
new_datatable04

# Iris

datatable05 <- as.data.table(iris)
View(datatable05)
datatable05[, .(Sepal.Length = median(Sepal.Length),
                Sepal.Width = median(Sepal.Width),
                Petal.Length = median(Petal.Length),
                Petal.Width = median(Petal.Width)),
             by = Species]

# O parâmetro .SD significa Subset Data e um subset é criado considerando a coluna 
# Species e depois é calculada a mediana. 
# O resultado deve ser igual ao comando anterior. 
# O .SD faz parte da notação do pacote data.table.

datatable05[, lapply(.SD, median), by = Species]
