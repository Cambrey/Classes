#' ---
#' title: "Homework 4"
#' author: "Cambrey Sullivan"
#' output:
#'  html_document:
#'     toc: true
#' ---
#'
#' # Problem 1
#'
library(plm)
library(nlme)
data <- read.delim("E:/Econometrics2/Data/wages1.csv")
attach(data)
names(data)
summary(data)
#'   
#' ##A
#'
#'OLS
ols <- lm(lwage ~ occ + south + smsa + ind + exp + exp2 + wks + ms + union +fem + blk + ed, data=data)
summary(ols)
#'
#' Panel Data Estimation
library(plm)
pdata <- pdata.frame(data, c("id","year"))  
#' 
#' Pooling OLS
pols <- plm(lwage ~ occ + south + smsa + ind + exp + exp2 + wks + ms + union +fem + blk + ed, data=pdata, model = "pooling")
summary(pols)
#'
#' ##B
#' 
#' Fixed Effects (FE) Model
fe <- plm(lwage ~ occ + south + smsa + ind + exp + exp2 + wks + ms + union +fem + blk + ed, data=pdata, model = "within")
summary(fe)
#'
#' Random Effects (RE) Model
re <- plm(lwage ~ occ + south + smsa + ind + exp + exp2 + wks + ms + union +fem + blk + ed, data=pdata, model = "random")
summary(re)
#'
#' Hausman Tests: RE vs FE
phtest(re, fe)
#' H$_0$: $\mu_{\imath}$|X$_{\imath}$ = 0
#'
#' H$_1$: $\mu_{\imath}$|X$_{\imath}$ $\neq$ 0
#'
#' Because  p-value < 0.05, we reject H$_0$. RE is biased, so between these, we would use FE.
#'
#'
#' ##C
#' 
#' FEAR Model (not able to print)
#'fe.ar <- gls(lwage ~ occ + south + smsa + ind + exp + exp2 + wks + ms + union +fem + blk + ed + as.factor(id), data=data, 
#'             correlation = corAR1(0, form=~year|id))
#'summary(fe.ar)
#'
#' REAR Model 
re.ar <- lme(lwage ~ occ + south + smsa + ind + exp + exp2 + wks + ms + union +fem + blk + ed, data=data,
             random = ~1|id, 
             correlation = corAR1(0, form=~year|id))
summary(re.ar)
