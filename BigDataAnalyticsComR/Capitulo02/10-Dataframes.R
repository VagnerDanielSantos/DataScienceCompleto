
# DataFrames e Opera��es com DataFrame 

# Obs: Caso tenha problemas com a acentua��o, consulte este link:
# https://support.rstudio.com/hc/en-us/articles/200532197-Character-Encoding

# Configurando o diret�rio de trabalho
# Coloque entre aspas o diret�rio de trabalho que voc� est� usando no seu computador
# N�o use diret�rios com espa�o no nome

setwd("D:/BigDataAnalytics/Capitulo02")
getwd()

# Cria um dataframe vazio

dataframe01 <- data.frame()
class(dataframe01)
print(dataframe01)


# Cria vetores vazios

nomes <- character()
idades <- numeric()
itens <- numeric()
codigos <- integer()

dataframe02 <- data.frame(c(nomes, idades, itens, codigos))
print(dataframe02)

# Criavetores

pais = c("Portugal", "Inglaterra", "Irlanda", "Egito", "Brasil")
nome = c("Bruno", "Tiago", "Amanda", "Bianca", "Marta")
altura = c(1.88, 1.76, 1.53, 1.69, 1.68)
codigo = c(5001, 2183, 4702, 7965, 8890)

# Cria um dataframe de diversos vetores

pesquisa = data.frame(pais, nome, altura, codigo)
pesquisa

# Adicionando um novo vetor a um dataframe existente

olhos = c("verde", "azul", "azul", "castanho", "castanho")
pesquisa_olhos = cbind(pesquisa, olhos)
print(pesquisa_olhos)

# Informa��es sobre o dataframe

str(pesquisa)
dim(pesquisa)
length(pesquisa)

# Obt�m um vetor de um dataframe

pesquisa$pais
pesquisa$nome

# Extrai um �nico valor

pesquisa[1,1]
pesquisa[3,2]

# N�mero de Linhas e Colunas

nrow(pesquisa)
ncol(pesquisa)

# Primeiros elementos do dataframe

head(pesquisa)
head(mtcars)

# �ltimos elementos do dataframe

tail(pesquisa)
tail(mtcars)

# Data frames built-in do R

?mtcars
mtcars
View(mtcars)

# Filtro para um subset de Dados que atendem a um crit�rio

pesquisa[altura < 1.60,]
pesquisa[altura < 1.60, c('codigo', 'olhos')]
print(pesquisa)


# Dataframes Nomeados

names(pesquisa) <- c("C�digo","Pa�s", "Nome", "Altura", "Olhos")
print(pesquisa)

colnames(pesquisa) <- c("Var 1", "Var 2", "Var 3", "Var 4", "Var 5")
rownames(pesquisa) <- c("Obs 1", "Obs 2", "Obs 3", "Obs 4", "Obs 5")
print(pesquisa)

# Carrega um arquivo csv

?read.csv

pacientes <- data.frame(read.csv(file = 'D:/BigDataAnalytics/Capitulo02/Arquivos/pacientes.csv', 
                                 header = TRUE, 
                                 sep = ","))


# Visualiza o dataset

View(pacientes)
head(pacientes)
summary(pacientes)

# Visualiza as vari�veis

pacientes$Diabete
pacientes$status
pacientes$Status

# Histograma

hist(pacientes$Idade)

# Combina dataframes

dataset_final <- merge(pesquisa, pacientes)
dataset_final
