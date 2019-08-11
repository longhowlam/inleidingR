library(parsnip)
library(dplyr)

### decsion tree
dt = decision_tree(mode = "classification", tree_depth = 5) %>% 
  set_engine("rpart") %>% 
  fit(Survived ~ Sex + Age + Pclass,  data = TTrain)
dt


dt$fit
plot(dt$fit)
text(dt$fit)
fancyRpartPlot(dt$fit)


observed_predicted = bind_cols(
  TTest,
  predict(dt, TTest, type = "prob")
)


autoplot(gain_curve(observed_predicted, Survived, .pred_N))
autoplot(roc_curve(observed_predicted, Survived, .pred_N))
roc_auc(observed_predicted, Survived, .pred_N)


### randomforest
rf = rand_forest(mode = "classification", trees = 250) %>% 
  set_engine("ranger",  importance = 'impurity') %>% 
  fit(Survived ~ Sex + Age + Pclass,  data = TTrain)
rf

observed_predicted = bind_cols(
  TTest,
  predict(rf, TTest, type = "prob")
)


autoplot(gain_curve(observed_predicted, Survived, .pred_N))
autoplot(roc_curve(observed_predicted, Survived, .pred_N))

roc_auc(observed_predicted, Survived, .pred_N)

rf$fit$variable.importance


### xgboost

bt = boost_tree(mode = "classification", trees = 250) %>% 
  set_engine("xgboost") %>% 
  fit(Survived ~ Sex + Age + Pclass,  data = TTrain)
bt

observed_predicted = bind_cols(
  TTest,
  predict(rf, TTest, type = "prob")
)


autoplot(gain_curve(observed_predicted, Survived, .pred_N))
autoplot(roc_curve(observed_predicted, Survived, .pred_N))

roc_auc(observed_predicted, Survived, .pred_N)

xgb.importance( model = bt$fit)



