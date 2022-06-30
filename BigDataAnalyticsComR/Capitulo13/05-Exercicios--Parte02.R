
# Exercícios - Capítulo 13

# Obs: Caso tenha problemas com a acentuação, consulte este link:
# https://support.rstudio.com/hc/en-us/articles/200532197-Character-Encoding

# Configurando o diretório de trabalho
# Coloque entre aspas o diretório de trabalho que você está usando no seu computador
# Não use diretórios com espaço no nome

setwd("D:/BigDataAnalytics/Capitulo13")
getwd()


# Para este exemplo, usaremos o dataset Titanic do Kaggle. 
# Este dataset é famoso e usamos parte dele nas aulas de SQL.
# Ele normalmente é usado por aqueles que estão começando em Machine Learning.

# Vamos prever uma classificação - sobreviventes e não sobreviventes

# https://www.kaggle.com/c/titanic/data


# Começamos carregando o Dataset de Dados_treino

?Titanic

dados_treino <- read.csv('D:/BigDataAnalytics/Capitulo13/Arquivos/titanic-train.csv')
View(dados_treino)

# Analise exploratória de dados
# Vamos usar o pacote Amelia e suas funções para definir o volume de dados Missing
# Clique no zoom para visualizar o grafico
# Cerca de 20% dos dados sobre idade estão Missing (faltando)

install.packages("Amelia")
library(Amelia)

?missmap

missmap(dados_treino, 
        main = "Titanic Training Data - Mapa de Dados Missing", 
        col = c("blue", "black"), 
        legend = TRUE)

# Visualiza os Dados

install.packages('ggplot2')
library(ggplot2)

table(dados_treino$Survived)
#mean(dados_treino$Age)

ggplot(dados_treino,aes(Survived)) + geom_bar()
ggplot(dados_treino,aes(Pclass)) + geom_bar(aes(fill = factor(Pclass)), alpha = 0.5)
ggplot(dados_treino,aes(Sex)) + geom_bar(aes(fill = factor(Sex)), alpha = 0.5)
ggplot(dados_treino,aes(Age)) + geom_histogram(fill = 'blue', bins = 20, alpha = 0.5)
ggplot(dados_treino,aes(SibSp)) + geom_bar(fill = 'red', alpha = 0.5)
ggplot(dados_treino,aes(Fare)) + geom_histogram(fill = 'green', color = 'black', alpha = 0.5)

# Limpa os Dados
# Para tratar os Dados missing, usaremos o recurso de imputation.
# Essa técnica visa substituir os valores missing por outros valores,
# que podem ser a média da variável ou qualquer outro valor escolhido pelo Cientista de Dados

# Por exemplo, vamos verificar as idades por classe de passageiro (baixa, média, alta):

pl <- ggplot(dados_treino, aes(Pclass,Age)) + geom_boxplot(aes(group = Pclass, fill = factor(Pclass), alpha = 0.4)) 
pl + scale_y_continuous(breaks = seq(min(0), max(80), by = 2))

# Vimos que os passageiros mais ricos, nas classes mais altas, tendem a serem mais velhos. 
# Usaremos esta média para imputar as idades Missing

impute_age <- function(age, class){
  out <- age
  for (i in 1:length(age)){
    
    if (is.na(age[i])){
      
      if (class[i] == 1){
        out[i] <- 37
        
      }else if (class[i] == 2){
        out[i] <- 29
        
      }else{
        out[i] <- 24
      }
    }else{
      out[i]<-age[i]
    }
  }
  return(out)
}

fixed.ages <- impute_age(dados_treino$Age, dados_treino$Pclass)
dados_treino$Age <- fixed.ages

# Visualiza o mapa de valores missing (Não existem mais dados missing)

missmap(dados_treino, 
        main = "Titanic Training Data - Mapa de Dados Missing", 
        col = c("pink", "black"), 
        legend = TRUE)


# Exercício 1 - Crie o modelo de classificação e faça as previsões

# Instala e Carrega pacote

install.packages('dplyr')
install.packages('caTools')

library(dplyr)
library(caTools)

# Limpeza dos Dados

str(dados_treino)
View(dados_treino)
dados_treino <- select(dados_treino, -PassengerId, -Name, -Ticket, -Cabin)
View(dados_treino)
str(dados_treino)

# Treina o modelo

?glm

linearmodel01 <- glm(formula = Survived ~ ., 
                     family = binomial(link = 'logit'), 
                     data = dados_treino)

# Verifica as variáveis mais significativas (Sex, Age, Pclass)

summary(linearmodel01)

# Split dos Dados

split <- sample.split(dados_treino$Survived, SplitRatio = 0.70)

# Datasetes de treino e teste

dados_treino_final <- subset(dados_treino, split == TRUE)
dados_teste_final <- subset(dados_treino, split == FALSE)

# Gera o modelo com a versão final do Dataset

linearmodel_final <- glm(formula = Survived ~ .,
                         family = binomial(link = 'logit'),
                         data = dados_treino_final)

# Resumo

summary(linearmodel_final)

# Preve a acurácia

fitted.probabilities <- predict(linearmodel_final,
                               newdata = dados_teste_final,
                               type = 'response')

# Calcula os valores

fitted.results <- ifelse(fitted.probabilities > 0.5, 1, 0)

# Foi obtido 80% de Acurácia

misClasificError <- mean(fitted.results != dados_teste_final$Survived)
print(paste('A acurácia é de: ', 1 - misClasificError))

# Cria a Confusion Matrix

table(dados_teste_final$Survived, fitted.probabilities > 0.5)
