#' ---
#' title: "Homework 1"
#' author: "Cambrey Sullivan"
#' output:
#'  html_document:
#'     toc: true
#' ---
#'
#' # Problem 1
#'
gasoline <- read.csv("E:/Econometrics2/Data/gasoline.csv", header=TRUE, sep=",")
attach(gasoline)
summary(gasoline)
#'   
#' ##A
#'
#'OLS
ols <- lm(LGASPCAR ~ LINCOMEP + LRPMG + LCARPCAP, data=gasoline)
summary(ols)
#'
#' Panel Data Estimation
library(plm)
panel.gasoline <- pdata.frame(gasoline, c("COUNTRY","YEAR"))  
#' 
#' Pooling OLS
pols <- plm(LGASPCAR ~ LINCOMEP + LRPMG + LCARPCAP, data=gasoline, model = "pooling")
summary(pols)
#'
#' ##B
#' 
#' Fixed Effects (FE) Model
fe <- plm(LGASPCAR ~ LINCOMEP + LRPMG + LCARPCAP, data = panel.gasoline, model = "within")
summary(fe)
#'
#' ##C
#' 
#' Random Effects (RE) Model
re <- plm(LGASPCAR ~ LINCOMEP + LRPMG + LCARPCAP, data = panel.gasoline, model = "random")
summary(re)
#'
#' ##D
#' 
#' Hausman Tests: RE vs FE
phtest(re, fe)
#' H$_0$: $\hat\beta_{RE}$ = $\hat\beta_{FE}$
#'
#' H$_1$: $\hat\beta_{RE}$ $\neq$ $\hat\beta_{FE}$
#'
#' Because  p-value <0.05, we fail to reject H$_0$, both RE and FE are unbiased. However, OLS is more efficient, so we will use FE.
#'
#' ##E
#' 
#' First Difference (FD) Model
fd <- plm(LGASPCAR ~ LINCOMEP + LRPMG + LCARPCAP+0, data = panel.gasoline, model = "fd")
summary(fd)
