
# Opera��es com Strings

# Obs: Caso tenha problemas com a acentua��o, consulte este link:
# https://support.rstudio.com/hc/en-us/articles/200532197-Character-Encoding

# Configurando o diret�rio de trabalho
# Coloque entre aspas o diret�rio de trabalho que voc� est� usando no seu computador
# N�o use diret�rios com espa�o no nome

setwd("D:/BigDataAnalytics/Capitulo02")
getwd()

# String

texto <- "Isso � uma string!"
texto

x = as.character(3.14) 
x
class(x) 


# Concatena Strings

nome = "Nelson"; sobrenome = "Mandela" 
paste(nome, sobrenome)
cat(nome, sobrenome)

# Formata a sa�da

sprintf("A %s � nota %d", "Data Science Academy", 10) 

# Extrai parte da string

texto <- "Isso � uma string!"
substr(texto, start=12, stop=17) 
?substr

# Conta o n�mero de caracteres

nchar(texto)

# Altera a capitaliza��o

tolower("Histogramas e EleMENTOS de DadOS")
toupper("Histogramas e EleMENtos de daDos")

# Fun��o stringr()

library(stringr)

# Dividi uma string em caracteres

?strsplit
strsplit("Histogramas e Elementos de Dados", NULL)

# Dividi uma string em caracteres, ap�s o caracter espa�o

strsplit("Histogramas e Elementos de Dados", " ")

# Trabalha com strings

string1 <- c("Esta � a primeira parte da minha string e ser� a primeira parte do meu vetor", 
             "Aqui a minha string continua, mas ser� transformada no segundo vetor")

string1

string2 <- c("Precisamos testar outras strings - @???!§$",
             "An�lise de Dados em R")

string2

# Adiciona 2 strings

str_c(c(string1, string2), sep = "")

# � poss�vel contar quantas vezes um caracter aparece no texto

str_count(string2, "s")

# Localiza a primeira e a �ltima posi��o em que o caracter aparece na string

str_locate_all(string2, "s")

# Substitui a primeira ocorr�ncia de um caracter

str_replace(string2, "\\s", "")

# Substitui todas as ocorr�ncias de um caracter

str_replace_all(string2, "\\s", "")

# Detecta padr�es nas strings

string1 <- "17 jan 2001"
string2 <- "1 jan 2001"
padrao <- "jan 20"
grepl(pattern = padrao, x = string1)
padrao <- "jan20"
grepl(pattern = padrao, x = string1)
