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


The function `get_tid` gets teacher IDs and general information by name, department and university,
it is case insensitive and support partial input.
```r
name <- "Brakor"
department <- "Biology"
university <- "California Berkeley"
get_tid(name = name)
get_tid(name = name, department = department)
get_tid(name = name, university = university)
get_tid(name = name, department = department, university = university)
```

The function `get_url` gets url by name, department and university,
it is case insensitive and support partial input.
```r
get_url(name = name)
get_url(name = name, department = department)
get_url(name = name, university = university)
get_url(name = name, department = department, university = university)
```

The function `general_info` extracts general information for an instructor.
```r
url <- "https://www.ratemyprofessors.com/ShowRatings.jsp?tid=2036448"
general_info(url)
```

The function `get_all_schools` finds the university url using its name.
```r
get_all_schools("Iowa State University")
```

The function `ratings_info` shows and summarizes all rating information for an instructor
```r
ratings_info(url = url, y = 2018)
```

The function `ratings_plot` creates a box plot of all ratings and 3 bar plots of average ratings by course, grade, and year for an instructor.
```r
ratings_plot(url = url, y = 2018)
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


