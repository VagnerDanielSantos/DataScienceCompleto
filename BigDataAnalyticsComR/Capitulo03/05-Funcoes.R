
# Fun��es

# Obs: Caso tenha problemas com a acentua��o, consulte este link:
# https://support.rstudio.com/hc/en-us/articles/200532197-Character-Encoding

# Configurando o diret�rio de trabalho
# Coloque entre aspas o diret�rio de trabalho que voc� est� usando no seu computador
# N�o use diret�rios com espa�o no nome

setwd("D:/BigDataAnalytics/Capitulo03")
getwd()

# Help

?sample
args(sample)
args(mean)
args(sd)


# Fun��es Built-in

abs(-43)
sum(c(1:5))
mean(c(1:5))
round(c(1.1:5.8))
rev(c(1:5))
seq(1:5)
sort(rev(c(1:5)))
append(c(1:5), 6)

vetor01 <- c(1.5, 2.5, 8.4, 3.7, 6.3)
vetor02<- rev(vetor01)
print(vetor02)


# Fun��es dentro de Fun��es

plot(rnorm(10))

mean(c(abs(vetor01), abs(vetor02)))

# Cria fun��es

myfunc <- function(x) { x + x }
myfunc(10)
class(myfunc)

myfunc2 <- function(a, b) {
  valor = a ^ b
  print(valor)
}
myfunc2(3, 2)

jogando_dados <- function() {
  num <- sample(1:6, size = 1) #Local
  num
}

jogando_dados()


# Escopo

print(num)
num <- c(1:6)
num #Global

# Fun��es sem n�mero definido de argumentos

vetor03 <- (10:13)
vetor04 <- c("a", "b", "c", "d")
vetor05 <- c(6.5, 9.2, 11.9, 5.1)

myfunc3 <- function(...){
  dataframe = data.frame(cbind(...))
  print(dataframe)
}

myfunc3(vetor01)

myfunc3(vetor02, vetor03)

myfunc3(vetor01, vetor02, vetor03)

# Fun��es Built-in - N�O tente recriar a roda
# compara��o de efici�ncia entre fun��o vetorizada e fun��o "vetorizada no R"

x <- 1:10000000

# Fun��o que calcula a raiz quadrada de cada elemento de um vetor de n�meros

meu_sqrt <- function(numeros) {
  resp <- numeric(length(numeros))
  for(i in seq_along(numeros)) {
    resp[i] <- sqrt(numeros[i])
  }
  return(resp)
}


system.time(x2a <- meu_sqrt(x))

system.time(x2b <- sqrt(x))

# Cada m�quina pode apresentar resultado diferente por conta da precis�o de c�lculo do processador.

identical(x2a, x2b)
