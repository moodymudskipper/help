% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/Help.R
\name{doc}
\alias{doc}
\title{get content of help file in a list}
\usage{
doc(topic, package = NULL, simplify = TRUE)
}
\arguments{
\item{topic}{function either in `fun` or `pkg::fun` form, or character}

\item{package}{oprtional character}

\item{simplify}{wether to simplify formatting}
}
\value{
a list
}
\description{
get content of help file in a list
}
\examples{
doc(mean)
}
