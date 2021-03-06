
# Matrizes, Opera��es com Matrizes e Matrizes Nomeados 

# Obs: Caso tenha problemas com a acentua��o, consulte este link:
# https://support.rstudio.com/hc/en-us/articles/200532197-Character-Encoding

# Configurando o diret�rio de trabalho
# Coloque entre aspas o diret�rio de trabalho que voc� est� usando no seu computador
# N�o use diret�rios com espa�o no nome

setwd("D:/BigDataAnalytics/Capitulo02")
getwd()

# Cria Matrizes

# N�meros de Linhas

matrix (c(1,2,3,4,5,6), nr = 2)
matrix (c(1,2,3,4,5,6), nr = 3)
matrix (c(1,2,3,4,5,6), nr = 6)

# N�mero de Colunas

matrix (c(1,2,3,4,5,6), nr = 2)
matrix (c(1,2,3,4,5,6), nr = 3)
matrix (c(1,2,3,4,5,6), nr = 6)

# Help
?matrix

# Matrizes precisam ter um n�mero de elementos que seja m�ltiplo do n�mero de linhas

matrix (c(1,2,3,4,5), nc = 2)

# Cria matrizes a partir de vetores e preenche a partir das linhas

meus_dados = c(1:10)
matrix(data = meus_dados, nrow = 5, ncol = 2, byrow = T)
matrix(data = meus_dados, nrow = 5, ncol = 2)

# Fatia a Matriz

mat <- matrix(c(2,3,4,5), nr = 2)
mat
mat[1,2]
mat[2,2]
mat[1,3]
mat[,2]

# Cria uma matriz diagonal

matriz = 1:3
diag(matriz)

# Extrai um vetor de uma matriz diagonal

vetor = diag(matriz)
diag(vetor)

# Transposta da matriz

W <- matrix (c(2,4,8,12 ), nr = 2, ncol = 2)
W
t(W)
U <- t(W)
U

# Obt�m uma matriz inversa

solve(W)

# Multiplica��o de Matrizes

mat1 <- matrix(c(2,3,4,5), nr = 2)
mat1
mat2 <- matrix(c(6,7,8,9), nr = 2)
mat2
mat1 * mat2
mat1 / mat2
mat1 + mat2
mat1 - mat2

# Multiplica Matriz com Vetor

x = c(1:4)
x
y <- matrix(c(2,3,4,5), nr = 2)
x * y 

# Nomeando a Matriz

mat3 <- matrix(c('Terra', 'Marte', 'Saturno', 'Netuno'), nr = 2)
mat3
dimnames(mat3) = (list( c("Linha1", "Linha2"), c("Coluna1", "Coluna2")))
mat3

# Identifica linhas e colunas no momento de cria��o da Matriz

matrix (c(1,2,3,4), 
        nr = 2, nc = 2, 
        dimnames = list(c("Linha 1", "Linha 2" ), c( "Coluna 1", " Coluna 2") ))

# Combina Matrizes

mat4 <- matrix(c(2,3,4,5), nr = 2)
mat4
mat5 <- matrix(c(6,7,8,9), nr = 2)
mat5
cbind(mat4, mat5)
rbind(mat4, mat5)

# Desconstroi a Matriz

c(mat4)
