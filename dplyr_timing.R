#dplyr timing

library("dplyr")
library("pipeR")
library("microbenchmark")
library("ggplot2")

timings <- microbenchmark(
  base = {
    . <- mtcars
    . <- subset(., cyl == 8)
    . <- .[, c("mpg", "cyl", "wt")]
    nrow(.)
  },
  dplyr = {
    mtcars                 %>%
      filter(cyl == 8)     %>%
      select(mpg, cyl, wt) %>%
      nrow
  },
  pipeR = {
    mtcars                 %>>%
      filter(cyl == 8)     %>>%
      select(mpg, cyl, wt) %>>%
      nrow
  })

print(timings)

## Unit: microseconds
##   expr      min       lq      mean   median       uq       max neval
##   base  122.948  136.948  167.2253  159.688  179.924   349.328   100
##  dplyr 1570.188 1654.700 2537.2912 1699.744 1785.611 50759.770   100

autoplot(timings)

