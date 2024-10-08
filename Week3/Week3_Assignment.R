# (1) Approximately how many hours ahead of Sunbury was the peak flow in Lewisburg during the 2011 flood? (2 pt)
  
 7 hours ahead

# (2) Give one reason why information on the time between peak flow events up- and downstream could be valuable information? (4 pts)
The time in which each peak shows, could indicate how fast the water flow is moving, depending on when the peak hits each town. 

# Package scavenger hunt! (12 pts each)

## (3) Using Google and ONLY packages from GitHub or CRAN:
    # Find a package that contains at least one function specifically designed to measure genetic drift.
install.packages("learnPopGen")
library(learnPopGen)
?coalescent.plot
coalescent.plot(n=20,ngen=30,col.order="alternating")
object<-coalescent.plot()
print(object)
plot(object)
    # Copy-paste into your script - and run - an example from the reference manual for a function within this package related to a measure of genetic drift. 
genetic.drift()
object<-genetic.drift(p0=0.5,show="heterozygosity")
plot(object,show="genotypes")
        # Depending on the function, either upload a plot of the result or use print() and copy/paste the console output into your script.
    # After running the function example, manipulate a parameter within the function to create a new result. 
genetic.drift()
object<-genetic.drift(p0=0.7,show="heterozygosity")
plot(object,show="genotypes")
        # Common options might be allele frequency, population size, fitness level, etc. 
        # Add the results of this manipulation to your script (if in the console) or upload the new plot.
       
          # By manipulating these parameters you can see how it impacts the results.
          # This type of manipulation is one example of how theoretical ecology and modelling are used to predict patterns in nature.



## (4) Using Google and ONLY packages from GitHub or CRAN:
    # Find a package that will generate standard diversity metrics for community ecology, specifically Simpson's Diversity Index.
install.packages("vegan")
library(vegan)
#?simpson.unb
data(BCI, BCI.env)
H <- diversity(BCI)
simp <- diversity(BCI, "simpson")
invsimp <- diversity(BCI, "inv")
## Unbiased Simpson
unbias.simp <- simpson.unb(BCI)
## Fisher alpha
alpha <- fisher.alpha(BCI)
## Plot all
pairs(cbind(H, simp, invsimp, unbias.simp, alpha), pch="+", col="blue")
## Species richness (S) and Pielou's evenness (J):
S <- specnumber(BCI) ## rowSums(BCI > 0) does the same...
J <- H/log(S)
## beta diversity defined as gamma/alpha - 1:
## alpha is the average no. of species in a group, and gamma is the
## total number of species in the group
(alpha <- with(BCI.env, tapply(specnumber(BCI), Habitat, mean)))
(gamma <- with(BCI.env, specnumber(BCI, Habitat)))
gamma/alpha - 1
## similar calculations with Shannon diversity
(alpha <- with(BCI.env, tapply(diversity(BCI), Habitat, mean))) # average
(gamma <- with(BCI.env, diversity(BCI, groups=Habitat))) # pooled
## additive beta diversity based on Shannon index
gamma-alpha

    # Copy-paste into your script - and run - an example from the reference manual for a function to calculate Simpson's diversity. 
data(BCI)
i <- sample(nrow(BCI), 5)
mod <- renyi(BCI[i,])
plot(mod)
mod <- renyiaccum(BCI[i,])
plot(mod, as.table=TRUE, col = c(1, 2, 2))
persp(mod)
        # Depending on the example usage of the function, either upload a plot of the result or use print() and copy/paste the console output into your script.
    # After running the function example, modify your script to generate another diversity metric that is NOT part of the example.
data(BCI)
i <- sample(nrow(BCI), 20)
mod <- renyi(BCI[i,])
plot(mod)
mod <- renyiaccum(BCI[i,])
plot(mod, as.table=NULL, col = c(6, 7, 10))
persp(mod)
        # If there are multiple diversity metrics in the example script, none of these will count as the modified script.
        # Hint: If the function can "only" calculate Simpson's diversity, the inverse of Simpson's diversity is another common metric. 
        # Add the results of this manipulation to your script (if in the console) or upload the new plot.
        
          # Diversity metrics are frequently used in community ecology for reasons ranging from a quick comparison between sites to understanding community stability.
          # Their calculation can be very tedious by hand - and very fast with a package designed for the operation.

#those are some trippy plots