library(caret)

cl_data  <- factor(rep(1:3, each=nsamp))
cl_train <- factor(cutree(hc, k=3))
confusionMatrix(cl_train, cl_data)

set.seed(21235)
cl_data  <- factor(rep(c(3,2,1), each=nsamp))
cl_train <- factor(kmeans(A, 3)$cluster)
confusionMatrix(cl_train, cl_data)

