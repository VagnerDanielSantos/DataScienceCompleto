
# Big Data na pr�tica 04 - Customer Churn Analytics 

# A rotatividade (churn) de clientes ocorre quando clientes ou assinantes param de fazer neg�cios 
# com uma empresa ou servi�o. Tamb�m � conhecido como perda de clientes ou taxa de cancelamento.

# Um setor no qual saber e prever as taxas de cancelamento e particularmente �til � o setor de telecomunica��es, 
# porque a maioria dos clientes tem v�rias op��es de escolha dentro de uma localiza��o geogr�fica.

# Neste projeto, vamos prever a rotatividade (churn) de clientes usando um conjunto de dados de telecomunica��es. 
# Usaremos a Regress�o Log�stica, a �rvore de Decis�o e a Floresta Aleat�ria como modelos de Machine Learning. 

# Usaremos um Dataset oferecido gratuitamente no portal IBM Sample Data Sets. 
# Cada linha representa um cliente e cada coluna cont�m os atributos desse cliente.

# https://www.ibm.com/communities/analytics/watson-analytics-blog/guide-to-sample-datasets/

# Obs: Caso tenha problemas com a acentua��o, consulte este link:
# https://support.rstudio.com/hc/en-us/articles/200532197-Character-Encoding

# Configurando o diret�rio de trabalho
# Coloque entre aspas o diret�rio de trabalho que voc� est� usando no seu computador
# N�o use diret�rios com espa�o no nome

setwd("D:/BigDataAnalytics/Capitulo06")
getwd()


# Carrega os pacotes

library(plyr)
library(corrplot)
library(ggplot2)
library(gridExtra)
library(ggthemes)
library(caret)
library(MASS)
library(randomForest)
library(party)


##### Carrega e Limpa os Dados ##### 

# Os dados brutos cont�m 7043 linhas (clientes) e 21 colunas (recursos). 
# A coluna "Churn" � o nosso alvo.

churn <- read.csv('D:/BigDataAnalytics/Capitulo06/Arquivos/Telco-Customer-Churn.csv')

View(churn)
str(churn)


# Usamos sapply para verificar o n�mero de valores ausentes (missing) em cada coluna. 
# Descobrimos que h� 11 valores ausentes nas colunas "TotalCharges". 
# Ent�o, vamos remover todas as linhas com valores ausentes.

sapply(churn, function(x) sum(is.na(x)))
churn <- churn[complete.cases(churn), ]


# Olhe para as vari�veis, podemos ver que temos algumas limpezas e ajustes para fazer.

# 1. Vamos mudar "No internet service" para "No" por seis colunas, que s�o: 
# "OnlineSecurity", "OnlineBackup", "DeviceProtection", "TechSupport", "streamingTV", 
# "streamingMovies".

str(churn)
cols_recode1 <- c(10:15)

for(i in 1:ncol(churn[,cols_recode1])) {
  churn[,cols_recode1][,i] <- as.factor(mapvalues
                                        (churn[,cols_recode1][,i], from =c("No internet service"),to=c("No")))
}


# 2. Vamos mudar "No phone service" para "No" para a coluna MultipleLines

churn$MultipleLines <- as.factor(mapvalues(churn$MultipleLines, 
                                           from=c("No phone service"),
                                           to=c("No")))


# 3. Como a perman�ncia m�nima � de 1 m�s e a perman�ncia m�xima s�o de 72 meses, 
# podemos agrup�-los em cinco grupos de posse (tenure): 

# De 0 - 12 meses, 12 - 24 meses, 24 - 48 meses, 48 - 60 meses e + de 60 meses

min(churn$tenure); max(churn$tenure)

group_tenure <- function(tenure){
  if (tenure >= 0 & tenure <= 12){
    return('0-12 Month')
  }else if(tenure > 12 & tenure <= 24){
    return('12-24 Month')
  }else if (tenure > 24 & tenure <= 48){
    return('24-48 Month')
  }else if (tenure > 48 & tenure <=60){
    return('48-60 Month')
  }else if (tenure > 60){
    return('> 60 Month')
  }
}

churn$tenure_group <- sapply(churn$tenure,group_tenure)
churn$tenure_group <- as.factor(churn$tenure_group)


# 4. Alteramos os valores na coluna SeniorCitizen de 0 ou 1 para "NO" OU "YES.

churn$SeniorCitizen <- as.factor(mapvalues(churn$SeniorCitizen,
                                           from = c("0","1"),
                                           to = c("No", "Yes")))



# 5. Removemos as colunas que n�o precisamos para a an�lise.

churn$customerID <- NULL
churn$tenure <- NULL
View(churn)


##### An�lise explorat�ria de Dados e sele��o de recursos ##### 

# Correla�ao entre vari�veis num�ricas

numeric.var <- sapply(churn, is.numeric)
corr.matrix <- cor(churn[,numeric.var])

corrplot(corr.matrix, main="\n\nGr�fico de Correla��o para Vari�veis Num�ricas", 
         method="number")


# Os encargos mensais e os encargos totais est�o correlacionados. 
# Ent�o, um deles ser� removido do modelo. Nós removemos Total Charges.

churn$TotalCharges <- NULL


# Gr�ficos de barra de vari�veis categ�ricas

plot01 <- ggplot(churn, aes(x=gender)) + ggtitle("Gender") + xlab("Sexo") +
  geom_bar(aes(y = 100*(..count..)/sum(..count..)), width = 0.5) + ylab("Percentual") + coord_flip() + theme_minimal()
plot02 <- ggplot(churn, aes(x=SeniorCitizen)) + ggtitle("Senior Citizen") + xlab("Senior Citizen") + 
  geom_bar(aes(y = 100*(..count..)/sum(..count..)), width = 0.5) + ylab("Percentual") + coord_flip() + theme_minimal()
plot03 <- ggplot(churn, aes(x=Partner)) + ggtitle("Partner") + xlab("Parceiros") + 
  geom_bar(aes(y = 100*(..count..)/sum(..count..)), width = 0.5) + ylab("Percentual") + coord_flip() + theme_minimal()
plot04 <- ggplot(churn, aes(x=Dependents)) + ggtitle("Dependents") + xlab("Dependentes") +
  geom_bar(aes(y = 100*(..count..)/sum(..count..)), width = 0.5) + ylab("Percentual") + coord_flip() + theme_minimal()
grid.arrange(p1, p2, p3, p4, ncol=2)


plot05 <- ggplot(churn, aes(x=PhoneService)) + ggtitle("Phone Service") + xlab("Telefonia") +
  geom_bar(aes(y = 100*(..count..)/sum(..count..)), width = 0.5) + ylab("Percentual") + coord_flip() + theme_minimal()
plot06 <- ggplot(churn, aes(x=MultipleLines)) + ggtitle("Multiple Lines") + xlab("Múltiplas Linhas") + 
  geom_bar(aes(y = 100*(..count..)/sum(..count..)), width = 0.5) + ylab("Percentual") + coord_flip() + theme_minimal()
plot07 <- ggplot(churn, aes(x=InternetService)) + ggtitle("Internet Service") + xlab("Internet Service") + 
  geom_bar(aes(y = 100*(..count..)/sum(..count..)), width = 0.5) + ylab("Percentual") + coord_flip() + theme_minimal()
plot08 <- ggplot(churn, aes(x=OnlineSecurity)) + ggtitle("Online Security") + xlab("Online Security") +
  geom_bar(aes(y = 100*(..count..)/sum(..count..)), width = 0.5) + ylab("Percentual") + coord_flip() + theme_minimal()
grid.arrange(p5, p6, p7, p8, ncol=2)


plot09 <- ggplot(churn, aes(x=OnlineBackup)) + ggtitle("Online Backup") + xlab("Online Backup") +
  geom_bar(aes(y = 100*(..count..)/sum(..count..)), width = 0.5) + ylab("Percentual") + coord_flip() + theme_minimal()
plot10 <- ggplot(churn, aes(x=DeviceProtection)) + ggtitle("Device Protection") + xlab("Device Protection") + 
  geom_bar(aes(y = 100*(..count..)/sum(..count..)), width = 0.5) + ylab("Percentual") + coord_flip() + theme_minimal()
plot11 <- ggplot(churn, aes(x=TechSupport)) + ggtitle("Tech Support") + xlab("Tech Support") + 
  geom_bar(aes(y = 100*(..count..)/sum(..count..)), width = 0.5) + ylab("Percentual") + coord_flip() + theme_minimal()
plot12 <- ggplot(churn, aes(x=StreamingTV)) + ggtitle("Streaming TV") + xlab("Streaming TV") +
  geom_bar(aes(y = 100*(..count..)/sum(..count..)), width = 0.5) + ylab("Percentual") + coord_flip() + theme_minimal()
grid.arrange(p9, p10, p11, p12, ncol=2)


plot13 <- ggplot(churn, aes(x=StreamingMovies)) + ggtitle("Streaming Movies") + xlab("Streaming Movies") +
  geom_bar(aes(y = 100*(..count..)/sum(..count..)), width = 0.5) + ylab("Percentual") + coord_flip() + theme_minimal()
plot14 <- ggplot(churn, aes(x=Contract)) + ggtitle("Contract") + xlab("Contract") + 
  geom_bar(aes(y = 100*(..count..)/sum(..count..)), width = 0.5) + ylab("Percentual") + coord_flip() + theme_minimal()
plot15 <- ggplot(churn, aes(x=PaperlessBilling)) + ggtitle("Paperless Billing") + xlab("Paperless Billing") + 
  geom_bar(aes(y = 100*(..count..)/sum(..count..)), width = 0.5) + ylab("Percentual") + coord_flip() + theme_minimal()
plot16 <- ggplot(churn, aes(x=PaymentMethod)) + ggtitle("Payment Method") + xlab("Payment Method") +
  geom_bar(aes(y = 100*(..count..)/sum(..count..)), width = 0.5) + ylab("Percentual") + coord_flip() + theme_minimal()
plot17 <- ggplot(churn, aes(x=tenure_group)) + ggtitle("Tenure Group") + xlab("Tenure Group") +
  geom_bar(aes(y = 100*(..count..)/sum(..count..)), width = 0.5) + ylab("Percentual") + coord_flip() + theme_minimal()
grid.arrange(p13, p14, p15, p16, p17, ncol=2)


# Todas as vari�veis categ�ricas parecem ter uma distribui��o razoavelmente ampla, 
# portanto, todas elas ser�o mantidas para an�lise posterior.


##### Modelagem Preditiva ##### 

## Regress�o Log�stica

# Primeiro, dividimos os dados em conjuntos de treinamento e testes

intrain <- createDataPartition(churn$Churn,p=0.7,list=FALSE)

training <- churn[intrain,]
testing <- churn[-intrain,]


# Confirma se a divis�o est� correta

dim(training); dim(testing)


# Treina o modelo de Regress�o Log�stica
# Fitting do Modelo

?glm

LogModel <- glm(Churn ~ ., family=binomial(link="logit"), data=training)
print(summary(LogModel))


# An�lise de Vari�ncia - ANOVA

# Os tr�s principais recursos mais relevantes incluem 
# Contract, tenure_group e PaperlessBilling.

?anova
anova(LogModel, test="Chisq")


# Analisando a tabela de vari�ncia, podemos ver a queda no desvio ao adicionar cada vari�vel 
# uma de cada vez. Adicionar InternetService, Contract e tenure_group reduz 
# significativamente o desvio residual. 
# As outras vari�veis, como PaymentMethod e Dependents, parecem melhorar menos o modelo, 
# embora todos tenham valores "p" baixos.

testing$Churn <- as.character(testing$Churn)
testing$Churn[testing$Churn=="No"] <- "0"
testing$Churn[testing$Churn=="Yes"] <- "1"
fitted.results <- predict(LogModel,newdata=testing,type='response')
fitted.results <- ifelse(fitted.results > 0.5,1,0)
misClasificError <- mean(fitted.results != testing$Churn)
print(paste('Logistic Regression Accuracy',1-misClasificError))


# Matriz de Confus�o de Regress�o Log�stica

print("Confusion Matrix Para Logistic Regression"); table(testing$Churn, fitted.results > 0.5)


# Odds Ratio

# Uma das medidas de desempenho interessantes na Regress�o Log�stica � Odds Ratio. 
# Basicamente, odds ratio � a chance de um evento acontecer.

exp(cbind(OR=coef(LogModel), confint(LogModel)))

# Para cada aumento de unidade no encargo mensal (Monthly Charge), 
# h� uma redu��o de 2,5% na probabilidade do cliente cancelar a assinatura.


## �rvore de Decis�o

# Visualiza��o da �rvore de Decis�o

# Para fins de ilustra��o, vamos usar apenas tr�s vari�veis para plotar 
# �rvores de Decis�o, elas s�o Contract, tenure_group e PaperlessBilling.

?ctree

tree <- ctree(Churn ~ Contract+tenure_group+PaperlessBilling, training)
plot(tree, type='simple')

# 1. Das tr�s vari�veis que usamos, o Contrato � a vari�vel mais importante 
# para prever a rotatividade de clientes ou n�o.
# 2. Se um cliente em um contrato de um ano ou de dois anos, 
# n�o importa se ele (ela) tem ou n�o a PapelessBilling, ele (ela) � menos propenso 
# a se cancelar a assinatura.
# 3. Por outro lado, se um cliente estiver em um contrato mensal, 
# e no grupo de posse de 0 a 12 meses, e usando o PaperlessBilling, 
# esse cliente ter� mais chances de cancelar a assinatura.


## Matriz de Confus�o de �rvore de Decis�o
# Estamos usando todas as vari�veis para tabela de matriz de confus�o de produto e fazer previs�es.

pred_tree <- predict(tree, testing)
print("Confusion Matrix Para Decision Tree"); table(Predicted = pred_tree, Actual = testing$Churn)


# Precis�o da �rvore de Decis�o

p1 <- predict(tree, training)
tab1 <- table(Predicted = p1, Actual = training$Churn)
tab2 <- table(Predicted = pred_tree, Actual = testing$Churn)
print(paste('Decision Tree Accuracy',sum(diag(tab2))/sum(tab2)))


##### Random Forest #####

?randomForest

rfModel <- randomForest(Churn ~ ., data = training)
print(rfModel)
plot(rfModel)

# A previs�o � muito boa ao prever "N�O". 
# A taxa de erros � muito maior quando se prev� "SIM".

# Preve valores com dados de teste

pred_rf <- predict(rfModel, testing)

# Confusion Matrix
print("Confusion Matrix Para Random Forest"); table(testing$Churn, pred_rf)

# Recursos mais importantes

?varImpPlot
varImpPlot(rfModel, sort=T, n.var = 10, main = 'Top 10 Feature Importance')
