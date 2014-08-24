getting_data
============

Repository for the project for the Coursera Getting and Cleaning Data course


Codebook
--------
The codebook for this project contains detailed steps and data samples which can be helpful 
in understanding the processing which occurred as part of the project.  Each processing step is contained 
in the codebook, and steps which involved R code should coincide with the code (see below).

The codebook is in Adobe Acrobat format in the file "Project_Codebook.pdf".


The Data
--------
The data was provided through the Coursera course as a single zipped file "UCI HAR Dataset".

When unzipped, the directory structure is like:
test\
train\
activity_labels.text
features.txt
features_info.txt
README.txt

The test\ and train\ are similarly-structured subdirectories which contain
test- and training-data, respectively.  Each of these directories is structured like:

test\train\subject_test.txt
test\train\X_test.txt
test\train\y_test.txt

The code book discusses each of these files in detail, with examples.


Using the code
--------------
Per instructions, the application is contained in a file "run_analysis.r".
The "run_analysis.r" file must be put in the working directory so that the
directory structure looks like:

test\
train\
activity_labels.text
features.txt
features_info.txt
run_analysis.r

run_analysis.r will use the data files in this directory, including the test\ and train\ directories.
It will also create a "merged" directory, containing the merged data files.


Application output data
-----------------------
The application output is contained in the file "avg_by_subject_activity.txt",
and is created in the r working directory.  It contains a matrix identifying
the subject_id and activity_id for the average of all the input data variables.
