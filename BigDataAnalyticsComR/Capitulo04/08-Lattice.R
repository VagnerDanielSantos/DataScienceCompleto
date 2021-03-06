
# Lattice

# Obs: Caso tenha problemas com a acentua��o, consulte este link:
# https://support.rstudio.com/hc/en-us/articles/200532197-Character-Encoding

# Configurando o diret�rio de trabalho
# Coloque entre aspas o diret�rio de trabalho que voc� est� usando no seu computador
# N�o use diret�rios com espa�o no nome

setwd("D:/BigDataAnalytics/Capitulo04")
getwd()

# O pacote Lattice � um sistema de visualiza��o de dados 
# de alto n�vel poderoso e elegante, com enfase em dados multivariados. 

# Na cria��o de gr�ficos, condi��es e agrupamentos s�o 2 conceitos
# importantes, que nos permitem compreender mais facilmente
# os dados que temos em m�os. 
# O conceito por tr�s do Lattice � agrupar os dados e criar visualiza��es de forma que fique 
# mais f�cil a busca por padr�es.

# Instala e carrega o pacote

install.packages('lattice')
library(lattice)

# ScatterPlot com Lattice

View(iris)
xyplot(data = iris, groups = Species, Sepal.Length ~ Petal.Length)

# BarPlots com dataset Titanic

?Titanic

barchart(Class ~ Freq | Sex + Age, data = as.data.frame(Titanic),
         groups = Survived, stack = T, layout = c(4, 1),
         auto.key = list(title = "Dados Titanic", columns = 2))

barchart(Class ~ Freq | Sex + Age, data = as.data.frame(Titanic),
         groups = Survived, stack = T, layout = c(4, 1),
         auto.key = list(title = "Dados Titanic", columns = 2),
         scales = list(x = "free"))


# Contagem de elementos

PetalLength <- equal.count(iris$Petal.Length, 4)
PetalLength

# ScatterPlots

xyplot(Sepal.Length~Sepal.Width | PetalLength, data = iris)


xyplot(Sepal.Length~Sepal.Width | PetalLength, data = iris,
       panel = function(...) {
         panel.grid(h = -1, v = -1, col.line = "skyblue")
         panel.xyplot(...)})


xyplot(Sepal.Length~Sepal.Width | PetalLength, data = iris,
       panel = function(x,y,...) {
         panel.xyplot(x,y,...)
         mylm <- lm(y~x)
         panel.abline(mylm)})


histogram(~Sepal.Length | Species, xlab = "",
          data = iris, layout=c(3,1), type = "density",
          main = "Histograma Lattice", sub = "Iris Dataset, Sepal Length")


# Distribui��o dos dados

qqmath(~ Sepal.Length | Species, data = iris, distribution = qunif)


# Boxplot

bwplot(Species~Sepal.Length, data = iris)


# ViolinPlot

bwplot(Species~Sepal.Length, data = iris,
       panel = panel.violin)
