
# Big Data na pr�tica 02 - Visualiza��es Interativas

# Obs: Caso tenha problemas com a acentua��o, consulte este link:
# https://support.rstudio.com/hc/en-us/articles/200532197-Character-Encoding

# Configurando o diret�rio de trabalho
# Coloque entre aspas o diret�rio de trabalho que voc� est� usando no seu computador
# N�o use diret�rios com espa�o no nome

setwd("D:/BigDataAnalytics/Capitulo04")
getwd()

# Baseado no Google Chart (visualiza��o de dados na web)
# googlevis � um pacote que fornece interface entre R e o Google Charts
# Utiliza JavaScript e arquivos JSON. Os dados s�o transformados em formato JSON
# O resultado � gerado em HTML5 ou Flash
# Pode-se criar os mais variados tipos de gr�ficos e mapas. Inclusive Google Maps
# Pode-se incorporar os gr�ficos criados em p�ginas HTML ou apps
# Verifique os termos de uso, antes de utilizar

install.packages("googleVis")
library(googleVis)
?googleVis


# Cria um Datafrane

dataframe01 = data.frame(Pa�s = c("BR", "CH", "AR"), 
                EXportacao = c(10,13,14), 
                Importacao = c(23,12,32))


# Gr�fico de Linha

Line <- gvisLineChart(df)
plot(Line)


# Gr�fico de Barras

Column <- gvisColumnChart(df)
plot(Column)


# Gr�fico de Barras Horizontais

Bar <- gvisBarChart(df)
plot(Bar)


# Gr�fico de Pizza

Pie <- gvisPieChart(CityPopularity)
plot(Pie)


# Gr�ficos Combinados

Combo <- gvisComboChart(df, xvar = "Pa�s",
                        yvar = c("Exportacao", "Importacao"),
                        options = list(seriesType = "bars",
                                       series='{1: {type:"line"}}'))
plot(Combo)


# Scatter Chart

Scatter <- gvisScatterChart(women, 
                            options=list(
                              legend="none",
                              lineWidth=2, pointSize=0,
                              title="Women", vAxis="{title:'weight (lbs)'}",
                              hAxis="{title:'height (in)'}", 
                              width=300, height=300))
plot(Scatter)


# Bubble

Bubble <- gvisBubbleChart(Fruits, idvar="Fruit", 
                          xvar="Sales", yvar="Expenses",
                          colorvar="Year", sizevar="Profit",
                          options=list(
                            hAxis='{minValue:75, maxValue:125}'))
plot(Bubble)


# Customizando

M <- matrix(nrow=6,ncol=6)
M[col(M)==row(M)] <- 1:6
dat <- data.frame(X=1:6, M)
SC <- gvisScatterChart(dat, 
                       options=list(
                         title="Customizing points",
                         legend="right",
                         pointSize=30,
                         series="{
                         0: { pointShape: 'circle' },
                         1: { pointShape: 'triangle' },
                         2: { pointShape: 'square' },
                         3: { pointShape: 'diamond' },
                         4: { pointShape: 'star' },
                         5: { pointShape: 'polygon' }
                         }"))
plot(SC)


# Gauge

Gauge <- gvisGauge(CityPopularity, 
                   options=list(min=0, max=800, greenFrom=500,
                                greenTo=800, yellowFrom=300, yellowTo=500,
                                redFrom=0, redTo=300, width=400, height=300))
plot(Gauge)


# Mapas

Intensity <- gvisIntensityMap(df)
plot(Intensity)


# Geo Chart

Geo=gvisGeoChart(Exports, locationvar="Country", 
                 colorvar="Profit",
                 options=list(projection="kavrayskiy-vii"))
plot(Geo)


# Google Maps

AndrewMap <- gvisMap(Andrew, "LatLong" , "Tip", 
                     options=list(showTip=TRUE, 
                                  showLine=TRUE, 
                                  enableScrollWheel=TRUE,
                                  mapType='terrain', 
                                  useMapTypeControl=TRUE))
plot(AndrewMap)


# Dados em gr�fico. N�vel de analfabetismo nos EUA

require(datasets)

states <- data.frame(state.name, state.x77)
GeoStates <- gvisGeoChart(states, "state.name", "Illiteracy",
                          options=list(region="US", 
                                       displayMode="regions", 
                                       resolution="provinces",
                                       width=600, height=400))
plot(GeoStates)
