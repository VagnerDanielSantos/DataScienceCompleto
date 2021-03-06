
# Tipos b�sicos de Dados em R

# Obs: Caso tenha problemas com a acentua��o, consulte este link:
# https://support.rstudio.com/hc/en-us/articles/200532197-Character-Encoding

# Configurando o diret�rio de trabalho
# Coloque entre aspas o diret�rio de trabalho que voc� est� usando no seu computador
# N�o use diret�rios com espa�o no nome

setwd("D:/BigDataAnalytics/Capitulo02")
getwd()

#### Numeric - Todos os n�meros criados em R s�o do modo numeric
# S�o armazenados como n�meros decimais (double)

num1 <- 7
num1
class(num1)
mode(num1)
typeof(num1)

num2 = 16.82
num2
mode(num2)
typeof(num2)


#### Integer 
# Converte tipos numeric para integer

is.integer(num2)
y = as.integer(num2)
y
class(y)
mode(y)
typeof(y)

as.integer('3.17')
as.integer("Joe")
as.integer('Joe')
as.integer(TRUE)
as.integer(FALSE)
as.integer('TRUE')

#### Character

char1 = 'A'
char1
mode(char1)
typeof(char1)

char2 = "cientista"
char2
mode(char2)
typeof(char2)

char3 = c("Data", "Scicence", "Academy")
char3
mode(char3)
typeof(char3)

#### Complex

compl = 2.5 + 4i
compl
mode(compl)
typeof(compl)

sqrt(-1) 
sqrt(-1+0i)
sqrt(as.complex(-1)) 

#### Logic

x = 1; y = 2 
z = x > y
z
class(z)

u = TRUE; v = FALSE 
class(u)
u & v
u | v   
!u

#### Opera��es com 0 (Zero)

5/0
0/5

#### Erro

'Joe'/5
5 / 'Joe'
