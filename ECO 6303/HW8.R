#' ---
#' title: "Homework 8"
#' author: "Cambrey Sullivan"
#' output:
#'  html_document:
#'     toc: true
#' ---
#'
#' # Problem 1
library(AER)
library(sampleSelection)
data <- read.csv("F:/Econometrics2/Data/Mroz87new.csv")
summary(data)
#' ## A
ols <- lm(wage ~ age + exper + educ, data=data)
summary(ols)

#' ## B

tobit1 <- tobit(wage ~ age + exper + educ, data=data)
summary(tobit1)

#' ## C
#' 
heckit.ml <- selection(lfp ~ age + exper + educ + faminc + kids,
                       wage ~ age + exper + educ,
                       method="ml", data=data)
summary(heckit.ml)

#' 
#' ## D
#' 
heckit.2step <- heckit(lfp ~ age + exper + educ + faminc + kids,
                          wage ~ age + exper + educ, data=data)
summary(heckit.2step) 
