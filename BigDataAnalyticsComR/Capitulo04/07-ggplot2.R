
# ggplot2

# Obs: Caso tenha problemas com a acentua��o, consulte este link:
# https://support.rstudio.com/hc/en-us/articles/200532197-Character-Encoding

# Configurando o diret�rio de trabalho
# Coloque entre aspas o diret�rio de trabalho que voc� est� usando no seu computador
# N�o use diret�rios com espa�o no nome

setwd("D:/BigDataAnalytics/Capitulo04")
getwd()

# Um sistema gr�fico completo, alternativo ao sistema b�sico de gr�ficos do R.
# Oferece mais op��es de modifica��es, legendas prontas e formata��o mais s�lida.

# https://cran.r-project.org/web/packages/ggplot2/ggplot2.pdf
# https://www.rstudio.com/wp-content/uploads/2015/03/ggplot2-cheatsheet.pdf

# Instala e carrega o pacote

install.packages("ggplot2")
library(ggplot2)

# Plota um gr�fico b�sico com qplot()

data(tips, package = 'reshape2')
View(tips)
qplot(total_bill, tip, data = tips, geom = "point")


# Camada 01
camada1 <- geom_point(
  mapping = aes(x = total_bill, y = tip, color = sex),
  data = tips,
  size = 3
)
ggplot() + camada1

?aes
??aes

# Contru�i um modelo de regress�o

modelo_base <- lm(tip ~ total_bill, data = tips)
modelo_fit <- data.frame(
  total_bill = tips$total_bill, 
  predict(modelo_base, interval = "confidence")
)

head(modelo_fit)


# Camada 02

camada2 <- geom_line(
  mapping = aes(x = total_bill, y = fit),
  data = modelo_fit,
  color = "darkred"
)
ggplot() + camada1 + camada2


# Camada 03

camada3 <- geom_ribbon(
  mapping = aes(x = total_bill, ymin = lwr, ymax = upr),
  data = modelo_fit,
  alpha = 0.3
)
ggplot() + camada1 + camada2 + camada3


# Vers�o final otimizada

ggplot(tips, aes(x = total_bill, y = tip)) +
  geom_point(aes(color = sex)) +
  geom_smooth(method = 'lm')


# Grava o gr�fico em um objeto

myplot <- ggplot(tips, aes(x = total_bill, y = tip)) +
  geom_point(aes(color = sex)) +
  geom_smooth(method = 'lm')

class(myplot)
print(myplot)


#### ScatterPlot com linha de regress�o

# Dados

data = data.frame(cond = rep(c("Obs 1", "Obs 2"), 
                           each = 10), var1 = 1:100 + 
                           rnorm(100,sd = 9), var2 = 1:100 + 
                           rnorm(100,sd = 16))


# Plot

ggplot(data, aes(x = var1, y = var2)) +    
  geom_point(shape = 1) +  
  geom_smooth(method = lm , color = "red", se = FALSE)  

?lm

#### Bar Plot

# Dados

data = data.frame(grupo = c("A ","B ","C ","D ") , 
                  valor = c(33,62,56,67) , 
                  num_obs = c(100,500,459,342))
 
# Gera a massa de dados

data$right = cumsum(data$num_obs) + 30 * c(0:(nrow(data)-1))
data$left = data$right - data$num_obs 
 
# Plot
ggplot(data, aes(ymin = 0)) + 
    geom_rect(aes(xmin = left, xmax = right, 
                  ymax = valor, colour = grupo, fill = grupo)) +
                  xlab("N�mero de observa��es") + ylab("Valor")
  
 

# Dataset mtcars

head(mtcars)
ggplot(data = mtcars, aes(x = disp, y = mpg)) + geom_point()


# Outro aspecto que pode ser mapeado nesse gr�fico � a cor dos pontos

ggplot(data = mtcars, 
       aes(x = disp, y = mpg, 
           colour = as.factor(am))) + geom_point()


# No entanto, tamb�m podemos mapear uma vari�vel cont�nua a cor dos pontos:

View(mtcars)
ggplot(mtcars, aes(x = disp, y = mpg, colour = cyl)) + geom_point()


# � poss�vel mapear o tamanho dos pontos a uma vari�vel de interesse:
# A legenda � inserida no gr�fico automaticamente

ggplot(mtcars, aes(x = disp, y = mpg, colour = cyl, size = wt)) + geom_point()


# Os geoms definem qual forma geom�trica ser� utilizada para a visualiza��o dos dados no gr�fico.

ggplot(mtcars, aes(x = as.factor(cyl), y = mpg)) + geom_boxplot()


# Histogramas

ggplot(mtcars, aes(x = mpg), binwidth = 30) + geom_histogram()


# Gr�fico de Barras

ggplot(mtcars, aes(x = as.factor(cyl))) + geom_bar()


# Personaliza os gr�ficos

colors()

ggplot(mtcars, aes(x = as.factor(cyl), y = mpg, 
                   colour = as.factor(cyl))) + geom_boxplot()

ggplot(mtcars, aes(x = as.factor(cyl), y = mpg, 
                   fill = as.factor(cyl))) + geom_boxplot()

ggplot(mtcars, 
       aes(x = as.factor(cyl), y = mpg)) + 
  geom_boxplot(color = "blue", fill = "seagreen4")


# � poss�vel alterar os eixos

ggplot(mtcars, aes(x = mpg)) + 
  geom_histogram() + 
  xlab("Milhas por gal�o") + ylab("Frequ�ncia")


# Legendas

ggplot(mtcars, aes(x = as.factor(cyl), fill = as.factor(cyl))) + 
  geom_bar() +
  labs(fill = "cyl")

# Troca a posi��o da legenda

ggplot(mtcars, aes(x = as.factor(cyl), fill = as.factor(cyl))) + 
  geom_bar() +
  labs(fill = "cyl") +
  theme(legend.position = "top")


# Sem legenda

ggplot(mtcars, aes(x = as.factor(cyl), fill = as.factor(cyl))) + 
  geom_bar() +
  guides(fill = FALSE)


# Facets

ggplot(mtcars, aes(x = mpg, y = disp, colour = as.factor(cyl))) + 
  geom_point() + 
  facet_grid(am~.)

ggplot(mtcars, aes(x = mpg, y = disp, colour = as.factor(cyl))) +
  geom_point() + 
  facet_grid(.~am)


# Plots diferentes juntos (diferente de Facet)

install.packages("gridExtra")
library(gridExtra)
library(ggplot2)
 
# Dataset diamonds

data(diamonds)


# Histograma como plot01

plot01 <- qplot(price, data = diamonds, binwidth = 1000)
 
# ScatterPlot como plot02

plot02 <- qplot(carat, price, data = diamonds, colour = cut)
 
# Combina os 2 plots na mesma �rea

grid.arrange(plot01, plot02, ncol = 1)


# Gr�ficos de Densidade

ggplot(data = diamonds, aes(x = price, group = cut, fill = cut)) + 
    geom_density(adjust = 1.5)
 
ggplot(data = diamonds, aes(x = price, group = cut, fill = cut)) + 
    geom_density(adjust = 1.5 , alpha = 0.2)
 
ggplot(data = diamonds,aes(x = price, group = cut, fill = cut)) + 
    geom_density(adjust = 1.5, position = "fill")


# Facets com reshape

install.packages("reshape2")
install.packages("plotly")
library(reshape2)
library(plotly)

sp <- ggplot(tips, aes(x = total_bill, y = tip/total_bill)) + geom_point(shape = 1)
sp + facet_grid(sex ~ .)
ggplotly()
sp + facet_grid(. ~ sex)
ggplotly()
sp + facet_wrap( ~ day, ncol = 2)
ggplotly()


ggplot(mpg, aes(displ, hwy)) + geom_point() + facet_wrap(~manufacturer)
ggplotly()
