library(reshape2)
dir.create(file.path("./data/UCI HAR Dataset", "/tidy"), showWarnings = FALSE)
activity.labels <- (read.csv("./data/UCI HAR Dataset/activity_labels.txt", header = F,sep = " "))$V2
features <- (read.csv("./data/UCI HAR Dataset/features.txt", header = F,sep = " "))$V2 # select only the names - not the count- columnfor column names
# remove the braces, ",", "-"
features.noBraces <- gsub("\\,|\\-", ".",gsub("\\(|\\)", "", features))

selected.columns <- 
  c(grep("[Mm][Ee][Aa][Nn]|[Ss][Tt][Dd]",features.noBraces, value = T),
    c("Activity","Subject"))


subject.train = read.table("./data/UCI HAR Dataset/train/subject_train.txt")
subject.test <- read.table("./data/UCI HAR Dataset/test/subject_test.txt")

X.train <- read.table("./data/UCI HAR Dataset/train/X_train.txt", col.names=features.noBraces)
X.test <- read.table("./data/UCI HAR Dataset/test/X_test.txt", col.names=features.noBraces)

y.train <- read.table("./data/UCI HAR Dataset/train/y_train.txt")
y.test <- read.table("./data/UCI HAR Dataset/test/y_test.txt")

# add the activity-column
X.train$Activity <- as.factor(y.train[[1]])
X.test$Activity <- as.factor(y.test[[1]])
# add the subject-column
X.train$Subject <- as.factor(subject.train[[1]])
X.test$Subject <- as.factor(subject.test[[1]])

tmp <- rbind(X.train, X.test)

# replace the factor-Levels of activity-numbers by their names
levels(tmp$Activity) <- activity.labels

# Extracts only the measurements on the mean and standard deviation for each measurement. 
tidy.1 <- tmp[selected.columns]
write.csv(tidy.1,"./data/UCI HAR Dataset/tidy/tidy1.csv")

# Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
# "start with tmp"
# grep("[Mm][Ee][Aa][Nn]|[Ss][Tt][Dd]",features.noBraces, value = T)

# carMelt <- melt(mtcars,id=c("carname","gear","cyl"),measure.vars=c("mpg","hp"))
# cylData <- dcast(carMelt, cyl ~ variable,mean)
#  or
# ddply(tidy.1,.(spray),summarize,sum=sum(count))

tidyMelt <- melt(tidy.1,id.vars=c("Activity","Subject"))
tidyCast <- dcast(tidyMelt, Activity + Subject ~ variable, mean)
write.csv(tidyCast,"./data/UCI HAR Dataset/tidy/tidyMean.csv")



