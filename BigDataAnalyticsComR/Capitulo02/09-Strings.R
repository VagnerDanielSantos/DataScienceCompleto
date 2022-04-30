
# Operações com Strings

# Obs: Caso tenha problemas com a acentuação, consulte este link:
# https://support.rstudio.com/hc/en-us/articles/200532197-Character-Encoding

# Configurando o diretório de trabalho
# Coloque entre aspas o diretório de trabalho que você está usando no seu computador
# Não use diretórios com espaço no nome

setwd("D:/BigDataAnalytics/Capitulo02")
getwd()

# String

texto <- "Isso é uma string!"
texto

x = as.character(3.14) 
x
class(x) 


# Concatena Strings

nome = "Nelson"; sobrenome = "Mandela" 
paste(nome, sobrenome)
cat(nome, sobrenome)

# Formata a saída

sprintf("A %s é nota %d", "Data Science Academy", 10) 

# Extrai parte da string

texto <- "Isso é uma string!"
substr(texto, start=12, stop=17) 
?substr

# Conta o número de caracteres

nchar(texto)

# Altera a capitalização

tolower("Histogramas e EleMENTOS de DadOS")
toupper("Histogramas e EleMENtos de daDos")

# Função stringr()

library(stringr)

# Dividi uma string em caracteres

?strsplit
strsplit("Histogramas e Elementos de Dados", NULL)

# Dividi uma string em caracteres, após o caracter espaço

strsplit("Histogramas e Elementos de Dados", " ")

# Trabalha com strings

string1 <- c("Esta é a primeira parte da minha string e será a primeira parte do meu vetor", 
             "Aqui a minha string continua, mas será transformada no segundo vetor")

string1

string2 <- c("Precisamos testar outras strings - @???!Â§$",
             "Análise de Dados em R")

string2

# Adiciona 2 strings

str_c(c(string1, string2), sep = "")

# É possível contar quantas vezes um caracter aparece no texto

str_count(string2, "s")

# Localiza a primeira e a última posição em que o caracter aparece na string

str_locate_all(string2, "s")

# Substitui a primeira ocorrência de um caracter

str_replace(string2, "\\s", "")

# Substitui todas as ocorrências de um caracter

str_replace_all(string2, "\\s", "")

# Detecta padrões nas strings

string1 <- "17 jan 2001"
string2 <- "1 jan 2001"
padrao <- "jan 20"
grepl(pattern = padrao, x = string1)
padrao <- "jan20"
grepl(pattern = padrao, x = string1)
