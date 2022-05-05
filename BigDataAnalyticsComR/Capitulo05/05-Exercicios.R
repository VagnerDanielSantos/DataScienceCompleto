
# Lista de Exercícios - Capítulo 05

# Obs: Caso tenha problemas com a acentuação, consulte este link:
# https://support.rstudio.com/hc/en-us/articles/200532197-Character-Encoding

# Configurando o diretório de trabalho
# Coloque entre aspas o diretório de trabalho que você está usando no seu computador
# Não use diretórios com espaço no nome

setwd("D:/BigDataAnalytics/Capitulo05/Exercicios")
getwd()


# Exercício 01 - Encontre e faça a correção do erro na instrução abaixo:

# ERRADO
write.table(mtcars, file = "D:/BigDataAnalytics/Capitulo05/Exercicios/mtcars2.txt", sep = "|", col.names = N, qmethod = "double")

# CORRETO
write.table(mtcars, file = "D:/BigDataAnalytics/Capitulo05/Exercicios/mtcars2.txt", sep = "|", col.names = NA, qmethod = "double")

# Exercício 02 - Encontre e faça a correção do erro na instrução abaixo:

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


# Exercício 03 - Abaixo encontram-se dois histogramas criados separadamente.
# Mas isso dificulta a comparação das distribuições. Crie um novo plot que faça a união 
# de ambos histogramas em apenas uma área de plotagem.

# Dados aleatórios

dataset1=rnorm(4000 , 100 , 30)     
dataset2=rnorm(4000 , 200 , 30) 

# Histogramas

par(mfrow=c(1,2))
hist(dataset1, breaks=30 , xlim=c(0,300) , col=rgb(1,0,0,0.5) , xlab="Altura" , ylab="Peso" , main="" )
hist(dataset2, breaks=30 , xlim=c(0,300) , col=rgb(0,0,1,0.5) , xlab="Altura" , ylab="Peso" , main="")

hist(dataset1, breaks=30, xlim=c(0,300), col=rgb(1,0,0,0.5), xlab="Altura", ylab="Número de plantas", main="Distribuição de altura de 2 variáveis" )
hist(dataset2, breaks=30, xlim=c(0,300), col=rgb(0,0,1,0.5), add=T)
legend("topright", legend=c("Dataset 01","Dataset 02"), col=c(rgb(1,0,0,0.5), 
                                                            rgb(0,0,1,0.5)), pt.cex=2, pch=15 )

# Exercício 04 - Encontre e corrija o erro no gráfico abaixo:

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

# Exercício 05 - Em anexo encontra-se o arquivo exercicio5.png. 
# Crie o gráfico que resulta nesta imagem.

# https://r-graph-gallery.com/3d-surface-plot.html
vulcao <- plot_ly(z = volcano, type = 'surface')
print(vulcao)

# Exercício 06 - Carregue o arquivo input.json anexo a este script e imprima o conteúdo no console
# Dica: Use o pacote rjson

install.packages("rjson")
require(rjson)

?rjson # Retorno os Dados no formato Lista

arquivo_input_json <- fromJSON(file = "D:/BigDataAnalytics/Capitulo06/Exercicios/input.json")
print(arquivo_input_json)
class(arquivo_input_json)
View(arquivo_input_json)

# Exercício 07 - Converta o objeto criado ao carregar o arquivo json do exercício anterior 
# em um dataframe e imprima o conteúdo no console.

arquivo_json_dataframe <- as.data.frame(arquivo_input_json)
print(arquivo_json_dataframe)
class(arquivo_json_dataframe)
View(arquivo_json_dataframe)

# Exercício 08 - Carregue o arquivo input.xml anexo a este script.
# Dica: Use o pacote XML

install.packages("XML")
require(XML)
require(methods)

arquivo_xml <- xmlParse(file = "D:/BigDataAnalytics/Capitulo06/Exercicios/input.xml")
print(arquivo_xml)
class(arquivo_xml)
View(arquivo_xml)

# Exercício 09 - Converta o objeto criado no exercício anterior em um dataframe

arquivo_input_xml <- xmlToDataFrame(arquivo_xml)
print(arquivo_input_xml)
class(arquivo_input_xml)
View(arquivo_input_xml)

# Exercício 10 - Carregue o arquivo input.csv em anexo e então responda as seguintes perguntas:

arquivo_csv <- read_csv("D:/BigDataAnalytics/Capitulo06/Exercicios/input.csv")
View(arquivo_csv)

# Pergunta 1 - Quantas linhas e quantas colunas tem o objeto resultante em R?

print(nrow(arquivo_csv))
print(ncol(arquivo_csv))

# Pergunta 2 - Qual o maior salário?

maior_salario <- max(arquivo_csv$salary)
print(maior_salario)

# Pergunta 3 - Imprima no console o registro da pessoa com o maior salário.

registro <- subset(arquivo_csv, salary == max(salary))
print(registro)
View(registro)

# Pergunta 4 - Imprima no console todas as pessoas que trabalham no departamento de IT.

dept_IT <- subset(arquivo_csv, dept == "IT")
print(dept_IT)
View(dept_IT)

# Pergunta 5 - Imprima no console as pessoas do departamento de IT com salário superior a 600. 

dept_IT_salary <- subset(arquivo_csv, dept == "IT" & salary > 600)
print(dept_IT_salary)
View(dept_IT_salary)

