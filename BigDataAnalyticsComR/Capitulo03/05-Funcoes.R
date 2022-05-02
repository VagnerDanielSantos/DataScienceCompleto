
# Funções

# Obs: Caso tenha problemas com a acentuação, consulte este link:
# https://support.rstudio.com/hc/en-us/articles/200532197-Character-Encoding

# Configurando o diretório de trabalho
# Coloque entre aspas o diretório de trabalho que você está usando no seu computador
# Não use diretórios com espaço no nome

setwd("D:/BigDataAnalytics/Capitulo03")
getwd()

# Help

?sample
args(sample)
args(mean)
args(sd)


# Funções Built-in

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


# Funções dentro de Funções

plot(rnorm(10))

mean(c(abs(vetor01), abs(vetor02)))

# Cria funções

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

# Funções sem número definido de argumentos

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

# Funções Built-in - NÃO tente recriar a roda
# comparação de eficiência entre função vetorizada e função "vetorizada no R"

x <- 1:10000000

# Função que calcula a raiz quadrada de cada elemento de um vetor de números

meu_sqrt <- function(numeros) {
  resp <- numeric(length(numeros))
  for(i in seq_along(numeros)) {
    resp[i] <- sqrt(numeros[i])
  }
  return(resp)
}


system.time(x2a <- meu_sqrt(x))

system.time(x2b <- sqrt(x))

# Cada máquina pode apresentar resultado diferente por conta da precisão de cálculo do processador.

identical(x2a, x2b)
