
# Scatterplots

# Obs: Caso tenha problemas com a acentua��o, consulte este link:
# https://support.rstudio.com/hc/en-us/articles/200532197-Character-Encoding

# Configurando o diret�rio de trabalho
# Coloque entre aspas o diret�rio de trabalho que voc� est� usando no seu computador
# N�o use diret�rios com espa�o no nome

setwd("D:/BigDataAnalytics/Capitulo04")
getwd()

# Define os dados

x = rnorm(10,5,7)
y = rpois(10,7)
z = rnorm(10,6,7)
t = rpois(10,9)


# Cria o Plot

plot(x, y, col = 123, pch = 10, main = "Multi Scatterplot",
     col.main = "red", cex.main = 1.5, xlab = "Vari�vel Independente", 
     ylab = "Vari�vel Dependente")

# Adiciona outros dados 

points(z, t, col = "khaki3", pch = 4)

# Adiciona outros dados 

points(y, t, col = 777, pch = 9)

# Cria legenda

legend(-6,5.9, legend = c("N�vel 01", "N�vel 02", "N�vel 03"),
       col = c(123, "ivory", 777), pch = c(10,4,9),
       cex = 0.65, bty = "n")
