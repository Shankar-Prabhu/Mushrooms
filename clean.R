data = read.csv("C:/Users/shank/Documents/Data_Science_Projects/mushrooms/mushrooms.csv", header = TRUE, sep = ",")
library(mltools)
library(data.table)
data = one_hot(as.data.table(data))
data = as.data.frame(data)
set.seed(1234)

data = data[,-1]

edibles = which(data$class_p == 0)
poisonous = which(data$class_p == 1)

train_rows = c(sample(edibles, size = trunc(0.80 * length(edibles))),
              sample(poisonous, size = trunc(0.80 * length(poisonous))))


train_set = data[train_rows,]
test_set = data[-train_rows,]

write.csv(train_set, "C:/Users/shank/Documents/Data_Science_Projects/mushrooms/train.csv", row.names = FALSE )
write.csv(test_set, "C:/Users/shank/Documents/Data_Science_Projects/mushrooms/test.csv", row.names = FALSE )

