
# Operadores na Linguagem R

# Obs: Caso tenha problemas com a acentua��o, consulte este link:
# https://support.rstudio.com/hc/en-us/articles/200532197-Character-Encoding

# Configurando o diret�rio de trabalho
# Coloque entre aspas o diret�rio de trabalho que voc� est� usando no seu computador
# N�o use diret�rios com espa�o no nome

setwd("D:/BigDataAnalytics/Capitulo02")
getwd()

#### Operadores B�sicos

# Soma

7 + 7

# Subtra��o

7 - 4

# Multiplica��o

5 * 5

# Divis�o 01

6 / 6

# Pot�ncia

3^2
3**2

# M�dulo

16 %% 3 


#### Operadores Relacionais

# Atribuindo vari�veis

x = 7
y = 5

# Operadores

x > 8
x < 8
x <= 8
x >= 8
x == 8
x != 8


# Operadores l�gicos

# And

(x==8) & (x==6)
(x==7) & (x>=5)
(x==8) & (x==7)

# Or

(x==8) | (x>5)
(x==8) | (x>=5)

# Not

x > 8
print(!x > 8)
