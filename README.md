# mushrooms
 Classifying poisonous and edible mushrooms

## Data Used
This dataset is taken from [here](https://www.kaggle.com/uciml/mushroom-classification). It contains information on different variets of mushrooms and classifies whether the mushroom is poisonous or edible. Some features included in the dataset are cap shape, cap surface, cap color, and odor.

## Process
All features included in the dataset were categorical and encoded by letters; in order to make this data suitable for training, I one-hot encoded all the features.
After finishing creating a trainable data set, I implemented a logistic regression model with principal components, a single classification tree with principal components, a random forest with principal components, and an AdaBoost model.
Then, I compared the test misclassification rate of each models and the relative complexity to determine the best model out of the ones I implemented.
Overall, all models performed well, implying that this dataset does demonstrate some pretty clear rules for differentiating poisonous mushrooms from edible mushrooms. An interesting caveat to note in our classification is that we should prioritize models that fewer false positives than false negatives (positive meaning poisonous). This is because misclassifying an edible mushroom is much less harmful than a misclassifying mushroom.

## Principal Components
In order to reduce dimensionality (dimensionality is very high because all the categorical features were one-hot encoded), it is useful to use principal components in training so that model complexity is reduced. The way that principal components is important to reduce interference of test and train data. First, we separate the data into training and test sets. Next, we figure out the principal components **only** on the training set, and identify the number of principal components we want to use that explain a certain portion of variance in the training set. Then, we apply the principal component loadings that we found **only** from the training set to the test set. Lastly, we can predict our trained model on the PCA version of the test data. For the following models, 2 principal components were used in implementation (except AdaBoost).

## Model Comparison
The following tables display performance on test data

**Logistic Regression with 2 principal components**
|                     | Actual Edible | Actual Poisonous |
| ------------------- | ------------- | ---------------- |
| Predicted Edible    | 798           | 175              |
| Predicted Poisonous | 44            | 609              |

The correct classification rate on testing data is 87.6%

**Classification Tree with 2 principal components**
|                     | Actual Edible | Actual Poisonous |
| ------------------- | ------------- | ---------------- |
| Predicted Edible    | 746           | 29               |
| Predicted Poisonous | 96            | 755              |

The correct classification rate on testing data is 92.3%

**Random Forest with 2 principal components**
|                     | Actual Edible | Actual Poisonous |
| ------------------- | ------------- | ---------------- |
| Predicted Edible    | 822           | 42               |
| Predicted Poisonous | 20            | 742              |

The correct classification rate on testing data is 96.1%

**AdaBoost (number of trees of 800)**
|                     | Actual Edible | Actual Poisonous |
| ------------------- | ------------- | ---------------- |
| Predicted Edible    | 842           | 6                |
| Predicted Poisonous | 0             | 778              |

The correct classification rate on testing data is 99.6%

## Conclusions
Despite AdaBoost having the highest classification rate, it is not suitable due to high complexity and taking a long time to train and evaluate new testing data. The best model to select is the Random Forest with 2 principal components. One caveat could be that it has a higher number of false negative (predicted edible where actual is poisonous), however this could be due to random chance since a forest is an ensemble method compared to the single classification tree.
**Therefore, we would select a random forest with 2 principal components to determine whether future mushrooms are poisonous or edible.**
