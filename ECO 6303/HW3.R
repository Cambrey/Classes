#' ---
#' title: "Homework 3"
#' author: "Cambrey Sullivan"
#' output:
#'  html_document:
#'     toc: true
#' ---
#'
#' # Problem 1
#'
data <- read.delim("E:/Econometrics2/Data/nlswork.csv")
library(plm)
attach(data)
pdata <- plm.data(data, c("id","year"))
names(data)
#'   
#' ##A
#'
#'FE2SLS Regression
fe2sls <- plm(lwage ~ age + age2 + smsa + tenure | . -tenure + south + union, data = pdata, model = "within")
summary(fe2sls)
#'
#' ##B
#' 
#' RE2SLS Regression - G2SLS
re2sls.bvk <- plm(lwage ~ age + age2 + smsa + tenure | . -tenure + south + union, data = pdata, inst.method = "bvk", model = "random")
summary(re2sls.bvk) 
#' 
#'
#' ##C
#' 
#' RE2SLS Regression - EC2SLS
re2sls.baltagi <- plm(lwage ~ age + age2 + smsa + tenure | . -tenure + south + union, data = pdata, inst.method = "baltagi", model = "random")
summary(re2sls.baltagi)
#'
#' Hausman Tests: FS2SLS vs EC2SLS
phtest(fe2sls, re2sls.baltagi)
#' H$_0$: $\mu_{\imath}$|X$_{\imath}$ = 0
#'
#' H$_1$: $\mu_{\imath}$|X$_{\imath}$ $\neq$ 0
#'
#' Because  p-value < 0.05, we fail to reject H$_0$. RE2LS is more effecient than FE2SLS, so we will use EC2SLS.
#'