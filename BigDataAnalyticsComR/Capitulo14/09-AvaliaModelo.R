
# Avaliação do modelo

# Este código foi criado para executar tanto no Azure, quanto no RStudio.
# Para executar no Azure, altere o valor da variavel Azure para TRUE. 
# Se o valor for FALSE, o codigo será executado no RStudio

# Obs: Caso tenha problemas com a acentuação, consulte este link:
# https://support.rstudio.com/hc/en-us/articles/200532197-Character-Encoding

# Configurando o diretório de trabalho
# Coloque entre aspas o diretório de trabalho que você está usando no seu computador
# Não use diretórios com espaço no nome

setwd("D:/BigDataAnalytics/Capitulo14")
getwd()

# Variável que controla a execução do script

Azure <- FALSE

if(Azure)
  {
    source("src/Tools.R")
    inFrame <- maml.mapInputPort(1)
    refFrame <- maml.mapInputPort(2)
    refFrame$dteday <- set.asPOSIXct2(refFrame)
  }else
  {
    source("src/Tools.R")
    inFrame <- scores[, c("actual", "prediction")]
    refFrame <- bikes
  }

# Cria um Dataframe

inFrame[, c("dteday", "monthCount", "hr", "xformWorkHr")] <- refFrame[, c("dteday", "monthCount", "hr", "xformWorkHr")]

# Nomeia o Dataframe

names(inFrame) <- c("cnt", "predicted", "dteday", "monthCount", "hr", "xformWorkHr")

#  Time series plot mostrando a diferença entre valores reais e valores previstos

library(ggplot2)

inFrame <- inFrame[order(inFrame$dteday),]
s <- c(7, 8, 9, 12, 15, 18, 19, 20, 22)

lapply(s, function(s){
  ggplot() +
    geom_line(data = inFrame[inFrame$hr == s, ], 
              aes(x = dteday, y = cnt)) +
    geom_line(data = inFrame[inFrame$hr == s, ], 
              aes(x = dteday, y = predicted), color = "red") +
    ylab("Numero de Bikes") +
    labs(title = paste("Demanda de Bikes às ",
                       as.character(s), ":00", spe ="")) +
    theme(text = element_text(size = 20))
})

# Computa os resíduos

library(dplyr)

inFrame <-  mutate(inFrame, resids = predicted - cnt)

# Plota os resíduos

ggplot(inFrame, aes(x = resids)) + 
  geom_histogram(binwidth = 1, fill = "white", color = "black")

qqnorm(inFrame$resids)
qqline(inFrame$resids)

# Plota os resíduos com as horas transformadas

inFrame <- mutate(inFrame, fact.hr = as.factor(hr),
                  fact.xformWorkHr = as.factor(xformWorkHr))                                  
facts <- c("fact.hr", "fact.xformWorkHr") 
lapply(facts, function(x){ 
  ggplot(inFrame, aes_string(x = x, y = "resids")) + 
    geom_boxplot( ) + 
    ggtitle("Residuos - Demanda de Bikes por Hora - Atual x Previsto")})


# Mediana dos resíduos por hora

evalFrame <- inFrame %>%
  group_by(hr) %>%
  summarise(medResidByHr = format(round(
    median(predicted - cnt), 2), 
    nsmall = 2)) 

# Computa a mediana dos resíduos

tempFrame <- inFrame %>%
  group_by(monthCount) %>%
  summarise(medResid = median(predicted - cnt)) 

evalFrame$monthCount <- tempFrame$monthCount
evalFrame$medResidByMcnt <- format(round(
  tempFrame$medResid, 2), 
  nsmall = 2)

print("Resumo dos residuos")
print(evalFrame)

# Output

outFrame <- data.frame(evalFrame)
if(Azure) maml.mapOutputPort('outFrame')
