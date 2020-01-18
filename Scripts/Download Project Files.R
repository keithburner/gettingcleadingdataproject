
# Download the data
#
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileURL, "./Data/projectfiles.zip", method = "curl")

# Read in the data
#
unzip("./data/projectfiles.zip", exdir = "./Data")

