
# Boxplots

# Obs: Caso tenha problemas com a acentuação, consulte este link:
# https://support.rstudio.com/hc/en-us/articles/200532197-Character-Encoding

# Configurando o diretório de trabalho
# Coloque entre aspas o diretório de trabalho que você está usando no seu computador
# Não use diretórios com espaço no nome

setwd("D:/BigDataAnalytics/Capitulo04")
getwd()

?boxplot
?sleep

# Permite utilizar as colunas sem especificar o nome do dataset

attach(sleep)
View(sleep)

# Construção do boxplot

sleepboxplot = boxplot(data = sleep, extra ~ group,
                       main = "Duração do Sono",
                       col.main = "honeydew3", ylab = "Horas", xlab = "Droga")

# Cálculo da média

medias = by(extra, group, mean)

# Adiciona a média ao grupo

points(medias, col = "grey87")


# Boxplot horizontal

horizontalboxplot = boxplot(data = sleep, extra ~ group,
                            ylab = "", xlab = "", horizontal = T)

horizontalboxplot = boxplot(data = sleep, extra ~ group,
                            ylab = "", xlab = "", horizontal = T,
                            col = c("goldenrod4", "gray1") )
