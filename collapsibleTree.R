library(collapsibleTree) 

# input data must be a nested data frame:
head(warpbreaks)

# Represent this tree:
collapsibleTree( warpbreaks, c("wool", "tension", "breaks"))
