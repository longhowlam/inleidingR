library(arules)
library(dplyr)
library(visNetwork)
library(igraph)

IensReviewers = readRDS("data/IensReviewers.RDs") 

ienstrx = as(
  split(
    IensReviewers$keuken,
    IensReviewers$reviewer
  ),
  "transactions"
)

## generate market basket rules
rules <- apriori(
  ienstrx,
  parameter = list(
    supp = 0.00020,
    conf = 0.18,
    maxlen = 2
  )
)

## eerste tien regels op basis van lft
inspect( sort(rules, by = "lift")[1:10])

rulesDF = sort(rules, by = "lift")  %>% 
  DATAFRAME() %>%
  mutate(
    from = as.character(LHS),
    to = as.character(RHS),
    value = lift
  )

nodes = data.frame(
  id = base::unique(c(rulesDF$from, rulesDF$to)),
  stringsAsFactors = FALSE
) %>% mutate(
  title = id,
  label = id
) %>%  arrange(id)

visNetwork(nodes, rulesDF) %>%
  visOptions(highlightNearest = TRUE,  nodesIdSelection = TRUE) %>%
  visIgraphLayout(layout = "layout_in_circle" ) %>%
  visEdges(smooth = FALSE) 



