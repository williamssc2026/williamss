# First, recreate Figure 4 from Herron et al. (2019). De novo origins of multicellularity in response to predation. Scientific reports.
#https://datadryad.org/stash/dataset/doi:10.5061/dryad.53k345s
  # Search datadryad.org by the paper title and download the dataset. It will include .csv files and R scripts, organized by figure.
  # Save the script and change the working directory on lines 8 and 115 to match your computer
  # Upload the plot you've created to GitHub. (4 points)
Figure4Data_1_
myplot
  # Zoom into your plot to look at the distribution for different strains.

# Do all of the strains in the plot have the same distributions (yes/no)? (1 pt)
No
# Based on these observations of your strain distributions, why did the authors use a Kruskal-Wallis test rather than ANOVA to compare the strains? (3 pts)
The Kruskal-Wallis test analyzes the median better, and is more useful for this graph because seeral of the strains do not vary much from eachother
which makes it difficult to get an accurate reading of the mean. ANOVA would not work because the assumptions are not met since this graph does not have a normal distrobution. 

# Use the fitdist() and gofstat() functions to compare the poisson, negative binomial, and logistic distributions for:
  # (1) - The number of cells of progeny (data$Num.Cells.Progeny)
?"fitdist"
install.packages("fitdistrplus")
library(fitdistrplus)
#How are you reading in the data?
data_zero <- as.numeric(na.omit(Figure4Data_1_$Num.Cells.Progeny))
data_zero <- as.numeric(na.omit(data$Num.Cells.Progeny))
one.col <- data_zero #All we need to do is change the vector to re-run.


fit.norm <- fitdist(one.col, distr = "norm")
fit.normpois <- fitdist(one.col, distr = "pois")
fit.normnbinom <- fitdist(one.col, distr = "nbinom")
fit.nornlogis <- fitdist(one.col, distr = "logis")

gof_resultsnorm <- gofstat(fit.norm)
gof_resultspois <- gofstat(fit.normpois)
gof_resultsnbinom <- gofstat(fit.normnbinom)
gof_resultslogis <- gofstat(fit.nornlogis)
#Why didn't you run these together like we did in class?
  # (2) - The replication time (data$RepTime.sec)
    #HINT- "Num.Cells.Progeny" has defined breaks. To display results, use the formula with the "chisqbreaks" argument as follows:
      #gofstat(list(fit.1, fit.2, fit.3, etc), chisqbreaks=c(1,2,4,8,16,32,64))

data_zero2 <- as.numeric(na.omit(data$RepTime.sec))
one.col2 <- data_zero2
fit.norm2 <- fitdist(one.col2, distr = "norm")
fit.normpois2 <- fitdist(one.col2, distr = "pois")
fit.normnbinom2 <- fitdist(one.col2, distr = "nbinom")
fit.nornlogis2 <- fitdist(one.col2, distr = "logis")

gof_resultsnorm2 <- gofstat(fit.norm2)
gof_resultspois2 <- gofstat(fit.normpois2)
gof_resultsnbinom2 <- gofstat(fit.normnbinom2)
gof_resultslogis2 <- gofstat(fit.nornlogis2)

# Based on the AIC scores, which distribution is the best fit for: (5 pts each)
  # (1) - The number of cells of progeny (data$Num.Cells.Progeny)?
summary(fit.norm)
summary(fit.normpois)
summary(fit.normnbinom)
summary(fit.nornlogis)

Both the poisson and negatie binomial distrobutions work best for this data set because they generated the same but lowest AIC score.
#Poission is not even close to nbinom AIC score.
  # (2) - The replication time (data$RepTime.sec)?
summary(fit.norm)
summary(fit.normpois2)
summary(fit.normnbinom2)
summary(fit.nornlogis2)

The negative binomial is the best distrobution because it has the lowest AIC score. 


# Plot a generic histogram for the replication time (data$RepTime.sec) (4 pt)
hist(data_zero2)
# Based on the patterns of this histograms and Figure 4:
  #Give one hypothesis for an evolutionary process represented by the two tallest bars in your histogram. (8 pts)
Based on the data showing the different cells over time, it shows that a species could have possibly be introduced to a new environment and started with
a large abundance. As they stayed in the environment longer, they began to die off due to lack of adaptations and tolerances. As time went on they became more 
equipped to survive in the new habitat and they began to grow in population again. 
#If this was population density over time, then yes. but it's a frequncy of a reproduction rates within a population.
  # Don't cheat by looking at the paper! 
    # This hypothesis does not need to be correct - it only needs to be ecologically rational based these two figures.








