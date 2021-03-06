
# Bar Plots

# Obs: Caso tenha problemas com a acentua��o, consulte este link:
# https://support.rstudio.com/hc/en-us/articles/200532197-Character-Encoding

# Configurando o diret�rio de trabalho
# Coloque entre aspas o diret�rio de trabalho que voc� est� usando no seu computador
# N�o use diret�rios com espa�o no nome

setwd("D:/BigDataAnalytics/Capitulo04")
getwd()

?barplot

# Prepara os dados - n�mero de casamentos em uma igreja de SP

dados <- matrix(c(652,1537,598,242,36,46,38,21,218,327,106,67), nrow = 3, byrow = T)
dados

# Nomeia linhas e colunas na matriz

colnames(dados) <- c("0","1-150","151-300",">300")
rownames(dados) <- c("Jovem","Adulto","Idoso")
dados

# Constr�i o Barplot

barplot(dados, beside = T)
barplot(dados)

# Constr�i o plot - Stacked Bar Plot
# As 3 faixas de idade s�o representadas na mesma coluna para as diferentes quantidades

barplot(dados, col = c("steelblue1", "tan3", "seagreen3"))

# Crie uma legenda para o gr�fico anterior

colors()

legend("topright", pch = 1, col = c("steelblue1", "tan3", "seagreen3"), legend = c("Jovem","Adulto","Idoso"))

# Agora temos uma coluna para cada faixa et�ria, mas na mesma faixa de quantidade

barplot(dados, beside = T, col = c("steelblue1", "tan3", "seagreen3"))
legend("topright", pch = 1, col = c("steelblue1", "tan3", "seagreen3"), legend = c("Jovem","Adulto","Idoso"))

# Com a Transposta da matriz, invertemos as posi��es entre faixa et�ria e faixa de quantidade

t(dados)

barplot(t(dados), beside = T, col = c("steelblue1", "tan3", "seagreen3", "peachpuff1"))
legend("topright", pch = 1, col = c("steelblue1", "tan3", "seagreen3", "peachpuff1"), legend = c("0","1-150","151-300",">300"))
