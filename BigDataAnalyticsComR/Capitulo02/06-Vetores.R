
# Vetores, Opera��es com Vetores e Vetores Nomeados

# Obs: Caso tenha problemas com a acentua��o, consulte este link:
# https://support.rstudio.com/hc/en-us/articles/200532197-Character-Encoding

# Configurando o diret�rio de trabalho
# Coloque entre aspas o diret�rio de trabalho que voc� est� usando no seu computador
# N�o use diret�rios com espa�o no nome

setwd("D:/BigDataAnalytics/Capitulo02")
getwd()

# Vetor de strings

vetor_caracter = c("Data", "Science", "Academy")
vetor_caracter

# Vetor de floats

vetor_numerico = c(1.90, 45.3, 300.5) 
vetor_numerico

# Vetor de valores complexos

vetor_complexo = c(5.2+3i, 3.8+4i)
vetor_complexo

# Vetor de valores l�gicos

vetor_logico = c(TRUE, FALSE, TRUE, FALSE, FALSE) 
vetor_logico

# Vetor de n�meros inteiros

vetor_integer  = c(2, 4, 6)
vetor_integer

# Fun��o seq()

vetor01 = seq(1:10)
vetor01
is.vector(vetor01)

# Fun��o rep()

vetor02 = rep(1:5)
vetor02
is.vector(vetor02)

# Indexa��o de vetores

a <- c(1,2,3,4,5)
a
a[1]
a[6]

b <- c("Data", "Science", "Academy")
b
b[1]
b[2]
b[3]
b[4]

# Combina vetores

v1 = c(2, 3, 5) 
v2 = c("aa", "bb", "cc", "dd", "ee") 
c(v1, v2) 

# Opera��es com Vetores

x = c(1, 3, 5, 7) 
y = c(2, 4, 6, 8)

x * 5
x + y
x - y
x * y
x / y

# Soma vetores com n�meros diferentes de elementos

alfa = c(10, 20, 30) 
beta = c(1, 2, 3, 4, 5, 6, 7, 8, 9) 
alfa + beta 

# Vetor Nomeado

v = c("Nelson", "Mandela") 
v
names(v) = c("Nome", "Sobrenome") 
v
v["Nome"] 
