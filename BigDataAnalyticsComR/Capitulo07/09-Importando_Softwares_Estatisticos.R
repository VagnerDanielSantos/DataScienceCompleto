
# Importando Dados de Softwares Estat�sticos (SAS, STATA, SPSS) 


# Obs: Caso tenha problemas com a acentua��o, consulte este link:
# https://support.rstudio.com/hc/en-us/articles/200532197-Character-Encoding

# Configurando o diret�rio de trabalho
# Coloque entre aspas o diret�rio de trabalho que voc� est� usando no seu computador
# N�o use diret�rios com espa�o no nome

setwd("D:/BigDataAnalytics/Capitulo07")
getwd()


# Instala o pacote

install.packages("haven")
library(haven)

# SAS

?read_sas

vendas_sas <- read_sas("D:/BigDataAnalytics/Capitulo07/Arquivos/vendas.sas")
class(vendas_sas)
print(vendas_sas)
str(vendas_sas)


# Stata

dataframe_stata <- read_dta("D:/BigDataAnalytics/Capitulo07/Arquivos/mov.dta")
class(dataframe_stata)
str(dataframe_stata)
View(dataframe_stata)


# Pacote Foreign

install.packages("foreign")
library(foreign)

# Stata

florida_stata <- read.dta("D:/BigDataAnalytics/Capitulo07/Arquivos/florida.dta")
tail(florida_stata)
class(florida_stata)
View(florida_stata)


# SPSS
# http://cw.routledge.com/textbooks/9780415372985/resources/datasets.asp

dados_spss <- read.spss("D:/BigDataAnalytics/Capitulo07/Arquivos/international.sav")
class(dados_spss)
head(dados_spss)
dataframe01_spss <- data.frame(dados_spss)
View(dataframe01_spss)
head(dataframe01_spss)

# Cria um boxplot

boxplot(dataframe01_spss$gdp)


# Se estiver familiarizado com estat�stica, poder� ter ouvido falar de correla��o. 
# � uma medida para avaliar a depend�ncia linear entre duas vari�veis. 
# Ela pode variar entre -1 e 1; 
# Se pr�ximo de 1, significa que h� uma forte associa��o positiva entre as vari�veis. 
# Se pr�ximo de -1, existe uma forte associa��o negativa: 
# Quando a correla��o entre duas vari�veis � 0, essas vari�veis s�o possivelmente independentes: 
# Ou seja, n�o h� nenhuma associa��o entre X e Y.

# Coeficiente de Correla��o. Indica uma associa��o negativa entre GDP e alfabetiza��o feminina
cor(dataframe01_spss$gdp, dataframe01_spss$f_illit)


# **** Importante ****
# Correla��o n�o implica causalidade
# A correla��o, isto �, a liga��o entre dois eventos, n�o implica 
# necessariamente uma rela��o de causalidade, ou seja, que um dos 
# eventos tenha causado a ocorr�ncia do outro. A correla��o pode 
# no entanto indicar poss�veis causas ou �reas para um estudo mais 
# aprofundado, ou por outras palavras, a correla��o pode ser uma 
# pista.
