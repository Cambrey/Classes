#' ---
#' title: "Homework 2"
#' author: "Cambrey Sullivan"
#' output:
#'  html_document:
#'     toc: true
#' ---
#'
#' # Problem 1
#'
gravity <- read.delim("E:/Econometrics2/Data/gravity10.csv")
attach(gravity)
names(gravity)
summary(gravity)
#'   
#' ##A
#'
#'OLS
ols <- lm(Trade ~ Gdp + Sim + Rlf + Rer + Cee + Emu + Dist + Bor + Lan, data=gravity)
summary(ols)
#'
#' Panel Data Estimation
library(plm)
pdata <- pdata.frame(gravity, c("id","year"))  
#' 
#' Pooling OLS
pols <- plm(Trade ~ Gdp + Sim + Rlf + Rer + Cee + Emu + Dist + Bor + Lan, data=pdata, model = "pooling")
summary(pols)
#'
#' ##B
#' 
#' Fixed Effects (FE) Model
fe <- plm(Trade ~ Gdp + Sim + Rlf + Rer + Cee + Emu + Dist + Bor + Lan, data=pdata, model = "within")
summary(fe)
#'
#' ##C
#' 
#' Random Effects (RE) Model
re <- plm(Trade ~ Gdp + Sim + Rlf + Rer + Cee + Emu + Dist + Bor + Lan, data=pdata, model = "random")
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
#' Hausman-Taylor Estimator 1
ht1 <- plm(Trade ~ Gdp + Sim + Rlf + Rer + Cee + Emu + Dist + Bor + Lan |
          Dist + Bor + Rer,
          data=pdata, model="ht")
summary(ht1)
#' 
#' ##F
#' 
#' Hausman-Taylor Estimator 2
ht2 <- plm(Trade ~ Gdp + Sim + Rlf + Rer + Cee + Emu + Dist + Bor + Lan |
          Gdp + Rlf + Rer + Dist + Bor,
          data=pdata, model="ht")
summary(ht2)