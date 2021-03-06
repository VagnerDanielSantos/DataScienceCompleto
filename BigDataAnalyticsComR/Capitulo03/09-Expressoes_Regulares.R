
# Express�es Regulares

# Obs: Caso tenha problemas com a acentua��o, consulte este link:
# https://support.rstudio.com/hc/en-us/articles/200532197-Character-Encoding

# Configurando o diret�rio de trabalho
# Coloque entre aspas o diret�rio de trabalho que voc� est� usando no seu computador
# N�o use diret�rios com espa�o no nome

setwd("D:/BigDataAnalytics/Capitulo03")
getwd()

# grep(pattern, x, ignore.case = FALSE, perl = FALSE, value = FALSE, fixed = FALSE, useBytes = FALSE, invert = FALSE)
# grepl(pattern, x, ignore.case = FALSE, perl = FALSE, fixed = FALSE, useBytes = FALSE)
# sub(pattern, replacement, x, ignore.case = FALSE, perl = FALSE, fixed = FALSE, useBytes = FALSE)
# gsub(pattern, replacement, x, ignore.case = FALSE, perl = FALSE, fixed = FALSE, useBytes = FALSE)
# regexpr(pattern, text, ignore.case = FALSE, perl = FALSE, fixed = FALSE, useBytes = FALSE)
# gregexpr(pattern, text, ignore.case = FALSE, perl = FALSE, fixed = FALSE, useBytes = FALSE)

str <- c("Express�es", "regulares", "em linguagem R", 
         "permitem a busca de padr�es", "e explora��o de textos",
         "podemos buscar padr�es em d�gitos",
         "como por exemplo",
         "10992451280")

length(str)
str

# grep()

?grep

grep("ex", str, value = F)
grep("ex", str, value = T)
grep("\\d", str, value = F)
grep("\\d", str, value = T)


# grepl()

?grepl

grepl("\\d+", str)
grepl("\\D", str)


# gsub

?gsub

gsub("em", "***", str)
gsub("ex", "EX", str, ignore.case = T)


# sub()

sub("em", "EM", str)


# regexpr()

frase <- "Isso � uma string."
regexpr(pattern = "u", frase)


# gregexpr()

gregexpr(pattern = "u", frase)


str2 <- c("2678 � maior que 45 - @???!§$",
          "Vamos escrever 14 scripts R")

str2

# gsub()

gsub("\\d", "", str2)
gsub("\\D", "", str2)
gsub("\\s", "", str2)
gsub("[iot]", "Q", str2)
gsub("[[:punct:]]", "", str2)
