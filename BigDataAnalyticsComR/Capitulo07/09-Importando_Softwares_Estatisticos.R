
# Importando Dados de Softwares Estatísticos (SAS, STATA, SPSS) 


# Obs: Caso tenha problemas com a acentuação, consulte este link:
# https://support.rstudio.com/hc/en-us/articles/200532197-Character-Encoding

# Configurando o diretório de trabalho
# Coloque entre aspas o diretório de trabalho que você está usando no seu computador
# Não use diretórios com espaço no nome

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


# Se estiver familiarizado com estatística, poderá ter ouvido falar de correlação. 
# É uma medida para avaliar a dependência linear entre duas variáveis. 
# Ela pode variar entre -1 e 1; 
# Se próximo de 1, significa que há uma forte associação positiva entre as variáveis. 
# Se próximo de -1, existe uma forte associação negativa: 
# Quando a correlação entre duas variáveis é 0, essas variáveis são possivelmente independentes: 
# Ou seja, não há nenhuma associação entre X e Y.

# Coeficiente de Correlação. Indica uma associação negativa entre GDP e alfabetização feminina
cor(dataframe01_spss$gdp, dataframe01_spss$f_illit)


# **** Importante ****
# Correlação não implica causalidade
# A correlação, isto é, a ligação entre dois eventos, não implica 
# necessariamente uma relação de causalidade, ou seja, que um dos 
# eventos tenha causado a ocorrência do outro. A correlação pode 
# no entanto indicar possíveis causas ou áreas para um estudo mais 
# aprofundado, ou por outras palavras, a correlação pode ser uma 
# pista.
