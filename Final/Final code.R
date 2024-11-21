setwd("C:/GitHub/williamss/Final/")
dataset1 <- read.csv("Dataset+1.csv")
datamass <- read.csv("Brannelly_Data_Mass.csv")

colnames(datamass)[colnames(datamass) == 'Mass_g'] <- 'Mass1'
colnames(dataset1)[colnames(dataset1) == 'BdExposed'] <- 'Exposed'
colnames(datamass)[colnames(datamass) == 'Days_Survived.1'] <- 'Days_Survived'
colnames(dataset1)[colnames(dataset1) == 'DaysSurv'] <- 'Days_Survived'

merged_df <- merge(dataset1, datamass, by = "Exposed", all = TRUE)
 