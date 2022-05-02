
# Fatores Dataframes

# Obs: Caso tenha problemas com a acentuação, consulte este link:
# https://support.rstudio.com/hc/en-us/articles/200532197-Character-Encoding

# Configurando o diretório de trabalho
# Coloque entre aspas o diretório de trabalho que você está usando no seu computador
# Não use diretórios com espaço no nome

setwd("D:/BigDataAnalytics/Capitulo03")
getwd()

# Níveis dos fatores
# Internamente, a linguagem R armazena valores inteiros e faz um mapeamento para 
# as strings (em ordem alfabética) e agrupa as estatísticas por níveis.

# Criando vetores
vetor01 <- c(1001, 1002, 1003, 1004, 1005)
vetor02<- c(0, 1, 1, 0, 2)
vetor03 <- c('Verde','Laranja','Azul','Laranja','Verde')

# Une os vetores em um dataframe

dataframe <- data.frame(vetor01, vetor02, vetor03)
print(dataframe)

# Verifica que o R categorizou a última coluna como fator

str(dataframe)

# Verifica os níveis do fator. Perceba que os níveis estão categorizados em ordem alfabética

levels(dataframe$vetor03)

# Cria uma outra coluna e atribui labels

dataframe$cat1 <- factor(dataframe$vetor03, labels = c("cor2", "cor1", "cor3"))
print(dataframe)

# Internamente, os fatores são registrados como inteiros, mas a ordenação 
# segue a ordem alfabética das strings

str(dataframe)

#### Veja como foi feita a atribuição:

# Azul = cor2
# Laranja = cor1
# Verde = cor3

# Ou seja, os vetores com os labels, seguiram a ordem alfabética dos níveis classificados 
# pela linguagem R

# Cria uma outra coluna e atribui labels
# Ao aplicarmos a função factor() a coluna vetor02, internamente a linguagem R 
# classificou em ordem alfabética e quando foi atribuído os labels, foi feita a associação.

dataframe$cat2 <- factor(dataframe$vetor02, labels = c("Divorciado", "Casado", "Solteiro"))
print(dataframe)
str(dataframe)
levels(dataframe$cat2)
