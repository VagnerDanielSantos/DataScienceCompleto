
# Coleta e Transforma os Dados

## Este código contém comandos para filtrar e transformar os Dados de aluguel de bikes,
## Dados que podem ser obtidos através do site da 'UCI'.

## Este código foi criado para executar tanto no Azure quanto no RStudio.
## Para executar no Azure, é necessário alterar o valor da variável "Azure" para TRUE.
## Se o valor for FALSE, o código será executado no RStudio.

# Obs: Caso tenha problemas com a acentuação, consulte este link:
# https://support.rstudio.com/hc/en-us/articles/200532197-Character-Encoding

# Configura o diretório de trabalho
# Coloque entre aspas o diretório de trabalho que você está usando no seu computador
# Não use diretórios com espaço no nome

setwd("D:/BigDataAnalytics/Capitulo14")
getwd()

# Variável que controla a execução do Script

Azure <- FALSE

# Execução de acordo com o valor da variável Azure

if(Azure)
  {
    source('src/Tools.R')
    bikes <- maml.mapInputPort(1)
    bikes$dteday <- set.asPOSIXct(bikes)
  }else  {
    source('src/Tools.R')
    bikes <- read.csv('D:/BigDataAnalytics/Capitulo14/Arquivos/bikes.csv',
                      sep = ",",
                      header = TRUE,
                      stringsAsFactors = FALSE)
    
    # Seleciona as variáveis que serão usadas
    cols <- c('dteday', 'mnth', 'hr', 'holiday', 'workingday', 
              'weathersit', 'temp', 'hum', 'windspeed', 'cnt')
    
    # Cria um subset dos Dados
    bikes <- bikes[ , cols]
    
    # Transforma o objeto de Data
    # A linha abaixo gera dois (2) valores 'NA'
    bikes$dteday <- char.toPOSIXct(bikes)
    
    # A linha abaixo corrige o erro
    bikes <- na.omit(bikes)
    
    # Normaliza as variáveis preditoras numéricas
    cols <- c('temp', 'hum', 'windspeed')
    bikes[ , cols] <- scale(bikes[ , cols])
  }

?scale

str(bikes)
View(bikes)

# Cria uma nova variável para indicar Dia da Semana (workday)

bikes$isworking <- ifelse(bikes$workingday & !bikes$holiday, 1, 0)

# Adiciona uma coluna com a quantidade de Meses, o que vai ajudar a criar o modelo

bikes <- month.count(bikes)
View(bikes)

# Cria um fator ordenado para o Dia da Semana, começando por Segunda-Feira
# Neste fator, é convertido para ordenado numérico para ser compatível com os tipos de Dados

bikes$dayweek <- as.factor(weekdays(bikes$dteday))
str(bikes)
View(bikes)


########## ATENÇÃO ##########

# ==> ANALISAR O DATASET BIKES <==
# Se os nomes dos Dias da Semana estiverem em Português na coluna bikes$dayweek,
# será necessário executar o bloco 01 abaixo, caso contrário, executar o bloco 02
# com os nomes em Inglês.
### Executar um bloco ou outro

str(bikes$dayweek)

### BLOCO 01

# Bloco para sistema operacional em Português, executar este código abaixo:

bikes$dayweek <- as.numeric(ordered(bikes$dayweek,
                                    levels = c('segunda-feira',
                                               'terça-feira',
                                               'quarta-feira',
                                               'quinta-feira',
                                               'sexta-feira',
                                               'sábado',
                                               'domingo')))

### BLOCO 02

# Bloco para sistema operacional em Inglês, executar este código abaixo:

bikes$dayweek <- as.numeric(ordered(bikes$dayweek,
                                    levels = c('Monday',
                                               'Tuesday',
                                               'Wednesday',
                                               'Thusday',
                                               'Friday',
                                               'Saturday',
                                               'Sunday')))

# Agora, os Dias da Semana devem estar como valores numéricos
# Se estiverem com valores 'NA', precisa voltar e verificar se foi seguido todas as 
# instruções acima.

str(bikes)
str(bikes$dayweek)

# Adiciona uma variável com valores únicos para o horário do Dia para Dia da Semana e 
# dias de Final de Semana.
# Com isso, será diferenciado as horas dos Dias de Semana, das Horas em Dias de
# Final de Semana.

bikes$workTime <- ifelse(bikes$isworking, bikes$hr, bikes$hr + 24)

# Transforma os valores de Hora na madrugada, quando a demanda por bicicletas é
# praticamente nula.
# Variável para HORAS DA MADRUGADA

bikes$xformHr <- ifelse(bikes$hr > 4, bikes$hr - 5, bikes$hr + 19)

# Adiciona uma variável com valores únicos para o horário do Dia para Dias da Semana
# e Final de Semana. Considerando HORAS DA MADRUGADA.

bikes$xformworkHr <- ifelse(bikes$isworking, bikes$xformHr, bikes$xformHr + 24)

str(bikes)
View(bikes)

# O trabalho que foi feito até aqui é chamado de Feature Engineering ou Engenharia de Atributos.

# Gera saída no Azure Machine Learning

if(Azure) maml.mapOutputPort('bikes')
