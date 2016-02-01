# Introduction

The script `run_analysis.R` performs the 5 steps that are described in the course project's definition.

* First, all the similar data is merged using the `rbind()` function. By similar, we address those files having the same number of columns and referring to the same items.
* Then, only those columns with the mean and standard deviation measures are taken from the entire dataset. After extracting these columns, they are given the correct names, taken from the information within `features.txt`.
* As activity data is addressed with values 1:6, we take the activity names and IDs from `activity_labels.txt` and they are substituted in the dataset.
* On the entire dataset, those columns with vague column names are corrected.
* Finally, we generate a new dataset with all the average measures for each subject and activity type (30 subjects * 6 activities = 180 rows). The output file is called `tidy_data_set.txt`, and uploaded to this repository.

# Variables

* `xTrain`, `yTrain`, `xTest`, `yTest`, `subjectTrain` and `subjectTest` contain the data from the downloaded files.
* `xData`, `yData` and `subjectData` merge the previous datasets for further analysis.
* `features` contains the correct names for the `xData` dataset, which are applied to the column names stored in `meanAndStdFeatures`, a numeric vector used to extract the desired data.
* A similar approach is taken with activity names through the `activities` variable.
* `allData` merges `xData`, `yData` and `subjectData` in a one large dataset.
* Finally, `averagesData` contains the averages which will be later stored in a text file. `ddply()` from the plyr package is used to apply `colMeans()` and make for a cleaner code structure.