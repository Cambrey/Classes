#' ---
#' title: "Homework 5"
#' author: "Cambrey Sullivan"
#' output:
#'  html_document:
#'     toc: true
#' ---
#'
#' # Problem 1
#'
library(plm)
data(Cigar)
#'   
#' ##A
#'
#' Fixed Effects (FE) Model
fe <- plm(log(sales) ~ log(price) + log(pimin) + log(ndi), data=Cigar, model = "within")
summary(fe)
#'
#' ##B
#' 
#' Dynamic Regression
pgmm1 <- pgmm(log(sales) ~ lag(log(sales)) + log(price) + log(pimin) + log(ndi) | lag(log(sales), 2:99),
              data = Cigar, effect="individual")
summary(pgmm1)
#'
#'
#' ##C
#' 
#' Two-Way Dynamic Regression
pgmm2 <- pgmm(log(sales) ~ lag(log(sales)) + log(price) + log(pimin) + log(ndi) | lag(log(sales), 2:99),
              data = Cigar, effect = "twoways", model = "twosteps")
summary(pgmm2)