# For this week it's time to start exploring your own ideas and questions in R.
  # There are at least five options in the dataset to create the following comparisons.
setwd("C:/GitHub/williamss/Week9")

# (Q1 - 12 pts) Use the dataset from the tutorial to complete one redundancy analysis (RDA) with variance partitioning on a different community (NOT the nematodes).
  # Explain the ecological importance of your significant predictor variables, or the importance if none are significant for your community.
library(readxl)
veg.tibble <- read_excel("Penaetal_2016_data.xlsx", sheet = "Vegetation_plots_all_sites")
veg <- as.data.frame(veg.tibble)
head(veg)

Abiotic.tibble <- read_excel("Penaetal_2016_data.xlsx", sheet = "Abiotic factors")
Abiotic <- as.data.frame(Abiotic.tibble)
head(Abiotic)

Abiotic$names <- paste(Abiotic$Site, Abiotic$LandUse, Abiotic$Plot)
veg$names <- paste(veg$Site, veg$Landuse, veg$Plot)

Abiotic.means <- aggregate(x = Abiotic, by = list(Abiotic$names), FUN = "mean")

Abiotic.means1 <- Abiotic.means[-19,]
Abiotic.means2 <- Abiotic.means1[,-2:-6]
Abiotic.means3<- Abiotic.means2 [, -11]

veg1<- veg[,-1:-3]
veg2<- veg1[,c(94, 1:93)]

row.names(veg2)<-veg2 [,1]

veg3<-veg2[, -1]

library(vegan)
ord <- rda(veg3 ~ pH + totalN + Perc_ash + Kalium + Magnesium + Ca + Al + TotalP + OlsenP, Abiotic.means3)
ord
summary(ord)
anova(ord)
#There were no significant predictor variables shown by a p-value of 0.335 which is more than .05. 
#This could be due to the vegetation plots having a high number of zero's in the data frame. 
#Because of the lack of vegetation found in the plots, this could have been a reason for insignificance.
#There could be other complex interactions at play within the vegetation and abiotic community that cause for low data numbers and predictors.
#Other species and environmental interactions would affect the vegetation recorded in each plot by possibly reducing or increasing it. Species and environmental factors could also play a role in the abiotic factors as well.
#For instance, humans could alter the pH recorded.

# (Q2 - 12 pts) Then use the dataset from the tutorial to create a linear model related to your RDA. Try multiple predictors to find the best fit model.
  # Explain the ecological importance of the significant predictors, or lack of significant predictors.
library(readxl)

data.tibble <- read_excel("Penaetal_2016_data.xlsx", sheet = "Data_experiment_urtica")
data <- as.data.frame(data.tibble)

library(vegan)

data2<- na.omit(data)
data2<- as.data.frame(data2)
mod<- lm(as.numeric(data2$Dry_biomass)~data2$Landuse)
summary(mod)
typeof(data2)

data2$names <- paste(data2$Landuse, data2$Parcel, data2$Sterilization)
data2.means <- aggregate(x = data2, by = list(data2$names), FUN = "mean")

data2.means1 <- data2.means[,-2:-5]
data2.means2 <- data2.means1[,-4]
data2.means3<- data2.means2 [, -5]
data2.means4<- data2.means3[,-8:-13]
data2.means5<- data2.means4 [,-9]

plot(data2.means5$Dry_biomass~data2.means5$Runners)
mod<- lm(data2.means5$Dry_biomass~data2.means5$Runners)

summary(mod)
abline(mod)
colnames(data2.means5)


plot(data2.means5$Length_main_stem~data2.means5$Dry_biomass)
mod1<- lm(data2.means5$Length_main_stem~data2.means5$Dry_biomass)
summary(mod1)
abline(mod1)
#Best fit model^

plot(veg3$Acer_platanoides~veg3$Angelica_archangelica)
plot(veg3$Acer_campestre~veg3$Adox_moschatellina)

#The variables in the best fit model are significant predictors. This could be because the Dry_biomass does not have any complete zeros.
#The same goes for the stem length. All data collected for both has recordings of numbers ranging bigger and smaller.
#The data frame shows that when biomass is smaller, then the stem length is also shorter, and more biomass results in longer stems.
#If the biodiversity is drier, then there is not as much moisture to contribute to stem growth. As more moisture becomes prevalent, the stems increase in length.
#This contributes to the ecosystem process by providing food/shelter to other organisms depending on moisture present. 
#If there are less organisms, including other plants to protect the stems, this could result in higher predation due to less cover and other food sources for predators. 
#Biomass supports different amounts of biodiversity depending on what it can provide, if it is significantly dry, then there is less organisms within the community.

#This is all true, but did not combine data from two sheets for the analysis.

# (Q3 - 6 pts) Provide a 3-4 sentence synthesis of how these results relate to one another and the value of considering both together for interpreting biotic-abiotic interactions.

#Both results can relate to each other by having an effect on one another's abundance/outcome.
#Both together can correlate off one another, by having a cause to how present an organism is, or how it is surviving based on the environmental factors around it.
#For example, abiotic chemical factors, including pH of water, can affect the stem growth based from the urtica data.
#Putting both factors together helps interpret the direct correlation between the two, and can give us an idea of how they affect abundance of each other in communities.
