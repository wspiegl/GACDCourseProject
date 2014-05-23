GACDCourseProject
=================
To generate the tidy-Datasets (tidy1.csv and tidyMean.csv) run the script "run_analysis.R". Source data is located in folder "data/UCI HAR Dataset"

### What the script does:
1. Loads the activity labels from file
2. Loads the feature labels from file
3. Cleans the feature labels (remove braces, "-", ".")
4. Defines the relevant features als column indices (only mean and std features)
5. Loads the subject labels from train and test file
6. Loads the training and test data from train and test file
7. Loads the activity indices from train and test file
8. Adds the activity and subject column to train and test data frame
9. (Row-) binds the train and test data frame to a all-in-all data frame "tmp"
10. Exchanges the level-labels of the activity-column by real description
11. Subsets the relevant features from all-in-all data frame to tidy1 data frame and saved to "./data/UCI HAR Dataset/tidy/tidy1.csv"
12. Reshapes the tidy1 and calcs the average per subject and activity and save to "./data/UCI HAR Dataset/tidy/tidyMean.csv"
