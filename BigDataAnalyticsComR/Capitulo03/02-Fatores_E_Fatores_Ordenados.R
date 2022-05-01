
# Fatores e Fatores Ordenados

# Obs: Caso tenha problemas com a acentuação, consulte este link:
# https://support.rstudio.com/hc/en-us/articles/200532197-Character-Encoding

# Configurando o diretório de trabalho
# Coloque entre aspas o diretório de trabalho que você está usando no seu computador
# Não use diretórios com espaço no nome

setwd("D:/BigDataAnalytics/Capitulo03")
getwd()

vetor01 <- c("Macho","Femea","Femea","Macho","Macho")
vetor01
fac_vetor01 <- factor(vetor01)
fac_vetor01
class(vetor01)
class(fac_vetor01)

# Variáveis categóricas nominais
# NÃO existe uma ordem implícita

animais <- c("Zebra", "Pantera", "Rinoceronte", "Macaco", "Tigre")
animais
class(animais)
fac_animais <- factor(animais)
fac_animais
class(fac_animais)
levels(fac_animais)

#### Variáveis categóricas ordinais
# Possuem uma ordem natural

graduacao <- c("Mestrado", "Doutorado", "Bacharelado", "Mestrado", "Mestrado")
print(graduacao)
fac_graduacao <- factor(graduacao, order = TRUE, levels = c("Doutorado", "Mestrado", "Bacharelado"))
fac_graduacao
levels(fac_graduacao)

# Sumarizar os dados fornece uma visão geral sobre o conteúdo das variáveis

summary(graduacao)
summary(fac_graduacao)

vetor02 <- c("M", "F", "F", "M", "M", "M", "F", "F", "M", "M", "M", "F", "F", "M", "M")
print(vetor02)
fac_vetor02 <- factor(vetor02)
fac_vetor02
levels(fac_vetor02) <- c("Femea", "Macho")
fac_vetor02
summary(fac_vetor02)
summary(vetor02)

# Mais exemplos

data = c(1,2,2,3,1,2,3,3,1,2,3,3,1)
fdata = factor(data)
fdata


rdata = factor(data, labels = c("I","II","III"))
rdata

# Fatores NÃO-Ordenados

set01 <- c("AA", "B", "BA", "CC", "CA", "AA", "BA", "CC", "CC")
set01

#### Transforma os dados. 
# A linguagem R apenas criou os níveis, o que não significa que exista uma hierarquia.

f.set01 <- factor(set01)
f.set01
class(f.set01)
is.ordered(f.set01)

# Fatores Ordenados

o.set1 <- factor(set01, 
                 levels = c("CA", "BA", "AA", "CC", "B"), 
                 ordered = TRUE)

o.set01
is.ordered(o.set01)

as.numeric(o.set01)
table(o.set01)


# Fatores e Dataframes

dataframe <- read.csv2("D:/BigDataAnalytics/Capitulo03/Arquivos/etnias.csv", sep = ',')
View(dataframe)


# Variáveis do tipo fator

str(dataframe)

# Níveis dos fatores
# Internamente, a linguagem R armazena valores inteiros e faz um mapeamento para as 
# strings (em ordem alfabética) e agrupa as estatísticas por níveis. 
# Agora, se fizermos a sumarização de estatísticas, é possível visualizar a 
# contabilização para cada categoria

levels(dataframe$Etnia)
summary(dataframe$Etnia)


#### Plot
# Agora se fizermos um plot, temos um boxplot para estas variáveis categórica

plot(dataframe$Idade ~ dataframe$Etnia, xlab = 'Etnia', ylab = 'Idade', main = 'Idade por Etnia')

# Regressão

summary(lm(Idade  ~Etnia, data = dataframe))

# Converte uma coluna em variável categórica. Isso criará um fator NÃO-ordenado

dataframe
str(dataframe)
dataframe$Estado_Civil.cat <- factor(dataframe$Estado_Civil, labels = c("Solteiro", "Casado", "Divorciado"))
print(dataframe)
str(dataframe)
