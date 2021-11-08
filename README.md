# MeasuresOfDispersion

This repository contains code to empirically test the truth of the following statement:

"Standard deviation weighs outliers more heavily than mean absolute deviation."

To test the statement above. A simple distribution is created. An "outlier" value is added to the distribution and the standard deviation and mean absolute deviation are calculated. The "outlier" value is increased by one and the process is repeated until the value reaches 100,000. The resulting measures of dispersion are then graphed relative to the outliers. The results of this analysis are shown below:

![Analysis Results](https://github.com/KitFristo/MeasuresOfDispersion/blob/main/plots/measures_of_dispersion.png)