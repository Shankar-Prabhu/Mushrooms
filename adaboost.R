library(gbm)

data = read.csv("C:/Users/shank/Documents/Data_Science_Projects/mushrooms/mushrooms.csv", header = TRUE, sep = ",")
train_set = read.csv("C:/Users/shank/Documents/Data_Science_Projects/mushrooms/train.csv", header = TRUE, sep = ",")
test_set = read.csv("C:/Users/shank/Documents/Data_Science_Projects/mushrooms/test.csv", header = TRUE, sep = ",")

M_vals = c(1, 10, 20, 50, 100, 150, 175, 200, 225, 250, 300, 350, 400, 500, 600, 700, 800, 900, 1000)

train_err = c()
test_err = c()

for(i in 1:length(M_vals)) {
  num_trees = M_vals[i]
  adaboost_mod = gbm(class_p ~. -cap.surface_g -veil.type_p, data = train_set,
                       distribution = "adaboost", n.trees = num_trees)
  
  train_pred = predict(adaboost_mod, train_set,
                       n.trees = num_trees, type = "response")
  train_confusion = table(ifelse(train_pred > 0.5, 1, 0), train_set$class_p)
  train_err[i] = (train_confusion[1, 2] + train_confusion[2, 1])/(nrow(train_set))
  
  test_pred = predict(adaboost_mod, newdata = test_set,
                      n.trees = num_trees, type = "response")
  test_confusion = table(ifelse(test_pred > 0.5, 1, 0), test_set$class_p)
  test_err[i] = (test_confusion[1, 2] + test_confusion[2, 1])/(nrow(test_set))
}


best_M = M_vals[which.min(test_err)]
best_M

train_err_best_M = train_err[17]
test_err_best_M = test_err[17]

train_err_best_M
test_err_best_M



