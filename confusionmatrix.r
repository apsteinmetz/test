pred <- c(TRUE, TRUE, FALSE, TRUE, FALSE, TRUE)
act <- c(TRUE, TRUE, TRUE, FALSE, TRUE, FALSE)
cm <- table(act, pred)
#The three performance metrics can be computed easily. It's useful to remember these definitions and know how to interpret them.

accuracy <- sum(cm[diag(cm)]) / sum(cm)
precision <- cm['TRUE','TRUE'] / sum(cm[,'TRUE'])
recall <- cm['TRUE','TRUE'] / sum(cm['TRUE',])
