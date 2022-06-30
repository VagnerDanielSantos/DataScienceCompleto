
# Exercícios - Capítulo 13

# Obs: Caso tenha problemas com a acentuação, consulte este link:
# https://support.rstudio.com/hc/en-us/articles/200532197-Character-Encoding

# Configura o diretório de trabalho
# Coloque entre aspas o diretório de trabalho que você está usando no seu computador
# Não use diretórios com espaço no nome

setwd("D:/BigDataAnalytics/Capitulo13")
getwd()

# Para este script, vamos usar o mlbench (Machine Learning Benchmark Problems)
# https://cran.r-project.org/web/packages/mlbench/mlbench.pdf
# Este pacote contém diversos datasets e usaremos um com os dados 
# de votação do congresso americano 

# Seu trabalho é prever os votos em republicanos e democratas (variável Class)

# Instala e Carrega o pacote

install.packages("mlbench")
library(mlbench)

# Carrega o Dataset

?HouseVotes84

data("HouseVotes84")
View(HouseVotes84)

# Análise exploratória dos Dados

plot(as.factor(HouseVotes84[ ,2]))
title(main = "Votes cast for issue", xlab = "vote", ylab = "# reps")
plot(as.factor(HouseVotes84[HouseVotes84$Class == 'republican', 2]))
title(main = "Republican votes cast for issue 1", xlab = "vote", ylab = "# reps")
plot(as.factor(HouseVotes84[HouseVotes84$Class == 'democrat',2]))
title(main = "Democrat votes cast for issue 1", xlab = "vote", ylab = "# reps")

# Funções usadas para imputation
# Função que retorna o numeros de NA's por voto e classe (democrat or republican)

na_by_col_class <- function (col,cls)
  {
    return(sum(is.na(HouseVotes84[ ,col]) 
                & HouseVotes84$Class==cls))
  }

p_y_col_class <- function(col,cls)
  {
    sum_y <- sum(HouseVotes84[,col] == 'y' & HouseVotes84$Class == cls, na.rm = TRUE)
    sum_n <- sum(HouseVotes84[,col] == 'n' & HouseVotes84$Class == cls, na.rm = TRUE)
    return(sum_y/(sum_y+sum_n))
  }

# Testa a função

p_y_col_class(2,'democrat')
p_y_col_class(2,'republican')
na_by_col_class(2,'democrat')
na_by_col_class(2,'republican')

# Impute missing values

for (i in 2:ncol(HouseVotes84)) {
  if(sum(is.na(HouseVotes84[,i])>0)) {
    c1 <- which(is.na(HouseVotes84[,i]) & HouseVotes84$Class == 'democrat',arr.ind = TRUE)
    c2 <- which(is.na(HouseVotes84[,i]) & HouseVotes84$Class == 'republican',arr.ind = TRUE)
    HouseVotes84[c1,i] <- ifelse(runif(na_by_col_class(i,'democrat'))<p_y_col_class(i,'democrat'),'y','n')
    HouseVotes84[c2,i] <- ifelse(runif(na_by_col_class(i,'republican'))<p_y_col_class(i,'republican'),'y','n')}
}

# Gera Dados de treino e Dados de teste

HouseVotes84[,"train"] <- ifelse(runif(nrow(HouseVotes84)) < 0.80,1,0)
trainColNum <- grep("train",names(HouseVotes84))

# Gera os Dados de treino e de teste a partir da coluna de treino

trainHouseVotes84 <- HouseVotes84[HouseVotes84$train == 1, -trainColNum]
testHouseVotes84 <- HouseVotes84[HouseVotes84$train == 0, -trainColNum]

# Invocando o método NaiveBayes

install.packages("e1071")
library(e1071)

# Exercício 1 - Crie o modelo NaiveBayes e faça as previsões

# Treine o modelo

?naiveBayes

naiveBayes_01 <- naiveBayes(Class ~ ., data = trainHouseVotes84)

# Visualiza o Resultado

naiveBayes_01
View(naiveBayes_01)
summary(naiveBayes_01)
str(naiveBayes_01)

# Previsões

previsao_01 <- predict(naiveBayes_01, testHouseVotes84[ , -1])

# Matriz de Confusão (Confusion Matrix)

table(predicao = previsao_01, true = testHouseVotes84$Class)

# Média

media <- mean(previsao_01 == testHouseVotes84$Class)
print(media)

# Função para executar e registrar todos os resultados do modelo

naive_multiple_runs <- function(train_fraction, n)
  {
    fraction_correct <- rep(NA, n)
    
    for (i in 1:n) 
      {
        HouseVotes84[ , "train"] <- ifelse(runif(nrow(HouseVotes84)) < train_fraction, 1, 0)
        trainColNum <- grep('train', names(HouseVotes84))
        trainHouseVotes84 <- HouseVotes84[HouseVotes84$train == 1, -trainColNum]
        testHouseVotes84 <- HouseVotes84[HouseVotes84$train == 0, -trainColNum]
        naiveBayes_01 <- naiveBayes(Class ~ ., data = trainHouseVotes84)
        previsao_01 <- predict(naiveBayes_01, testHouseVotes84[ , -1])
        fraction_correct[i] <- mean(previsao_01 == testHouseVotes84$Class)
      }
      return(fraction_correct)
  }

# Executa o modelo 20 vezes

fraction_correct_predictions <- naive_multiple_runs(0.8, 20)
print(fraction_correct_predictions)

# Resumo dos Resultados

summary(fraction_correct_predictions)

# Desvio Padrão

sd(fraction_correct_predictions)

### Os resultados das execuções estão bem próximos, entre 0.83 e 0.97
### com um Desvio Padrão de 0.03
