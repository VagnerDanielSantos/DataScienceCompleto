
# Subsetting

# Obs: Caso tenha problemas com a acentua��o, consulte este link:
# https://support.rstudio.com/hc/en-us/articles/200532197-Character-Encoding

# Configurando o diret�rio de trabalho
# Coloque entre aspas o diret�rio de trabalho que voc� est� usando no seu computador
# N�o use diret�rios com espa�o no nome

setwd("D:/BigDataAnalytics/Capitulo07")
getwd()


# Muitas das t�cnicas abaixo podem ser realizadas com a aplica��o das fun��es:
# subset(), merge(), plyr::arrange()
# Mas conhecer estas nota��es � fundamental para compreender como 
# gerar subconjuntos de dados


## Vetores

x <- c("A", "E", "D", "B", "C")
x[]
x


# �ndices Positivos - Elementos em posi��es espec�ficas

x[c(1, 3)]
x[c(1, 1)]
x[order(x)]


# �ndices Negativos - Ignora elementos em posi��es espec�ficas

x[-c(1, 3)]
x[-c(1, 4)]


# Vetor l�gigo para gerar subsetting

x[c(TRUE, FALSE)]
x
x[c(TRUE, FALSE, TRUE, FALSE)]

# Vetor de caracteres

x <- c("A", "B", "C", "D")
y <- setNames(x, letters[1:4])
y
y[c("d", "c", "a")]
y[c("a", "a", "a")]


## Matrizes

matriz <- matrix(1:9, nrow = 3)
colnames(matriz) <- c("A", "B", "C")
print(matriz)
matriz[1:2, ]
matriz[1:2, 2:3]

# Fun��o outer() permite que uma Matriz se comporte como vetores individuais

?outer

vals <- outer(1:5, 1:5, FUN = "paste", sep = ",")
vals
vals[c(4, 15)]


## Dataframes

dataframe01 <- data.frame(x = 1:3, y = 3:1, z = letters[1:3])
print(dataframe01)
dataframe01$x
dataframe01[dataframe01$x == 2, ]
dataframe01[c(1, 3), ]
dataframe01[c("x", "z")]
dataframe01[, c("x", "z")]
str(dataframe01["x"])
str(dataframe01[, "x"])

# Remove colunas de dataframes

dataframe02 <- data.frame(x = 1:3, y = 3:1, z = letters[1:3])
print(dataframe02)
dataframe02$z <- NULL
print(dataframe02)


# Operadores [], [[]] e $

a <- list(x = 1:3, y = 4:5)
a
a[1]
a[[1]]
a[[1]][[1]]
a[["x"]]

b <- list(a = list(b = list(c = list(d = 1))))
b
b[[c("a", "b", "c", "d")]]
b[["a"]][["b"]][["c"]][["d"]]


# x$y � equivalente a x[["y", exact = FALSE]]

var <- "cyl"
mtcars$var
View(mtcars)
mtcars[[var]]

x <- list(abc = 1)
x
x$a
x[["a"]]
x[["abc"]]


# Subsetting e atribui��o

x <- 1:5
x
x[c(1, 2)] <- 2:3
x

x[-1] <- 4:1
x

# Isso � subsetting

head(mtcars)
mtcars[] <- lapply(mtcars, as.integer)
head(mtcars)


# Isso N�O � subsetting

mtcars <- lapply(mtcars, as.integer)
head(mtcars)


# Lookup tables

x <- c("m", "f", "u", "f", "f", "m", "m")
lookup <- c(m = "Male", f = "Female", u = NA)
lookup[x]
unname(lookup[x])


# Usa operadores l�gicos

x1 <- 1:10 %% 2 == 0
x1
which(x1)
x2 <- which(x1)
x2
y1 <- 1:10 %% 5 == 0
y2 <- which(y1)
y2
intersect(x2, y2)
x1 & y1
union(x2, y2)
setdiff(x2, y2)
