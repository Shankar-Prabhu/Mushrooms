library(randomForest)

data = read.csv("C:/Users/shank/Documents/Data_Science_Projects/mushrooms/mushrooms.csv", header = TRUE, sep = ",")
train_set = read.csv("C:/Users/shank/Documents/Data_Science_Projects/mushrooms/train.csv", header = TRUE, sep = ",")
test_set = read.csv("C:/Users/shank/Documents/Data_Science_Projects/mushrooms/test.csv", header = TRUE, sep = ",")

train_set[,1] = factor(train_set[,1])
test_set[,1] = factor(test_set[,1])
rand_for = randomForest(class_p ~., data = train_set, importance = TRUE)

train_preds = predict(rand_for, train_set, type = "class")
test_preds = predict(rand_for, test_set, type = "class")

table(train_preds, train_set$class_p)
table(test_preds, test_set$class_p)






