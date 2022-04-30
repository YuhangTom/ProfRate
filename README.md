# ProfRate <img src="man/figures/logo.png" align="right" />


<!-- badges: start -->
[![R-CMD-check](https://github.com/m-fili/ProfRate/workflows/R-CMD-check/badge.svg)](https://github.com/m-fili/ProfRate/actions)
[![Codecov test coverage](https://codecov.io/gh/m-fili/ProfRate/branch/main/graph/badge.svg)](https://app.codecov.io/gh/m-fili/ProfRate?branch=main)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
<!-- badges: end -->

The goal of `ProfRate` is to retrieve and visualize the data on [Rate My Professor](https://www.ratemyprofessors.com/).
For details,
please see [the website for ProfRate](https://m-fili.github.io/ProfRate/).

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


The function `get_tid` gets teacher IDs and general information by name.
```r
name <- "Brakor"
get_tid(name = name)
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

The function `comment_info` extracts information on comments including course, year, comments, number of thumbsups and number of thumbsdowns.
```r
comment_info(url = url, y = 2018)
```

The function `sentiment_info` provides positive words and negative words extracted from comments, and tags from the website.
```r
sentiment_info(url = url, y = 2018, word = "Negative")
```


The function `runExample` runs shiny app.
```r
runExample()
```


