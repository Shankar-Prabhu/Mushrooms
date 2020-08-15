library(data.table)

data = read.csv("C:/Users/shank/Documents/Data_Science_Projects/mushrooms/mushrooms.csv", header = TRUE, sep = ",")
train_set = read.csv("C:/Users/shank/Documents/Data_Science_Projects/mushrooms/train.csv", header = TRUE, sep = ",")
test_set = read.csv("C:/Users/shank/Documents/Data_Science_Projects/mushrooms/test.csv", header = TRUE, sep = ",")


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

full_mod = glm(class_p ~., data = train_pca_final, family = "binomial")

summary(full_mod)

train_pred = predict(full_mod, train_pca_final, type = "response")
test_pred = predict(full_mod, test_pca_final, type = "response")

train_pred = ifelse(train_pred > 0.5, 1, 0)
test_pred = ifelse(test_pred > 0.5, 1, 0)

train_confusion_mat = table(train_pred, train_pca_final$class_p)
test_confusion_mat = table(test_pred, test_pca_final$class_p)


(test_confusion_mat[1, 1] + test_confusion_mat[2, 2])/(sum(test_confusion_mat))
(train_confusion_mat[1, 1] + train_confusion_mat[2, 2])/(sum(train_confusion_mat))

train_confusion_mat
test_confusion_mat
