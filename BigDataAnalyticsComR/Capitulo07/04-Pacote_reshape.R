
# Remodelando os Dados com Reshape

# Obs: Caso tenha problemas com a acentuação, consulte este link:
# https://support.rstudio.com/hc/en-us/articles/200532197-Character-Encoding

# Configurando o diretório de trabalho
# Coloque entre aspas o diretório de trabalho que você está usando no seu computador
# Não use diretórios com espaço no nome

setwd("D:/BigDataAnalytics/Capitulo07")
getwd()

# Pivot (Transposta da Matriz)

mtcars
t(mtcars)

# Reshape

head(iris)
str(iris)
library(lattice)
View(iris)

# Distribui os Dados verticalmente (long)

?reshape

iris_modificado <- reshape(iris, 
                      varying = 1:4, 
                      v.names = "Medidas", 
                      timevar = "Dimensoes", 
                      times = names(iris)[1:4], 
                      idvar = "ID", 
                      direction = "long") 

head(iris_modificado)
View(iris_modificado)

bwplot(Medidas ~ Species | Dimensoes, data = iris_modificado)


iris_modificado_sp <- reshape(iris, 
                         varying = list(c(1,3),c(2,4)),
                         v.names = c("Comprimento", "Largura"), 
                         timevar = "Parte", 
                         times = c("Sepal", "Petal"),
                         idvar = "ID", 
                         direction = "long")

head(iris_modificado_sp)
View(iris_modificado_sp)

xyplot(Comprimento ~  Largura | Species, groups = Parte, 
       data = iris_modificado_sp, auto.key = list(space="right"))

xyplot(Comprimento ~  Largura | Parte, groups = Species, 
       data = iris_modificado_sp, auto.key = list(space="right"))


# Reshape2

install.packages("reshape2")
library(reshape2)

# Cria um dataframe

dataframe01 <- data.frame(nome = c("Zico", "Pele"), 
                          chuteira = c(40, 42),
                          idade = c(34,NA),
                          peso = c(93, NA),
                          altura = c(175, 178))

View(dataframe01)

# "Derretendo" o dataframe - Função melt() 

dataframe_wide01 = melt(dataframe01, id = c("nome", "chuteira"))
View(dataframe_wide)

# Remove valores "NA"

dataframe_wide02 = melt(dataframe01, id = c("nome", "chuteira"), na.rm = TRUE)
View(dataframe_wide)

# "Esticando" o dataframe

dcast(dataframe_wide01, formula = chuteira + nome ~ variable)
dcast(dataframe_wide01, formula = nome + chuteira  ~ variable)
dcast(dataframe_wide01, formula = nome  ~ variable)
dcast(dataframe_wide01, formula = ...  ~ variable)

# Aplica a função reshape2

names(airquality) <- tolower(names(airquality))
View(airquality)
dim(airquality)

# Função melt() - wide

?melt

dataframe_wide03 <- melt(airquality) 
class(dataframe_wide03)
View(dataframe_wide03)
head(dataframe_wide03)
tail(dataframe_wide03)

# Insere mais duas variáveis

dataframe_wide04 <- melt(airquality, id.vars = c("month", "day"))
View(dataframe_wide04)

dataframe_wide05 <- melt(airquality, id.vars = c("month", "day"),
                         variable.name = "climate_variable", 
                         value.name = "climate_value")

View(dataframe_wide05)

# Função dcast() - long

dataframe_wide06 <- melt(airquality, id.vars = c("month", "day"))
View(dataframe_wide06)
dataframe_long <- dcast(dataframe_wide06, month + day ~ variable)
View(dataframe_long)
head(airquality)
