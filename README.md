
# ProfRate

<!-- badges: start -->
<!-- badges: end -->

The goal of `ProfRate` is to retrieve and visualize the data on [Rate My Professor](https://www.ratemyprofessors.com/).
For details,
please see [THE WEBSITE FOR THE PACKAGE]() for details.

## Installation

You can install the development version of `ProfRate` with:
  
  1. Install from [GitHub](https://github.com/m-fili/ProfRate):
  
  ```r
  ### install.packages("devtools")
  devtools::install_github("m-fili/ProfRate")
  ```
  
  2. Install from local:
  Download the `ProfRate` files and use
  
  ```r
  install.packages("file_path_to_target_package/ProfRate", repos=NULL, type="source")
  ```
  
  Note that `file_path_to_target_package` is the placeholder and needs to be replace by the correct relative path on your machine.

## Example

This is a basic example which shows you how to solve a common problem.

``` r
### Load library
library(ProfRate)
```

The function `general_info` extracts general information for an instructor.
```r
url <- "https://www.ratemyprofessors.com/ShowRatings.jsp?tid=2036448"
general_info(url)
```

The function `generate_url_school` finds the university url using its name.
```r
get_all_schools("Iowa State University")
```

The function `ratings_summ` summarizes all rating information for an instructor
```r
ratings_summ(url)
```

The function `plot_QualDiff` creates a bar plot for the quality and difficulty of a course for an instructor.
```r
plot_QualDiff(url)
```

The function `plot_attendance` creates a bar plot for the attendance type for an instructor.
```r
plot_attendance(url)
```

The function `comment_info` provides wordcloud plots for positive words, negative words in the comments, and tags on the website.
```r
comment_info(url = url, y = 2018, word = "Negative")
```

The function `runExample` .......................
```r
EXAMPLE FOR runExample
```

