## installatie van packages die nodig zijn voor inleiding R

# Sessie 01
install.packages(
  c("readr", "readxl", "pryr", "RODBC", "skimr")
)

# sessie 02
install.packages(
  c("tidyverse", "lubridate", "anytime","tidyr", "stringr", "forcats")
)

# sessie 03
install.packages(
  c("ggplot2" , "plotly", "grid", "ggvis", "leaflet", "visNetwork", "sunburstR", "devtools", "rgeos", "raster", "sp", "colorRamps", "RColorBrewer")
)

devtools::install_github("jeromefroe/circlepackeR")
devtools::install_github("mattflor/chorddiag")

# sessie 04
install.packages(
  c("rpart", "glmnet", "h2o", "ranger", "xgboost", "ROCR", "pROC", "titanic", "rattle", "mlr", "arules")  
)