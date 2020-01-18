
# Load the raw data
#
data.x.test <- read.table("./Data/UCI HAR Dataset/test/X_test.txt", sep = "")
data.y.test <- read.table("./Data/UCI HAR Dataset/test/y_test.txt", stringsAsFactors = FALSE)
data.subject.test <- read.table("./Data/UCI HAR Dataset/test/subject_test.txt")

data.x.train <- read.table("./Data/UCI HAR Dataset/train/X_train.txt", sep = "")
data.y.train <- read.table("./Data/UCI HAR Dataset/train/y_train.txt", stringsAsFactors = FALSE)
data.subject.train <- read.table("./Data/UCI HAR Dataset/train/subject_train.txt")

# Combine the datasets
data.x <- rbind(data.x.train, data.x.test)
data.y <- rbind(data.y.train, data.y.test); names(data.y) <- "activities"
data.subject <- rbind(data.subject.train, data.subject.test); names(data.subject) <- "subject"

# Load the features
features <- read.table("./Data/UCI HAR Dataset/features.txt", sep = "")
# assign the features to the names of the x data frame
names(data.x) <- t(features[,2])

# Load the activities descriptions
activities <- read.table("./Data/UCI HAR Dataset/activity_labels.txt", sep = "")

# Add the activities description to the dataset as factors
data.y2 <- as.numeric(data.y[,1])
data.y2 <- factor(data.y2, levels = activities[,1], labels = activities[,2])
data.y <- as.data.frame(data.y2); names(data.y) <- "activities"

# Combine all the data into 1 data frame
data.all <- cbind(data.subject, data.y, data.x)

# Subset the features for only Mean and Standard Deviation
features.subset <- grep("mean\\(|std\\(", names(data.all))
data.reduced <- data.all[,c(1, 2, features.subset)]

# Perform Summary
data.tidy.summary <- aggregate( . ~ subject + activities, data=data.reduced, FUN=mean)

# Output Tidy Summary to file
write.table(data.tidy.summary, "./Output/SubjectActivities.txt", row.name = FALSE)

