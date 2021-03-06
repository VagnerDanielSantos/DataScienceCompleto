
# Fatores Dataframes

# Obs: Caso tenha problemas com a acentua��o, consulte este link:
# https://support.rstudio.com/hc/en-us/articles/200532197-Character-Encoding

# Configurando o diret�rio de trabalho
# Coloque entre aspas o diret�rio de trabalho que voc� est� usando no seu computador
# N�o use diret�rios com espa�o no nome

setwd("D:/BigDataAnalytics/Capitulo03")
getwd()

# N�veis dos fatores
# Internamente, a linguagem R armazena valores inteiros e faz um mapeamento para 
# as strings (em ordem alfab�tica) e agrupa as estat�sticas por n�veis.

# Criando vetores
vetor01 <- c(1001, 1002, 1003, 1004, 1005)
vetor02<- c(0, 1, 1, 0, 2)
vetor03 <- c('Verde','Laranja','Azul','Laranja','Verde')

# Une os vetores em um dataframe

dataframe <- data.frame(vetor01, vetor02, vetor03)
print(dataframe)

# Verifica que o R categorizou a �ltima coluna como fator

str(dataframe)

# Verifica os n�veis do fator. Perceba que os n�veis est�o categorizados em ordem alfab�tica

levels(dataframe$vetor03)

# Cria uma outra coluna e atribui labels

dataframe$cat1 <- factor(dataframe$vetor03, labels = c("cor2", "cor1", "cor3"))
print(dataframe)

# Internamente, os fatores s�o registrados como inteiros, mas a ordena��o 
# segue a ordem alfab�tica das strings

str(dataframe)

#### Veja como foi feita a atribui��o:

# Azul = cor2
# Laranja = cor1
# Verde = cor3

# Ou seja, os vetores com os labels, seguiram a ordem alfab�tica dos n�veis classificados 
# pela linguagem R

# Cria uma outra coluna e atribui labels
# Ao aplicarmos a fun��o factor() a coluna vetor02, internamente a linguagem R 
# classificou em ordem alfab�tica e quando foi atribu�do os labels, foi feita a associa��o.

dataframe$cat2 <- factor(dataframe$vetor02, labels = c("Divorciado", "Casado", "Solteiro"))
print(dataframe)
str(dataframe)
levels(dataframe$cat2)
