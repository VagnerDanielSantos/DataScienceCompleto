
# Big Data na pr�tica 03 - Minera��o de Regra de associa��o 

# Esse � um material de b�nus. 
# Conte�do sobre este tema pode ser encontrado nos cursos: 

# Business Analytics 
# An�lise em Grafos Para Big Data
# Data Mining e Modelagem Preditiva

# Embora tenha mais de 20 anos, o Market Basket Analysis (MBA) (ou Minera��o de Regras de Associa��o) 
# ainda pode ser uma t�cnica muito �til para obter insights em grandes conjuntos de dados transacionais. 

# O exemplo cl�ssico s�o dados transacionais em um supermercado. Para cada cliente, sabemos quais s�o os produtos 
# individuais (itens) que ele colocou na cesta e comprou. Outros casos de uso para o MBA podem ser dados de clique da web, 
# arquivos de log e at� question�rios.

# Com a an�lise de cesta de compras, podemos identificar itens que s�o frequentemente comprados juntos. 
# Normalmente, os resultados de um MBA s�o apresentados sob a forma de regras. 
# As regras podem ser t�o simples quanto {A ==> B}, quando um cliente compra o item A ent�o � (muito) prov�vel 
# que o cliente compre o item B. Regras mais complexas tamb�m s�o poss�veis {A, B ==> D, F}, quando um cliente 
# compra os itens A e B, � prov�vel que ele compre os itens D e F.

# Neste Big Data na Pr�tica, vamos buscar a associa��o entre os clubes de futebol da Europa e responder a pergunta:

# Quais clubes mais realizam transa��es de compra e venda de jogadores, entre si?

# Usaremos um Dataset oferecido pelo Kaggle: https://www.kaggle.com/hugomathien/soccer

# O dataset cont�m cerca de 25.000 partidas de onze ligas de futebol europeias a partir da temporada 2008/2009 
# at� a temporada 2015/2016. 

# Depois de realizar o trabalho de Data Wrangling, vamos gerar um conjunto de dados transacionais adequado para an�lise 
# de cesta de compras.

# Portanto, n�o temos clientes, mas jogadores de futebol, e n�o temos produtos, mas clubes de futebol. 

# No total, o conjunto de dados transacionais de futebol cont�m cerca de 18.000 registros. 
# Obviamente, esses registros n�o incluem apenas as transfer�ncias multimilion�rias cobertas pela m�dia, 
# mas tamb�m todas as transfer�ncias de jogadores que ningu�m nunca ouviu falar.

# Como vamos aplicar o MBA?

# Em R pode-se usar o pacote arules para minera��o de regras de associa��o / MBA. 
# Alternativamente, quando a ordem das transa��es � importante, voc� deve usar o pacote arulesSequences. 
# Depois de executar o algoritmo, obteremos alguns resultados interessantes. 
  
# Por exemplo: neste conjunto de dados, a transfer�ncia mais frequente � da Fiorentina para o G�nova 
# (12 transfer�ncias no total). Vamos imprimir a tabela com todos os resultados ao final do processo.

# Visualiza��o de gr�fico de rede
# Todas as regras que obtemos da minera��o de regras de associa��o formam um gr�fico de rede. 
# Os clubes de futebol individuais s�o os n�s do gr�fico e cada regra "de ==> para" � uma aresta (edge) do gr�fico de rede.

# Em R, os gr�ficos de rede podem ser visualizados bem por meio do pacote visNetwork. 

# Vamos come�ar !

# Obs: Caso tenha problemas com a acentua��o, consulte este link:
# https://support.rstudio.com/hc/en-us/articles/200532197-Character-Encoding

# Configurando o diret�rio de trabalho
# Coloque entre aspas o diret�rio de trabalho que voc� est� usando no seu computador
# N�o use diret�rios com espa�o no nome

setwd("D:/BigDataAnalytics/Capitulo05")
getwd()

# Pacotes

install.packages("RSQLite")
install.packages("dplyr")
install.packages("tidyr")
install.packages("arules")
install.packages("arulesSequences")
install.packages("readr")
install.packages("visNetwork")
install.packages("igraph")
install.packages("lubridate")
install.packages("DT")

library(RSQLite)
library(dplyr)
library(tidyr)
library(arules)
library(arulesSequences)
library(readr)
library(stringr)
library(visNetwork)
library(igraph)
library(lubridate)
library(DT)


# Os dados est�o disponibilizados em um banco de dados SQLITE 
# que pode ser baixado do kaggle, mas est� anexo a este script.

# Conectando no banco de dados

conexao = dbConnect(RSQLite::SQLite(), 
                    dbname="D:\BigDataAnalytics\Capitulo05/Arquivos/database.sqlite")


# Obtendo a lista de tabelas

alltables = dbListTables(con)
alltables

# Extrai as tabelas

players       = dbReadTable(con, "Player")
players_stats = dbReadTable(con, "Player_Attributes")
teams         = dbReadTable(con, "Team")
league        = dbReadTable(con, "League")
Matches       = dbReadTable(con, "Match")

View(players)
View(players_stats)
View(teams)
View(league)
View(Matches)


# Substitui os espa�os por underline nos nomes muitos longos

teams$team_long_name = str_replace_all(teams$team_long_name, "\\s", "_")
teams$team_long_name = str_replace_all(teams$team_long_name, "\\.", "_")
teams$team_long_name = str_replace_all(teams$team_long_name, "-", "_")
View(teams)

# Agrupa as equipes por pa�s

CountryClub = Matches %>% 
  group_by(home_team_api_id,country_id) %>% 
  summarise(n=n()) %>% 
  left_join(league) %>%
  left_join(teams, by=c("home_team_api_id" = "team_api_id"))


# Prepara os dados para minera��o das regras de associa��o

# Os jogadores est�o em colunas separadas, mas precisamos deles empilhados em uma coluna

tmp = Matches %>% 
  select(
    season, 
    home_team_api_id, 
    home_player_1:home_player_11
  )%>%
  gather(
    player, 
    player_api_id, 
    -c(season, home_team_api_id)
  ) %>%
  group_by(player_api_id, home_team_api_id ) %>% 
  summarise(season = min(season))


# Une os dados de jogador e clube

playerClubSequence = left_join(
  tmp,
  players
  ) %>% 
  left_join(
    teams, 
    by=c("home_team_api_id"="team_api_id")
  )

playerClubSequence = playerClubSequence %>% 
  filter(
    !is.na(player_name), !is.na(team_short_name)
  )  %>%
  arrange(
    player_api_id, 
    season
  )


# Adiciona um n�mero sequencial por jogador

playerClubSequence$seqnr = ave( playerClubSequence$player_api_id, playerClubSequence$player_api_id, FUN = seq_along)
playerClubSequence$size = 1


# Minera��o de sequ�ncias com algoritmo cSPade do pacote arulesSequences

# Grava o conjunto de dados em um arquivo txt para facilitar a manipula��o 
# da fun��o read_basket em arulesSequence para criar um objeto de transa��o

write_delim( 
  playerClubSequence %>% select( c(player_api_id, seqnr, size, team_long_name)) ,
  delim ="\t", path = "player_transactions.txt", col_names = FALSE
  )


# Agora importamos as transa��es registradas no item anterior

playerstrxs <- read_baskets("player_transactions.txt", sep = "[ \t]+",info =  c("sequenceID","eventID","size"))
summary(playerstrxs)


# Executar minera��o de sequ�ncia, por enquanto apenas com comprimento de duas sequ�ncias

?cspade

playersClubSeq <- cspade(
  playerstrxs, 
  parameter = list(support = 0.00010, maxlen=2), 
  control   = list(verbose = TRUE)
)

summary(playersClubSeq)

# Fazendo Data Wrangling para colocar os resultados do cspade em um organizado conjunto de dados 
# que � adequado para a visNetwork. A visNetwork precisa de dois conjuntos de dados:
# um conjunto de dados com as arestas "de --> para" e um conjunto de dados com os n�s exclusivos

seqResult = as(playersClubSeq, "data.frame")
seqResult = seqResult %>% 
  mutate(
    sequence = as.character(sequence)
  )

seqResult = bind_cols(
  seqResult,
  as.data.frame(
    str_split_fixed(seqResult$sequence, pattern =",", 2), 
    stringsAsFactors = FALSE)
  )

seqResult$from = str_extract_all(seqResult$V1,"\\w+", simplify = TRUE)[,1] 
seqResult$to   = str_extract_all(seqResult$V2,"\\w+",simplify = TRUE)[,1]


seqResult$width = exp(3000*seqResult$support)
seqResult = seqResult %>% filter(V2 !="")
seqResult$title = paste(seqResult$sequence, "<br>", round(100*seqResult$support,2), "%")

seqResult$support_perc = paste(sprintf("%.4f", 100*seqResult$support), "%")


# Criando o dataframe com os nodes
nodes = unique(c(seqResult$from, seqResult$to))
nodesData = data.frame(id = unique(nodes), title = unique(nodes), label = unique(nodes), stringsAsFactors = FALSE) %>%
  left_join(CountryClub, by = c("id"="team_long_name")) %>% 
  rename(group = name)

View(nodes)

# Calcula as medidas de centralidade de betweeness
# usando o igraph, para que possamos ter tamanhos diferentes de
# n�s no gr�fico de rede

transferGraph = graph_from_data_frame(seqResult[,c(5,6)], directed = TRUE)

tmp = betweenness(transferGraph)
Clubs_betweenness = data.frame(id = names(tmp), value = tmp, stringsAsFactors = FALSE)
nodesData = nodesData %>% 
  left_join(Clubs_betweenness) %>%
  mutate(title = paste(id, "betweeness ", round(value))) %>%
  arrange(id)


##### Criando a rede interativa

# Prepara o dataframe final e remove duplicidades

nodes = nodesData
nodes = nodes[!duplicated(nodes$id),]


# Cria a rede

?visNetwork

visNetwork(nodes, edges = seqResult, width = 900, height = 700) %>%
  visNodes(size = 10) %>%
  visLegend() %>%
  visEdges(smooth = FALSE) %>%
  visOptions(highlightNearest = TRUE, nodesIdSelection = TRUE) %>%
  visInteraction(navigationButtons = TRUE) %>%
  visEdges(arrows = 'from') %>%
  visPhysics(
    solver = "barnesHut",
    maxVelocity = 35,
    forceAtlas2Based = list(gravitationalConstant = -6000)
  )
  

# Cria a tabela final para suportar a an�lise

seqResult$Ntransctions = seqResult$support*10542
DT::datatable(
  seqResult[,c(5,6,9,10)], 
  rownames = FALSE,
  options = list(
    pageLength=25)
  )
