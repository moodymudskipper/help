
<!-- README.md is generated from README.Rmd. Please edit that file -->

# help

The package *help* helps you get the content of your help files into a
list.

Install with:

``` r
remotes::install.github("moodymudskipper/help")
```

## Example

This is a basic example which shows you how to solve a common problem:

``` r
# equivalent calls :
# doc(base::mean)
# doc(mean, "base")
# doc("mean", "base")
help::doc(mean)
#> $alias
#> $alias[[1]]
#> [1] "mean"
#> 
#> $alias[[2]]
#> [1] "mean.default"
#> 
#> 
#> $arguments
#> $arguments$x
#> [1] "An `R` object. Currently there are methods for numeric/logical vectors and date, date-time and time interval objects. Complex vectors are allowed for `trim = 0`, only."
#> 
#> $arguments$trim
#> [1] "the fraction (0 to 0.5) of observations to be trimmed from each end of `x` before the mean is computed. Values of trim outside that range are taken as the nearest endpoint."
#> 
#> $arguments$na.rm
#> [1] "a logical value indicating whether `NA` values should be stripped before the computation proceeds."
#> 
#> $arguments$...
#> [1] "further arguments passed to or from other methods."
#> 
#> 
#> $description
#> [1] "Generic function for the (trimmed) arithmetic mean."
#> 
#> $examples
#> [1] "x <- c(0:10, 50)\nxm <- mean(x)\nc(xm, mean(x, trim = 0.10))"
#> 
#> $keyword
#> [1] "univar"
#> 
#> $name
#> [1] "mean"
#> 
#> $references
#> [1] "Becker, R. A., Chambers, J. M. and Wilks, A. R. (1988) The New S Language. Wadsworth & Brooks/Cole."
#> 
#> $seealso
#> [1] "`weighted.mean`, `mean.POSIXct`, `colMeans` for row and column means."
#> 
#> $title
#> [1] "Arithmetic Mean"
#> 
#> $usage
#> [1] "mean(x, ...)\n\n## Default S3 method: mean(x, trim = 0, na.rm = FALSE, ...)"
#> 
#> $value
#> [1] "If `trim` is zero (the default), the arithmetic mean of the values in `x` is computed, as a numeric or complex vector of length one. If `x` is not logical (coerced to numeric), numeric (including integer) or complex, `NA_real_` is returned, with a warning.\n\nIf `trim` is non-zero, a symmetrically trimmed mean is computed with a fraction of `trim` observations deleted from each end before the mean is computed."
```

Note that the output has been simplified from the `\\code{...}` etc that
are found in the help files, to get the raw version set simplify to
`FALSE`.
