#' ---
#' title: "Homework 6"
#' author: "Cambrey Sullivan"
#' output:
#'  html_document:
#'     toc: true
#' ---
#'
#' # Problem 1
#'
library(pglm)
library(plm)
library(survival)
NLS <- read.delim("E:/Econometrics2/Data/NLS.csv")
pdata <- pdata.frame(NLS, c("idcode","year"))
#' ## A
#' Random Effects Logit
re.logit <- pglm(union~age+grade+south, data=pdata, 
                 family=binomial('logit'), model="random")
summary(re.logit)

#' ## B
#' Random Effects Probit
re.probit <- pglm(union~age+grade+south, data=pdata,  
                  family=binomial('probit'), model="random")
summary(re.probit)
#' ## C
#' Fixed Effects Logit
fe.logit <- clogit(union~age+grade+south+strata(idcode), data=pdata) 
summary(fe.logit)