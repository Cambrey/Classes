---
  title: "Econometrics 1 Notebook"
output:
  html_document:
  df_print: paged
---
  
data=read.table("c:/Users/Cambrey/Documents/R/Baltagi/CIGARETT.DAT",header=T)
attach(data)
names(data)
#A
#Descriptive Statistics
summary(LNC)
summary(LNP)
summary(LNY)
#Histograms
hist(LNC)
hist(LNP)
hist(LNY)
#Plots
plot(LNC~LNY,xlab="Log of Real Disposable Income", ylab="Log of Consumption")
plot(LNC~LNP,xlab="Log of Real Price(1983$/Pack)", ylab="Log of Consumption")
#Correlation Matrix
cor(cbind(LNY,LNC,LNP))
#B
#Regression
reg1 <- lm(LNC ~ LNY)
names(reg1)
summary(reg1)
#Elasticity (Coefficient estimate*(Mean LNY/Mean LNC))
-0.2270
#Standard error of the slope estimate (sqrt(diag(vcov(reg1))))
0.2000
#H0(elasticity=0)
#Ha(elasticity=/=0)
#Pr(>|t|) = 0.262
#the p-value is > 0.05, so we fail to reject the null. Cigarrete consumption is inelastic.

#Residual Standard Error
0.1908

#Multiple R^Squared
0.02845
#C
(cor(LNY,LNC))^2
cor(fitted(reg1),data$LNC)^2
#D
#Residuals graph
plot(reg1$residuals ~ LNY, xlab="Log of Real Disposable Income", ylab="Residuals")
abline(h=0, lty="dashed")
#Regression + Confiedence Band graph
BasicRegressionPlot = function(LNY,LNC, main = "Regression", xlab = "Log of Real Disposable Income",ylab = "Log of Cosumption", plt = TRUE, matchScale = FALSE)
  summary(reg2)
{
  reg2 <- lm(LNC~LNY)
  if (TRUE)
  {
    if(FALSE)
    {
      lower = min(min(LNY), min(LNC)) - 0.2*max(sd(LNY),sd(LNC))
      upper = max(max(LNY), max(LNC)) + 0.2*max(sd(LNY),sd(LNC))
      plot(LNY,LNC,main = "Regression",xlab="Log of Real Disposable Income",ylab="Log of Consumption", xlim = c(lower,upper), ylim = c(lower,upper))
    }
    else
    {
      plot(LNY,LNC,main ="Regression",xlab="Log of Real Disposable Income",ylab="Log of Consumption", xlim = c(min(LNY)-sd(LNY), max(LNY) + sd(LNY)), ylim = c(min(LNC)-sd(LNC), max(LNC) + sd(LNC)))
    }
    abline(reg=reg2)
  }
  return(reg2)
  }

ConfidenceBandPlot = function(LNY,LNC,main="Regression + Confidence Band",xlab="Log of Real Disposable Income",ylab="Log of Consumption", col = "red", lty =2, lwd =1, alpha=0.05)
{
  regression <- lm(LNC~LNY)
  plot(LNY,LNC,main = "Regression + Confidence Band",xlab="Log Of Real Disposable Income",ylab="Log of Consumption", xlim = c(min(LNY)-sd(LNY), max(LNY) + sd(LNY)), ylim = c(min(LNY)-sd(LNC), max(LNC) + sd(LNC)))
  abline(reg=regression)
  MSE = sum(regression$residuals^2)/regression$df.residual
  RSE = sqrt(MSE)
  n = length(LNY)
  X0 = seq(min(LNY) - 10*sd(LNY), max(LNY) + 10*sd(LNY), length = 300)
  SE = RSE*sqrt(1/n + ((X0 - mean(LNY))^2)/(sum((LNY-mean(LNY))^2)))
  LB = qt(alpha/2, df = n-2)*SE
  UB = qt(1-alpha/2,df=n-2)*SE
  Yhat = regression$coefficients[1] + regression$coefficients[2]*X0
  UB = UB + Yhat
  LB = LB + Yhat
  lines(X0, UB, lty=lty, col = col)
  lines(X0, LB, lty=lty, col = col)
  abline(h=0,lty=2,col="grey")
  abline(v=0,lty=2,col="grey")
}
X = seq(1,10, length = 100)
Y = X + rnorm(length(LNY), 0, 5)
ConfidenceBandPlot(LNY,LNC, alpha = 0.05)
abline(a=0,b=1, col ="blue")

#' ---
#' title: Homework 3
#' author: Cambrey Sullivan
#' output:
#'	html_document:
#'  	toc: true
#' ---
#' # Problem 1
#' Female = 1, male = 0
#' Black = 1, not black = 0
#' Hispanic = 1, not hispanic = 0
#'
#' ## A
#' E(earnings/hispanic female)= a + BF +BB +BH + u
#' We are assuming that u = 0
#' F = 1
#' B = 0
#' H = 1
#' So, E(earnings/hispanic female)= a + BF +BH
#'
#' E(earnings/hispanic male)= a + BF +BB +BH + u
#' #' We are assuming that u = 0
#' F = 0
#' B = 0
#' H = 1
#' So, E(earnings/hispanic male)= a + BH
#'
#' a + BF +BH - (a + BH) = BF
#'
#' ## B
#' E(earnings/hispanic female)= a + BF +BH
#' E(earnings/white female)= a + BF
#' a + BF +BH - (a + BF) = BH
#'
#' E(earnings/hispanic male)= a + BH
#' E(earnings/white male)= a
#' a + BH - a = BH
#'
#' ## C
#' E(earnings/black female)= a + BF +BB
#' a + BF +BB - (a + BF) = BB
#'
#' E(earnings/black male)= a +BB
#' a +BB - (a) = BB
#'
#' # Problem 2
data=read.table("c:/Users/Cambrey/Documents/R/Baltagi/EARN.ASC",header=T)
attach(data)
names(data)
summary(data)
#' ## A
model.unres <- lm(LWAGE ~ WKS + SOUTH + SMSA + MS + EXP + EXP2 + OCC + IND + UNION + FEM + BLK + ED)
summary(model.unres)
#' ## B
#' F = 41.26 = (R^2/(1-R^2))*((n-K)/K-1) =
(0.4597/(1-0.4597))*((582)/12)
#' ## C
model.res1 <- lm(LWAGE ~ WKS + SOUTH + SMSA + MS + EXP + EXP2 + OCC + IND + UNION +  ED)
summary(model.res1)
#' ## D
model.res2 <- lm(LWAGE ~ WKS + SOUTH + SMSA + EXP + EXP2 + OCC + IND + FEM + BLK + ED)
summary(model.res2)
anova(model.res2, model.unres)
#' ## E
e <- exp(1)
(e^0.1062781)-1
#' 0.1121311 = 11.21% increase in earnings for union membership.
#' Kennedy's suggested calculation:
e^(0.1062781+.5*0.0316755^2)-1
#' 0.1126892 = 11.27% increase in earnings for union membership.
#' ## F
(e^0.095237)-1
#' 0.09991951 = 10% increase in earnings when married.
#' Kennedy's suggested calculation:
e^(0.095237+.5*0.0489277^2)-1
#' 0.1012369 = 10.1% increase in earnings when married

#' ---
#' title: Homework 4
#' author: Cambrey Sullivan
#' output:
#'	html_document:
#'  	toc: true
#' ---
#'
data=read.table("c:/Users/Cambrey/Documents/R/Baltagi/EARN.ASC",header=T)
attach(data)
summary(data)
#' # Problem 1
reg1 <- lm(LWAGE ~ WKS + SOUTH + SMSA + MS + EXP + EXP2 + OCC + IND +  UNION + FEM + BLK + ED)
summary(reg1)
#' fail to reject all 3
plot(reg1$residuals ~ LWAGE, xlab="Log Wage", ylab="Residuals")
abline(h=0, lty="dashed")
library(lmtest)	
bptest(reg1)
#' H$_0$ -> E($\mu^2_{i}$)  = $\sigma^2$
#'
#' H$_1$ -> E($\mu^2_{i}$)  =/= $\sigma^2_{i}$
#'
#' p-value = 0.002725, < 0.05, so we reject H$_0$
u2 <- reg1$residuals^2
gls <- lm(LWAGE ~ WKS + SOUTH + SMSA + MS + EXP + EXP2 + OCC + IND +  UNION + FEM + BLK + ED, weights=1/u2)
summary(gls)
#' they are all significant
#'
#' # Problem 2
#'
data=read.table("c:/Users/Cambrey/Documents/R/Baltagi/USGAS.ASC",header=T)
attach(data)
summary(data)
L.QMG.CAR <- log(QMG/CAR)
L.RGNP.POP <- log(RGNP/POP)
L.CAR.POP <- log(CAR/POP)
L.PMG.PGNP <- log(PMG/PGNP)
reg2 <- lm(L.QMG.CAR ~ L.RGNP.POP + L.CAR.POP + L.PMG.PGNP)
summary(reg2)
plot(reg2$residuals ~ YR, xlab="Time", ylab="Residuals")
abline(h=0, lty="dashed")
dwtest(L.QMG.CAR ~ YR)
#'
#' H$_0$ -> $\rho$  = 0
#'
#' H$_1$ -> $\rho$  =/= 0
#'
#' Reject H$_0$
library(nlme)
gls <- gls(L.QMG.CAR ~ L.RGNP.POP + L.CAR.POP + L.PMG.PGNP, correlation=corAR1(), method = "ML")
summary(gls)

#' ---
#' title: Homework 5
#' author: Cambrey Sullivan
#' output:
#'	html_document:
#'  	toc: true
#' ---
#'
#' # Problem 1
data=read.table("c:/Users/Cambrey/Documents/R/Baltagi/MROZ.txt",header=T)
attach(data)
summary(data)
#'
#' ## A
ols <- lm(lwage ~ educ)
summary(ols)
#'
#' For every year of education, wage will increase by 11.04%, on average.
e <- exp(1)
(e^0.1104)-1
#' More precisely, for every year of education, wage will increase by 11.67%, on average.
#'
#' ## B
library(AER)
tsls <- ivreg(lwage ~ educ | fatheduc)
summary(tsls)
#' For every year of education, wage will increase by 6.49%, on average.
#'
e <- exp(1)
(e^0.06493)-1
#' More precisely, for every year of education, wage will increase by 6.71%, on average.
#'
#' ## C
first.stage <- lm(educ ~ fatheduc)
summary(first.stage)
#' F-statistic: 182.8 (greater than 10), so the instrument is not weak
#'
#' ## D
library(systemfit)
hausman.systemfit(tsls, ols)
#' H$_0$ -> $\hat\beta_{TSLS}$  = $\hat\beta_{OLS}$
#'
#' H$_1$ -> $\hat\beta_{TSLS}$  =/= $\hat\beta_{OLS}$
#'
#' Because  p-value = 0.1912, <0.05, we fail to reject H$_0$, both TSLS and OLS are unbiased. However, OLS is more efficient.

#' ---
#' title: Homework 6
#' author: Cambrey Sullivan
#' output:
#'	html_document:
#'  	toc: true
#' ---
#'
#' # Problem 1
#'
data=read.table("c:/Users/Cambrey/Documents/R/Baltagi/EARN.ASC",header=T)
attach(data)
summary(data)
#' ##A
ols <- lm(UNION ~ EXP + WKS + OCC + IND + SOUTH + SMSA + MS + FEM + ED +  BLK)
table(UNION, ols$fitted.values>0.5)
summary(ols)
#' The marginal effect of EXP is the coefficient of the variable (-1.143).
#'
#' The marginal effect of FEM is (-1.371).
#'
#' ##B
logit <- glm(UNION ~ EXP + WKS + OCC + IND + SOUTH + SMSA + MS + ED +  BLK + FEM,
             family=binomial(link = "logit"))
table(UNION, logit$fitted.values>0.5)
summary(logit)
mean(dlogis(logit$linear.predictors)) * logit$coefficients["EXP"]
#' The marginal effect of EXP is -0.001956509
fit.logit.1 <- predict(logit, within(data, FEM <- 1), type = "response")
fit.logit.0 <- predict(logit, within(data, FEM <- 0), type = "response")
mean(fit.logit.1 - fit.logit.0)
#' The marginal effect of FEM is -0.1281611
#'
#' ##C
probit <- glm(UNION ~ EXP + WKS + OCC + IND + SOUTH + SMSA + MS + ED +  BLK + FEM,
              family=binomial(link = "probit"))
table(UNION, probit$fitted.values>0.5)
summary(probit)
mean(dnorm(probit$linear.predictors)) * probit$coefficients["EXP"]
#' The marginal effect of EXP is -0.002075666
fit.probit.1 <- predict(probit, within(data, FEM <- 1), type = "response")
fit.probit.0 <- predict(probit, within(data, FEM <- 0), type = "response")
mean(fit.probit.1 - fit.probit.0)
#' The marginal effect of FEM is -0.116216

