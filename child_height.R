# Scatterplot HW5, MOMAGE, MOMWEIGHT
plot(dhs_data[,c("HW5", "MOMAGE", "MOMWEIGHT")],
     main = "Scatterplot for variables HW5, MOMAGE, MOMWEIGHT",
     bg = "grey", pch = 21)
#Replace Residence code
dhs_data$RESIDENCE <- dhs_data$RESIDENCE-1
#code SEX and residence with categorical variable labels
dhs_data$SEX<-factor(dhs_data$SEX, c(0,1), labels=c("Male", "Female"))
dhs_data$RESIDENCE<-factor(dhs_data$RESIDENCE, c(0,1), labels=c("Urban","Rural"))
# code as factor and assign labels
#BREASTFEED
dhs_data$BREASTFEED_<-factor(dhs_data$BREASTFEED, c(1,2,3,4),
                             labels=c("still","<1","B12",">2"))
dhs_data$BREASTFEED_ <- relevel(dhs_data$BREASTFEED_, ref = ">2")
#MOMEDU
dhs_data$MOMEDU_<-factor(dhs_data$MOMEDU, c(0,1,2),
                         labels=c("NE","Pri","SecH"))
dhs_data$MOMEDU_ <- relevel(dhs_data$MOMEDU_, ref = "SecH")
#WEALTHIND
dhs_data$WEALTHIND_<-factor(dhs_data$WEALTHIND, c(1,2,3,4,5), labels=c("pst","pr","m","rc","rcst"))
dhs_data$WEALTHIND_<- relevel(dhs_data$WEALTHIND_, ref = "rcst")
#LIVCHN
dhs_data$LIVCHN_<-factor(dhs_data$LIVCHN, c(1,2,3),
                         labels=c("<3","B34",">5"))
dhs_data$LIVCHN_<- relevel(dhs_data$LIVCHN_, ref = ">5")
#LINEAR REGRESSION
model <- lm(formula = HW5 ~ MOMAGE+MOMWEIGHT+SEX+BREASTFEED_
            +MOMEDU_+WEALTHIND_+RESIDENCE+LIVCHN_,
            data = dhs_data)
summary(model)
# stepwise forward regression
library(olsrr)
12
stepwise<-ols_step_both_p(model,prem = 0.05,pent=0.05)
stepwise
stepwise$model
model_new <- lm(formula = HW5 ~ MOMWEIGHT+BREASTFEED_
                +MOMEDU_+WEALTHIND_,
                data = dhs_data)
summary(model_new)
#interaction between MOMWEIGHT and LIVCHN
#Scatterplot
library(ggplot2)
cols <- c("#1170AA", "#F2EF10", "#EF6F6A")
ggplot(dhs_data, aes(x = MOMWEIGHT, y = HW5, color = LIVCHN_)) +
  geom_point() +
  scale_color_manual(values = cols)
#Make a model with interaction
model_Intr <- lm(HW5~MOMWEIGHT+BREASTFEED_
                 +MOMEDU_+WEALTHIND_+LIVCHN_
                 +MOMWEIGHT*LIVCHN_, data = dhs_data)
summary(model_Intr)
anova(model_new, model_Intr) #Significant
# produce residual vs. fitted plot
res <- resid(model_Intr)
plot(fitted(model_Intr), scale(res), xlab = "MOMWEIGHT", ylab =
       "Standardized residual", bg = "green", pch = 21)
abline(0,0)
# PP plot
# get probability distribution for residuals
probDist <- pnorm(scale(res))
# create PP plot
plot(ppoints(length(scale(res))), sort(probDist),col="green",
     xlab = "Observed Cum Prob", ylab = "Expected Cum Prob",
     main="Normal Probability Plot")
abline(0,1)
# Histogram
# create residuals histogram
hist(scale(res), freq = FALSE, breaks=60, col="green",
     xlab= "Regression Standardized Residual",
     ylab = "Frequency",
     main="Histogram of standardised residuals")
curve(dnorm, add = TRUE)
#LOGISTIC REGRESSION
#Transform HW5 into binary
13
# As a 0/1 variable
dhs_data$HW5_1 <- as.numeric(dhs_data$HW5 < -2)
dhs_data$HW5_L<-factor(dhs_data$HW5_1, c(0,1), labels=c("Not-Stunting", "Stunting"))
table(dhs_data$HW5_L, exclude = NULL)
# fit logistic regression
model_L <- glm(formula = HW5_1 ~ MOMWEIGHT+LIVCHN_+MOMAGE
               +MOMEDU_+WEALTHIND_+SEX+RESIDENCE+BREASTFEED_,
               data = dhs_data, family = binomial)
summary(model_L)
#Run Stepwise for logistic regression
nothing <- glm(HW5_L ~ 1,family=binomial,data = dhs_data)
step.model <- step(nothing,scope = list(upper=model_L),
                   direction="both",test="Chisq", trace = F,
                   k=qchisq(0.05,1,lower.tail=FALSE))
summary(step.model)
logistic_model <- step.model
#Interaction between MOMWEIGHT and LIVCHN
#Boxplot
cols <- c("#1170AA", "#F2EF10", "#EF6F6A")
ggplot(dhs_data, aes(x = HW5_L, y = MOMWEIGHT, fill = HW5_L)) +
  geom_boxplot() +
  scale_color_manual(values = cols) +
  facet_wrap(~LIVCHN_)
# fit logistic regression with interaction
model_Lint<-glm(formula=HW5_1~MOMWEIGHT+LIVCHN_+MOMAGE
                +MOMEDU_+MOMWEIGHT * LIVCHN_,
                data = dhs_data, family = binomial)
summary (model_Lint)
# Likelihood ratio test / Anova
anova(model_Lint,test="Chisq") #Not Significant
summary (glm(HW5_1~MOMWEIGHT+LIVCHN_+MOMAGE
             +MOMEDU_+MOMWEIGHT * LIVCHN_,
             data = dhs_data, family = binomial)) #See with interaction
# Classification Table
glm_probs <- predict(logistic_model,type = "response")
glm_pred <- ifelse(glm_probs > 0.5, "Higher", "Lower")
# print table
df_ct<-data.frame(dhs_data$HW5_L, glm_probs, glm_pred, dhs_data$MOMWEIGHT)
head(df_ct)
Csum<-table(glm_pred, dhs_data$HW5_L)
Csum
14
#Calculate accuracy rate
predicted <- ifelse(glm_probs > 0.5, "Stunting", "Not-Stunting")
mean(predicted == dhs_data$HW5_L)
# Hosmer-Lemeshow test
library(ResourceSelection)
HL <- hoslem.test(dhs_data$HW5_1, fitted(logistic_model), 30)
HL
cbind(HL$observed, HL$expected)
# compute the marginal effect of MOMWEIGHT
dhs_data$d_HW5_L <- glm_probs*(1-glm_probs)*(-0.105547)
mean(dhs_data$d_HW5_L)
mean(dhs_data$d_HW5_L <- glm_probs*(1-glm_probs)*(-0.105547))