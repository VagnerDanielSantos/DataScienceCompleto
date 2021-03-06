
# Lista de Exerc�cios - Capitulo 04

# Obs: Caso tenha problemas com a acentua��o, consulte este link:
# https://support.rstudio.com/hc/en-us/articles/200532197-Character-Encoding

# Configurando o diret�rio de trabalho
# Coloque entre aspas o diret�rio de trabalho que voc� est� usando no seu computador
# N�o use diret�rios com espa�o no nome

setwd("D:/BigDataAnalytics/Capitulo04/Exercicios")
getwd()

# Exerc�cio 01 - Crie uma fun��o que receba os dois vetores abaixo como par�metros, 
# converta-os em um dataframe e imprima no console

vetor01 <- (10:13)
vetor02 <- c("a", "b", "c", "d")

dataframe01 <- function(h, j)
{
  dataframes = data.frame(cbind(h, j))
  print(dataframes)
}
dataframe01(vetor01, vetor02)
class(dataframe01)

# Exerc�cio 02  - Crie uma matriz com 4 linhas e 4 colunas preenchida com 
# n�meros inteiros e calcule a m�dia de cada linha

matriz01 <- matrix(60:75, nrow = 4, ncol = 4, byrow = TRUE)
print(matriz01)

rowMeans(matriz01)
print(matriz01)
### OU
apply(matriz01, 1, mean)

# Exerc�cio 03 - Considere o dataframe abaixo. 
# Calcule a m�dia por disciplina e depois calcule a m�dia de apenas uma disciplina

escola <- data.frame(Aluno = c('Alan', 'Alice', 'Alana', 'Aline', 'Alex', 'Ajay'),
                     Matematica = c(90, 80, 85, 87, 56, 79),
                     Geografia = c(100, 78, 86, 90, 98, 67),
                     Quimica = c(76, 56, 89, 90, 100, 87))

escola_copia <- escola

?apply
# C�lculo da m�dia por disciplinas
apply(escola_copia[ , 2:4], 2, mean)

# C�lculo da m�dia de uma disciplina
apply(escola_copia[ , 4, drop = FALSE], 2, mean)

# Exerc�cio 04 - Cria uma lista com 3 elementos, todos num�ricos 
# e calcule a soma de todos os elementos da lista

lista01 <- list(c(21:44), c(100: 412), c(1:1000))
print(lista01)

?do.call
do.call(sum, lista01)

# Exerc�cio 05 - Transforme a lista anterior um vetor

vetor03 <- unlist(lista01)
print(vetor03)
class(vetor03)

# Exerc�cio 06 - Considere a string abaixo. Substitua a palavra "textos" por "frases"

str <- c("Expressoes", "regulares", "em linguagem R", 
         "permitem a busca de padroes", "e exploracao de textos",
         "podemos buscar padroes em digitos",
         "como por exemplo",
         "10992451280")

?gsub

gsub("textos", "FRASES", str)

# Exerc�cio 07 - Usando o dataset mtcars, crie um gr�fico com ggplot do tipo 
# scatter plot. Use as colunas disp e mpg nos eixos x e y respectivamente

View(mtcars)

install.packages("ggplot2")
library(ggplot2)

?ggplot2

grafico01 <- ggplot(data = mtcars, aes(x = disp, y = mpg)) +
  geom_point()

print(grafico01)

# Exerc�cio 08 - Considere a matriz abaixo.
# Crie um barplot que represente os dados em barras individuais.

matriz01 <- matrix(c(652,1537,598,242,36,46,38,21,218,327,106,67), nrow = 3, byrow = T)
print(matriz01)

?barplot
grafico02 <- barplot(matriz01, beside = TRUE, col = c("blue", "yellow", "red"))
print(grafico02)

# Exerc�cio 09 - Qual o erro do c�digo abaixo?

### ERRADO
data(diamonds)
View(diamonds)

ggplot(data = diamonds, aes(x = price, group = fill, fill = cut)) + 
  geom_density(adjust = 1.5)

### CERTO = N�o existe uma coluna chamada fill para ser usada como agrupamento
data(diamonds)
ggplot(data = diamonds, aes(x = price, group = cut, fill = cut)) + 
  geom_density(adjust = 1.5)

# Exerc�cio 10 - Qual o erro do c�digo abaixo?

### ERRADO
ggplot(mtcars, aes(x = as.factor(cyl), fill = as.factor(cyl))) + 
  geom_barplot() +
  labs(fill = "cyl")

### CERTO = N�o existe a fun��o "geom_barplot" e sim "geom_bar"
ggplot(mtcars, aes(x = as.factor(cyl), fill = as.factor(cyl))) + 
  geom_bar() +
  labs(fill = "cyl")
