# For this week it's time to start exploring your own ideas and questions in R.
  # There are at least five options in the dataset to create the following comparisons.
setwd("C:/GitHub/williamss/Week9")

# (Q1 - 12 pts) Use the dataset from the tutorial to complete one redundancy analysis (RDA) with variance partitioning on a different community (NOT the nematodes).
  # Explain the ecological importance of your significant predictor variables, or the importance if none are significant for your community.
library(readxl)
abiotic.tibble <- read_excel("Penaetal_2016_data.xlsx", sheet = "Abiotic factors")
abiotic <- as.data.frame(abiotic.tibble)

Ab.tibble <- read_excel("Penaetal_2016_data.xlsx", sheet = "Absorbance_Data_Ecoplates")
Ab <- as.data.frame(Ab.tibble)
head(Ab)
abiotic$names <- paste(abiotic$Site, abiotic$Land_Use, abiotic$Plot)
head(abiotic)
names(Ab)
Ab$names <- paste(Ab$Landuse, Ab$Rep, Ab$Water)
abiotic.means <- aggregate(x = abiotic, by = list(abiotic$names), FUN = "mean")
Ab.means <- aggregate(x = Ab, by = list(Ab$names), FUN = "mean")

abiotic.means1 <- abiotic.means[,-16]
abiotic.means2 <- abiotic.means1[,-1:-6]
abiotic.means2 <- sapply(abiotic.means2, as.numeric )
abiotic.means2 <- as.data.frame(abiotic.means2)

Ab.means1 <- Ab.means[,-35]
Ab.means2 <- Ab.means1[,-2]
Ab.means3 <- Ab.means2 [,-1]

colnames(abiotic.means2)
ord <- rda(Ab.means3 ~ pH + totalN + Perc_ash + Kalium + Magnesium + Ca + Al + TotalP + OlsenP, abiotic.means2)
ord

library(vegan)
colnames(abiotic)
ord <- rda(Ab.means3 ~ pH + totalN + Perc_ash + Kalium + Magnesium + Ca + Al + TotalP + OlsenP, abiotic)
ord

str(Ab.means2)
Ab.means2$Group.1 <- as.numeric(as.character(Ab.means2$Group.1))

# (Q2 - 12 pts) Then use the dataset from the tutorial to create a linear model related to your RDA. Try multiple predictors to find the best fit model.
  # Explain the ecological importance of the significant predictors, or lack of significant predictors.

# (Q3 - 6 pts) Provide a 3-4 sentence synthesis of how these results relate to one another and the value of considering both together for interpreting biotic-abiotic interactions.


