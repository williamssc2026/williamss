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
Ab.means <- aggregate(x = Ab, by = list(Ab$names), FUN = "mean")

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




# (Q2 - 12 pts) Then use the dataset from the tutorial to create a linear model related to your RDA. Try multiple predictors to find the best fit model.
  # Explain the ecological importance of the significant predictors, or lack of significant predictors.

# (Q3 - 6 pts) Provide a 3-4 sentence synthesis of how these results relate to one another and the value of considering both together for interpreting biotic-abiotic interactions.


