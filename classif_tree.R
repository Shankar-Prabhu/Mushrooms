library(tree)

data = read.csv("C:/Users/shank/Documents/Data_Science_Projects/mushrooms/mushrooms.csv", header = TRUE, sep = ",")
train_set = read.csv("C:/Users/shank/Documents/Data_Science_Projects/mushrooms/train.csv", header = TRUE, sep = ",")
test_set = read.csv("C:/Users/shank/Documents/Data_Science_Projects/mushrooms/test.csv", header = TRUE, sep = ",")

train_set[,1] = factor(train_set[,1])
test_set[,1] = factor(test_set[,1])

y_train = train_set["class_p"]
y_test = test_set["class_p"]

X_train = model.matrix(class_p ~., data = train_set)[,-1]
X_test = model.matrix(class_p ~., data = test_set)[,-1]

train_pca = prcomp(x = X_train, center = T, scale = F)
test_pca = predict(train_pca, newdata = X_test)

train_pca.rotated = as.data.table(train_pca$x)[,c(1:2)] 
test_pca.rotated = as.data.table(test_pca[,c(1:2)])

train_pca_final = cbind(train_pca.rotated,y_train) # PCA dataset plus outcomes for training
test_pca_final = cbind(test_pca.rotated,y_test) # PCA dataset plus outcomes for training

classif_tree = tree(class_p ~., data = train_pca_final)

train_preds = predict(classif_tree, train_pca_final, type = "class")
test_preds = predict(classif_tree, test_pca_final, type = "class")

table(train_preds, train_pca_final$class_p)
table(test_preds, test_pca_final$class_p)






