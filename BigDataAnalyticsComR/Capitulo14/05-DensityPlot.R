
# Análisa Density Plots - Este código contém comandos para análise de variáveis
# utilizando o Density Plot.

## Este código foi criado para executar tanto no Azure quanto no RStudio.
## Para executar no Azure, é necessário alterar o valor da variável "Azure" para TRUE.
## Se o valor for FALSE, o código será executado no RStudio

# Obs: Caso tenha problemas com a acentuação, consulte este link:
# https://support.rstudio.com/hc/en-us/articles/200532197-Character-Encoding

# Configura o diretório de trabalho
# Coloque entre aspas o diretório de trabalho que você está usando no seu computador
# Não use diretórios com espaço no nome

setwd("D:/BigDataAnalytics/Capitulo14")
getwd()

# Variável que controla a execução do Script

Azure <- FALSE

if(Azure)
{
  source('src/Tools.R')
  bikes <- manl.mapInputPort(1)
  bikes$dteday <- set.asPOSIXct(bikes)
}else
{
  bikes <- bikes
}

# Visualiza o relacionamento entre as variáveis preditoras e demanda por bikes

labels <- c('Demanda de Bikes x Temperatura',
            'Demanda de Bikes x Humidade',
            'Demanda de Bikes x Velocidade do vento',
            'Demanda de Bikes x Hora')

xAxis <- c('temp', 'hum', 'windspeed', 'hr')

# Função para os Density Plots

colours()
plot.scatter <- function(item, label)
  {
    ggplot(bikes, aes_string(x = item, y = 'cnt')) +
    geom_point(aes_string(color = 'cnt'), alpha = 0.2) +
    scale_colour_gradient(low = 'darkgoldenrod', high = 'blue') +
    geom_smooth(method = 'loess') +
    ggtitle(label) + 
    theme(text = element_text(size = 20))
  }

Map(plot.scatter, xAxis, labels)

# Explora a interação entre tempo e dia em dias da semana e final de semana

labels <- list('Boxplot - Demanda por bikes às 08:00 para \n dias da semana e finais de semana',
               'Boxplot - Demanda por bikes às 09:00 para \n dias da semana e finais de semana',
               'Boxplot - Demanda por bikes às 18:00 para \n dias da semana e finais de semana')

Times <- list(8, 9, 18)

plot.box <- function(time, label)
  {
    ggplot(bikes[bikes$hr == time, ], aes(x = isworking, y = cnt, group = isworking)) +
    geom_boxplot() +
    ggtitle(label) +
    theme(text = element_text(size = 18))
  }

Map(plot.box, Times, labels)

# Gera saída no Azure Machine Learning

if(Azure) maml.mapOutputPort('bikes')
