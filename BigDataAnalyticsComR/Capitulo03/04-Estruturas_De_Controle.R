
# Estruturas de Controle

# Obs: Caso tenha problemas com a acentua��o, consulte este link:
# https://support.rstudio.com/hc/en-us/articles/200532197-Character-Encoding

# Configurando o diret�rio de trabalho
# Coloque entre aspas o diret�rio de trabalho que voc� est� usando no seu computador
# N�o use diret�rios com espa�o no nome

setwd("D:/BigDataAnalytics/Capitulo03")
getwd()

# If-else

x = 25
if (x < 30) 
  {"Este n�mero � menor que 30"}


#  As chaves N�O s�o obrigat�rias, mas altamente recomendados

if (x < 30) 
  "Este n�mero � menor que 30"


# Else

if (x < 7) {
  "Este n�mero � menor que 7"
} else {
  "Este n�mero n�o � menor que 7"
  }


# Comandos podem ser ainhados

x = 7
if (x < 7) {
  "Este n�mero � menor que 7"
} else if(x == 7) {
  "Este é o número 7"
}else{
  "Este n�mero n�o � menor que 7"
}


# Ifelse

x = 5
ifelse (x < 6, "Correto!", NA)

x = 9
ifelse (x < 6, "Correto!", NA)


# Express�es ifelse aninhadas

x = c(7,5,4)
ifelse(x < 5, "Menor que 5", 
       ifelse(x == 5, "Igual a 5", "Maior que 5"))


# Estruturas if dentro de fun��es

funcao01 <- function(x,y){
  ifelse(y < 7, x + y, "N�o encontrado")
}

funcao01(4,2)
funcao01(40,7)


# Rep

rep(rnorm(10), 5)

# Repeat

x = 1
repeat {
  x = x + 3
  if (x > 99)
    break
  print(x)}


# Loop For

for (i in 1:20) {print(i)}

for (q in rnorm(10)) {print(q)}


# Ignora alguns elementos dentro do loop

for(i in 1:22){
  if(i == 13 | i == 15)
    next
  print (i)}


# Interromper o loop

for(i in 1:22){
  if(i == 13)
    break
  print (i)}


# Loop While

x = 1
while(x < 5){
  x = x + 1
  print(x)
}

# O loop while n�o ser� executado

y = 6
while(y < 5){
  y = y+10
  print(y)
}
