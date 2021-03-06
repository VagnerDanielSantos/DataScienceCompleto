
# Boxplots

# Obs: Caso tenha problemas com a acentua��o, consulte este link:
# https://support.rstudio.com/hc/en-us/articles/200532197-Character-Encoding

# Configurando o diret�rio de trabalho
# Coloque entre aspas o diret�rio de trabalho que voc� est� usando no seu computador
# N�o use diret�rios com espa�o no nome

setwd("D:/BigDataAnalytics/Capitulo04")
getwd()

?boxplot
?sleep

# Permite utilizar as colunas sem especificar o nome do dataset

attach(sleep)
View(sleep)

# Constru��o do boxplot

sleepboxplot = boxplot(data = sleep, extra ~ group,
                       main = "Dura��o do Sono",
                       col.main = "honeydew3", ylab = "Horas", xlab = "Droga")

# C�lculo da m�dia

medias = by(extra, group, mean)

# Adiciona a m�dia ao grupo

points(medias, col = "grey87")


# Boxplot horizontal

horizontalboxplot = boxplot(data = sleep, extra ~ group,
                            ylab = "", xlab = "", horizontal = T)

horizontalboxplot = boxplot(data = sleep, extra ~ group,
                            ylab = "", xlab = "", horizontal = T,
                            col = c("goldenrod4", "gray1") )
