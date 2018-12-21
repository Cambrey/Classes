#' ---
#' title: "Homework 7"
#' author: "Cambrey Sullivan"
#' output:
#'  html_document:
#'     toc: true
#' ---
#'
#' # Problem 1

library(sampleSelection)
library(np)
data(Mroz87)
attach(Mroz87)

#' ## A
plot(wage~educ, data=data, main="Boxplot Wage and Education", 
        xlab="Education", ylab="Wage")

#' ## B

ols1 <- lm(wage ~ exper + city + educ, data=data)
summary(ols1)

#' Marginal effects of the variables are the beta hat for the variable when using OLS.
#' exper: 0.09260
#' city: 0.10038
#' educ: 0.42756 

#' ## C
#' 
model2 <- lm(wage ~ exper + city + educ + I(educ^2), data=data)
summary(model2)
summary(model2$coefficients["educ"]+2*model2$coefficients["I(educ^2)"]*educ)

#' Marginal effects of the linear variables are equal to beta hat. Education is calculated by taking the partial derivative of education. We will use the average marginal effect below.
#' exper: 0.09260
#' city: 0.10038
#' educ: 0.4246
#' 
#' ## D
#' 
model.pl <- npplreg(wage ~ exper + city | educ, data=data)
summary(model.pl)
coef(model.pl)                 
coef(model.pl, errors = TRUE) 

#' Marginal effects of the linear variables are equal to beta hat. 
#' exper: 0.09141892
#' city: 0.1539375

wage.sub <- wage - model.matrix(~ exper + city)[,-1]%*%coef(model.pl)
model.sub <- npreg(wage.sub~educ)
plot(model.sub, xlab="education", ylab="wage")
