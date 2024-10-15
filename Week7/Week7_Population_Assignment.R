# Load the "anytime" and "ggplot2" packages to complete this week's assignment.
install.packages("anytime")
install.packages("ggplot2")
library(ggplot2)
setwd("C:/GitHub/williamss/Week7/")
df <- read.csv("Plankton_move_average.csv")
# Read the "Plankton_move_average" CSV in from GitHub. 
# These are data from the Great Lakes Environmental Research Laboratory plankton sampling.

#Used the following lines to format the date and remove NAs from the dataset:
df$Date <- as.Date(df$Date, origin = "0001-01-01") # Setting values to "day zero".
df <- na.omit(df)

#Plot these population data over time with the following code:
ggplot(df)  +
  xlab("Numeric Date") + ylab("Density Individuals")+
  geom_line(df=data, aes(Date, D.mendotae), color="black", alpha = 0.7, size=1)+
  geom_line(df=data, aes(Date, LimncalanusF+LimncalanusM), color="orange",  alpha = 0.7, size=1)+ # adding males and females together, hint: this is actually spelled Limnocalanus
  geom_line(df=data, aes(Date, Bythotrephes), color="sky blue",  alpha = 0.7, size=1)+
  geom_line(df=data, aes(Date, Bythotrephes), color="sky blue",  alpha = 0.7, size=1)+
  theme_bw() 

# Export this plot to have on hand for reference in the next section of the assignment (and upload with your script). (8 pts)

# (1) - Which species is most likely to be r-selected prey and which its primary predator? (2 pts)
D.mendotae is most likley the r-selected species because it has a higher density of individuals shown on the graph. LimncalanusM is most likley the predator
because they have less individuals and when their population goes up, the prey population goes down. 
# What is one relationship the third species MIGHT have to the first two? (2 pts)
The third species might be a producer for the prey sepcies. For instance it could be vegetation that fluxuates with the number of r-selected individuals. As
the predators go up in number, the producers will slightly increase.
#Now copy/paste in the Lotka-Volterra function, plotting script, and load the "deSolve" package from the tutorial:
install.packages("deSolve")
library(deSolve)
dev.off()
LotVmod <- function (Time, State, Pars) {
  with(as.list(c(State, Pars)), {
    dx = x*(alpha - beta*y)
    dy = -y*(gamma - delta*x)
    return(list(c(dx, dy)))
  })
}


# (2) - What do alpha, beta, gamma, and delta represent in this function? (4 pts)
  alpha represents the population growth of the rate of prey.
  beta represents the rate of predation
  gamma represents the rate of prey consumption resulting to population stability. 
  delta represents how rate of prey consumption can result in predators dying off.  
  

# (3) - By only changing values for alpha, beta, gamma, and/or delta
# change the default parameters of the L-V model to best approximate the relationship between Limncalanus and D.mendotae, assuming both plots are on the same time scale.
  
  Pars <- c(alpha = 2, beta = 0.5, gamma = .2, delta = .6)
  State <- c(x = 10, y = 10)
  Time <- seq(0, 100, by = 1)
  out <- as.data.frame(ode(func = LotVmod, y = State, parms = Pars, times = Time))
  matplot(out[,-1], type = "l", xlab = "time", ylab = "population")
  legend("topright", c("Cute bunnies", "Rabid foxes"), lty = c(1,2), col = c(1,2), box.lwd = 0)
  
  Pars <- c(alpha = 2.1, beta = 0.6, gamma = .2, delta = .1)
  out <- as.data.frame(ode(func = LotVmod, y = State, parms = Pars, times = Time))
  
  matplot(out[,-1], type = "l", xlab = "time", ylab = "population")
  legend("topright", c("Cute bunnies", "Rabid foxes"), lty = c(1,2), col = c(1,2), box.lwd = 0)
  
# What are the changes you've made to alpha, beta, gamma, and delta from the default values; and what do they say in a relative sense about the plankton data? (4 pts)
  I increased the alpha to speed up the population fluxuation. Because of this there are six peaks like the plankton plot. Beta was decreased so the prey population would be greater than the predator 
  population because that is what the relationship in the plankton plot shows. I decreased delta so the predator peaks would be lower than the prey because if there are more predators tha prey, then both populations will die off. 
  Now the bunnies have a larger population than the foxes, which resembles the prey having a larger population than the predators in the plankton plot.
  
# Are there other paramenter changes that could have created the same end result? (2 pts)
  Pars <- c(alpha = 1.5, beta = 0.6, gamma = .3, delta = .2)
  State <- c(x = 10, y = 10)
  Time <- seq(0, 100, by = 1)
  out <- as.data.frame(ode(func = LotVmod, y = State, parms = Pars, times = Time))
  matplot(out[,-1], type = "l", xlab = "numeric date", ylab = "density individuals")
  legend("topright", c("D.mendotae", "LimncalanusF+LimncalanusM"), lty = c(1,2), col = c(1,2), box.lwd = 0)
  
  Decreasing the alpha to slow the population, and increasing gamma are two different changes I made to create a similar plot. Increasing the gamma sped up the population which counteracts decreasing the alpha. 
  This created a similar plot as the one altered before with the same amount of peaks. 
# Export your final L-V plot with a legend that includes the appropriate genus and/or species name as if the model results were the real plankton data, 
# and upload with your script. (hint - remember which one is the predator and which is the prey) (8 pts)




