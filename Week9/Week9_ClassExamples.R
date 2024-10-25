setwd("C:/GitHub/R4Eco_2024/Week9")
library(readxl)

community.tibble <- read_excel("FE-2023-01235.xlsx", sheet = "Bird survey results")
community <- as.data.frame(community.tibble)

metrics.tibble <- read_excel("FE-2023-01235.xlsx", sheet = "Diversity indices")
metrics <- as.data.frame(metrics.tibble)

library(vegan)

mod<- lm(metrics$`Mean clutch size (mean per site)`~metrics$`Faith's phylogenetic diversity`)
summary(mod)

plot(metrics$`Migration distance (mean per site)`~metrics$`Species richness`)
mod<- lm(metrics$`Migration distance (mean per site)`~metrics$`Species richness`)
summary(mod)
abline(mod)
colnames(metrics)


plot(metrics$`Species richness`~metrics$`Functional richness`)


boxplot(metrics$`Species richness`~metrics$`Invasion absence/occurrence`)
mod <- lm(metrics$`Species richness`~metrics$`Invasion absence/occurrence`)
summary(mod)

#plot RDA
mod <- rda(community[,-1])
plot(mod)
summary(mod)
#Extract PCs
pcas <- as.data.frame(mod$CA$u)
pcas$PC1
#Compare PC to invasion
mod <- lm(pcas$PC1~metrics$`Invasion absence/occurrence`)
summary(mod)


#merge

all.data <- merge(community, metrics, by="Site ID")
