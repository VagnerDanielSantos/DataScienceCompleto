
# Lista de Exerc�cios - Cap�tulo 05

# Obs: Caso tenha problemas com a acentua��o, consulte este link:
# https://support.rstudio.com/hc/en-us/articles/200532197-Character-Encoding

# Configurando o diret�rio de trabalho
# Coloque entre aspas o diret�rio de trabalho que voc� est� usando no seu computador
# N�o use diret�rios com espa�o no nome

setwd("D:/BigDataAnalytics/Capitulo05/Exercicios")
getwd()


# Exerc�cio 01 - Encontre e fa�a a corre��o do erro na instru��o abaixo:

# ERRADO
write.table(mtcars, file = "D:/BigDataAnalytics/Capitulo05/Exercicios/mtcars2.txt", sep = "|", col.names = N, qmethod = "double")

# CORRETO
write.table(mtcars, file = "D:/BigDataAnalytics/Capitulo05/Exercicios/mtcars2.txt", sep = "|", col.names = NA, qmethod = "double")

# Exerc�cio 02 - Encontre e fa�a a corre��o do erro na instru��o abaixo:

install.packages("readr")
library(readr)

# ERRADO
dataframe_iris <- read_csv("D:/BigDataAnalytics/Capitulo05/Exercicios/iris.csv", col_types = matrix(
  Sepal.Length = col_double(1),
  Sepal.Width = col_double(1),
  Petal.Length = col_double(1),
  Petal.Width = col_double(1),
  Species = col_factor(c("setosa", "versicolor", "virginica"))
))

# CORRETO

?read_csv
str(iris)

dataframe_iris <- read_csv("D:/BigDataAnalytics/Capitulo05/Exercicios/iris.csv", 
                           col_types = list(
                                            Sepal.Length = col_double(),
                                            Sepal.Width = col_double(),
                                            Petal.Length = col_double(),
                                            Petal.Width = col_double(),
                                            Species = col_factor(c("setosa", "versicolor", "virginica"))
))


# Exerc�cio 03 - Abaixo encontram-se dois histogramas criados separadamente.
# Mas isso dificulta a compara��o das distribui��es. Crie um novo plot que fa�a a uni�o 
# de ambos histogramas em apenas uma �rea de plotagem.

# Dados aleat�rios

dataset1=rnorm(4000 , 100 , 30)     
dataset2=rnorm(4000 , 200 , 30) 

# Histogramas

par(mfrow=c(1,2))
hist(dataset1, breaks=30 , xlim=c(0,300) , col=rgb(1,0,0,0.5) , xlab="Altura" , ylab="Peso" , main="" )
hist(dataset2, breaks=30 , xlim=c(0,300) , col=rgb(0,0,1,0.5) , xlab="Altura" , ylab="Peso" , main="")

hist(dataset1, breaks=30, xlim=c(0,300), col=rgb(1,0,0,0.5), xlab="Altura", ylab="N�mero de plantas", main="Distribui��o de altura de 2 vari�veis" )
hist(dataset2, breaks=30, xlim=c(0,300), col=rgb(0,0,1,0.5), add=T)
legend("topright", legend=c("Dataset 01","Dataset 02"), col=c(rgb(1,0,0,0.5), 
                                                            rgb(0,0,1,0.5)), pt.cex=2, pch=15 )

# Exerc�cio 04 - Encontre e corrija o erro no gr�fico abaixo:

install.packages("plotly")
library(plotly)
head(iris)

# ERRADO
plot_ly(iris, 
        x = ~Petal.Length, 
        y = ~Petal.Width,  
        type="scatter", 
        mode = "markers" , 
        color = Species , marker=list(size=20 , opacity=0.5))

# CORRETO
plot_ly(iris, 
        x = ~Petal.Length, 
        y = ~Petal.Width,  
        type="scatter", 
        mode = "markers" , 
        color = ~Species , marker=list(size=20 , opacity=0.5))

# Exerc�cio 05 - Em anexo encontra-se o arquivo exercicio5.png. 
# Crie o gr�fico que resulta nesta imagem.

# https://r-graph-gallery.com/3d-surface-plot.html
vulcao <- plot_ly(z = volcano, type = 'surface')
print(vulcao)

# Exerc�cio 06 - Carregue o arquivo input.json anexo a este script e imprima o conte�do no console
# Dica: Use o pacote rjson

install.packages("rjson")
require(rjson)

?rjson # Retorno os Dados no formato Lista

arquivo_input_json <- fromJSON(file = "D:/BigDataAnalytics/Capitulo06/Exercicios/input.json")
print(arquivo_input_json)
class(arquivo_input_json)
View(arquivo_input_json)

# Exerc�cio 07 - Converta o objeto criado ao carregar o arquivo json do exerc�cio anterior 
# em um dataframe e imprima o conte�do no console.

arquivo_json_dataframe <- as.data.frame(arquivo_input_json)
print(arquivo_json_dataframe)
class(arquivo_json_dataframe)
View(arquivo_json_dataframe)

# Exerc�cio 08 - Carregue o arquivo input.xml anexo a este script.
# Dica: Use o pacote XML

install.packages("XML")
require(XML)
require(methods)

arquivo_xml <- xmlParse(file = "D:/BigDataAnalytics/Capitulo06/Exercicios/input.xml")
print(arquivo_xml)
class(arquivo_xml)
View(arquivo_xml)

# Exerc�cio 09 - Converta o objeto criado no exerc�cio anterior em um dataframe

arquivo_input_xml <- xmlToDataFrame(arquivo_xml)
print(arquivo_input_xml)
class(arquivo_input_xml)
View(arquivo_input_xml)

# Exerc�cio 10 - Carregue o arquivo input.csv em anexo e ent�o responda as seguintes perguntas:

arquivo_csv <- read_csv("D:/BigDataAnalytics/Capitulo06/Exercicios/input.csv")
View(arquivo_csv)

# Pergunta 1 - Quantas linhas e quantas colunas tem o objeto resultante em R?

print(nrow(arquivo_csv))
print(ncol(arquivo_csv))

# Pergunta 2 - Qual o maior sal�rio?

maior_salario <- max(arquivo_csv$salary)
print(maior_salario)

# Pergunta 3 - Imprima no console o registro da pessoa com o maior sal�rio.

registro <- subset(arquivo_csv, salary == max(salary))
print(registro)
View(registro)

# Pergunta 4 - Imprima no console todas as pessoas que trabalham no departamento de IT.

dept_IT <- subset(arquivo_csv, dept == "IT")
print(dept_IT)
View(dept_IT)

# Pergunta 5 - Imprima no console as pessoas do departamento de IT com sal�rio superior a 600. 

dept_IT_salary <- subset(arquivo_csv, dept == "IT" & salary > 600)
print(dept_IT_salary)
View(dept_IT_salary)

