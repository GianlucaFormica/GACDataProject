For information on the orignial dataset used for this analysis, please see 'OriginalDataREADME.md' in the same repo that holds 
this file.

###Here is what the run_analysis.r file does: 
######Assumptions: 
* All needed data files are in the working directory
* sqldf is installed
* dplyr is installed

1. The original datasets are loaded into R:
  * subject_test
  * subject_train
  * X_test
  * X_train
  * Y_test
  * Y_train
  * activity_labels
  * features

2. The corresponding test and training datasets are combined into 1 for each (X, Y, and subject).

3. Columns are chosen in the "X" data that include "mean" or "std" in their title (this method was chosen as the instructions were rather ambiguous--too much data is better than too little if there is a question on requirements).

4. The "Y" and "Subject" datasets are then added to the "X" using cbind. 

5. The data is then grouped by Subject and Activity since we will be analyzing the numerical portion of the data based on these two factors.

6. The data is summarized by taking the mean of each of the numerical columns (again, grouping by Activity and Subject)

7. The table is then written to the working directory with the file name: "summaryMeans.txt".

