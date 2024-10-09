# Read in the "Toscano_Griffen_Data.csv" data from GitHub and load the three packages we used in the tutorial this week.
# The paper these data came from is uploaded to Canvas as "Toscano&Griffen_2014_JAE..."
library(MASS)
library(MuMIn)
library(mgcv)
# First create mo"MASS"# First create models with the same (y) and method (GLMM) as the published paper, using the GLMM function from this week's tutorial. 
setwd("C:/GitHub/williamss/Week6/")
df <- read.csv("Toscano_Griffen_Data.csv")
df$activity.level
glmm.mod <- glmmPQL(activity.level ~ temperature + carapace.width + claw.width, family = binomial,random = ~ 1 | block, data = df)
  #Create two different models using the same 3 predictor (x) variables from the dataset. (4 points each) 
    # In one model only include additive effects.block
    # In the other model include one interactive effect.
    # Use a binomial distribution and block as a random effect in both models to match the paper's analyses. Remember ?family to find distribution names.
?family
glmm.mod2 <- glmmPQL(prop.cons ~ temperature + carapace.width + claw.width, family = binomial,random = ~ 1 | block, data = df)
glmm.mod3 <- glmmPQL(prop.cons*activity.level ~ temperature + carapace.width + claw.width, family = binomial,random = ~ 1 | block, data = df)
#This changes your y variable rather than adding an interactive effect.
# The authors used proportional consumption of prey as the (y) in their model, but did not include this in the dataset.
  # So we are going to create it - run the following line, assuming df= your data frame (feel free to change that):
df$prop.cons <- df$eaten/df$prey 
#this line run out of order with your models.
# (Q1) - The code I've provided in line 13 above is performing two operations at once. What are they? (2 pts)
They provide a mixed model.
#Nope - create a proportion and add it to the data as a new vector.
# (Q2) - Did the interactive effect change which variables predict proportional consumption? How, SPECIFICALLY, did the results change? (5 pts)
summary(glmm.mod2)
summary(glmm.mod3)
Yes it affected all variables. Temperature went up from -0.848 to -0.867, carapace.width dropped from -0.410 to -0.375, and claw.width dropped from 0.120 to 0.095.
#What values are you looking at to get these numbers? I can't find them in the summary results. Also, I would suggest looking at the p-values first.
# (Q3) - Plot the residuals of both models. Do you think either model is a good fit? Why or why not? (3 pts)
plot(glmm.mod2)
plot(glmm.mod3)
The glmm.mod2 is a better plot because it has more of a liner pattern in the correlation of the residuals. Most of the points are near eachother with a few outliers on the end, which
is better than glmm.mod3 because it has many outliers throughout the upperhalf with no pattern. 
#You don't want a linear pattern in residuals! No pattern is the best.

# Re-run both models as generalized additive models instead (using gam). Then compare the AIC of both models. (4 points each)
gam.mod2 <- gam(prop.cons ~ temperature + carapace.width + claw.width, family = binomial,random = ~ 1 | block, data = df)
gam.mod3 <- gam(prop.cons*activity.level ~ temperature + carapace.width + claw.width, family = binomial,random = ~ 1 | block, data = df)
#Only took points off once for the interactive switch-up.
summary(gam.mod2)
summary(gam.mod3)
aic1 <- AIC(gam.mod2)
aic2 <- AIC(gam.mod3)
# (Q4) - Which model is a better fit? (2 pt)
Model three has a better fit because it has a lower AIC score.

# (Q5) - Based on the residuals of your generalized additive models, how confident are you in these results? (2 pts)
plot(gam.mod2$residuals, ylim = c(-.1,.1))#Why did you use these ylims? It's excluding most of your data.
plot(gam.mod3$residuals, ylim = c(-.1,.1))
plot(gam.mod2$residuals)
plot(gam.mod3$residuals)
#Both actually have patterns...

 I am confident that model 2 is the better model to show the results because the gam residuals are closer together at the zero mark in the plot, than those in the model 3.
They are better compacted representing more of a pattern.
#Pattern = bad.


