
# Exercícios - Capítulo 12

# Obs: Caso tenha problemas com a acentuação, consulte este link:
# https://support.rstudio.com/hc/en-us/articles/200532197-Character-Encoding

# Configurando o diretório de trabalho
# Coloque entre aspas o diretório de trabalho que você está usando no seu computador
# Não use diretórios com espaço no nome

setwd("D:/BigDataAnalytics/Capitulo12/Exercicios")
getwd()

# Existem diversos pacotes para arvores de recisao em R. Usaremos aqui o rpart.

install.packages('rpart')
library(rpart)

# Vamos utilizar um dataset que é disponibilizado junto com o pacote rpart

View(kyphosis)
str(kyphosis)
head(kyphosis)

?kyphosis

# Pequena análise exploratória

kyphosis_prop <- table(kyphosis$Kyphosis)
kyphosis_prop

# Exercício 01 - Depois de explorar o dataset, crie um modelo de árvore de decisão

?rpart

arvore <- rpart(Kyphosis ~ ., data = kyphosis, method = 'class')
View(arvore)
class(arvore)

# Para examinar o resultado de uma árvore de decisao, existem diversas funcões, mas você pode usar printcp()

printcp(arvore)

# Visualize a ávore (execute uma função para o plot e outra para o texto no plot)
# Utilize o zoom para visualizar melhor o gráfico

?plot
?text

plot(arvore, uniform = TRUE, main = "Arvore de Decisão para o conjunto de Dados 'Kyphosis'")
text(arvore, use.n = TRUE, all = TRUE)

# Este outro pacote faz a visualizaco ficar mais legivel

install.packages('rpart.plot')
library(rpart.plot)
prp(arvore)
