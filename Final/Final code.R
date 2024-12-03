#I start by saving to working directory and reading the datasets into R.
setwd("C:/GitHub/williamss/Final/")
dataset1 <- read.csv("Dataset+1.csv")
datamass <- read.csv("Brannelly_Data_Mass.csv")

#Some columns have the same information but different heading, so I changed the headings so I can merge the two datasets.
colnames(datamass)[colnames(datamass) == 'Mass_g'] <- 'Mass1'
colnames(dataset1)[colnames(dataset1) == 'BdExposed'] <- 'Exposed'
colnames(datamass)[colnames(datamass) == 'Days_Survived.1'] <- 'Survived'
colnames(dataset1)[colnames(dataset1) == 'DaysSurv'] <- 'Survived'
colnames(dataset1)[colnames(dataset1) == 'DeathDate'] <- 'Died'

#I merge the datasets by the columns sharing the same information I plan to use in the figures and models. 
df_merged <- merge(dataset1[, c("Exposed", "Mass1", "Sex")], datamass[, c("Exposed", "Survived", "Died")], by = "Exposed")

#Model one is a linear model comparing mass of the frogs to how many days they survived with Bd fungus.
model <- lm(Survived ~ Mass1, data = df_merged)
summary(model)

#Since I have a lot of datapoints, I will use the aggregate function to create a mean out of the days survived and mass from the df_merged dataframe.
agg_df <- aggregate(Survived ~ Mass1, data = df_merged, FUN = mean)

#Now I am able to plot my data for viewing. I made a scatter plot from the agg_df dataframe using the "Survived" and "Mass1" columns.
#The mass is the x-axis and the days survived is the y-axis.
#I made the plotting points diamonds and chose a purple color. 
plot(agg_df$Mass1, agg_df$Survived, main = "Days vs Mass", 
     xlab = "Mass (g)", ylab = "Days Survived", col = "purple", pch = 5)

#For the next plot I did a generalized additive model (GAM), using the number of days frogs survived to how many total there were.
#Before doing a GAM, I had to install the "mgcv" package and filter the data for NaN values.
#I made a separate column in the "filtered_data" dataframe so I could get individual number of species total to use for the model.
install.packages("mgcv")
library(mgcv)
filtered_data <- subset(df_merged, Sex != "NaN")
filtered_data$RowNumber <- seq_along(filtered_data$Sex)
model2 <- gam(Survived ~ factor(Exposed), data = filtered_data)
summary(model2)

#To create the next figure I installed the "ggplot" package. 
install.packages("ggplot2")
library(ggplot2)

#With the "filtered_data" dataframe, I used sex of individuals and how many survived.
#I had to put a limit on the y-axis so the data would fit the statistics proportionally. 
ggplot(filtered_data, aes(x = Exposed, y = Survived)) + ylim(0,100) +
  geom_bar(stat = "identity")+
  ggtitle("Days Survived Between Exposure Status")

#To make the next linear model, I had to clean the data of NA values.
clean<- na.omit(filtered_data)
#This linear model analyzes exposure to the fungus, and if death from it was prevalent. 
model3 <- lm(Died ~ Exposed, data = clean)
summary(model3)

#For the last figure, I had to change the column from numeric to character values.
#Originally 0 stood for survived and 1 stood for died.
filtered_data$Died[filtered_data$Died == "0"] <- "survived"
filtered_data$Died[filtered_data$Died == "1"] <- "died"

#I made a barplot with "died" or "survived" stats as the x-axis, and number of individuals on the y-axis.
#I had to limit the y-axis to how many total individuals were present, so the chart fit the statistics proportionally. 
ggplot(filtered_data, aes(x = Died, y = RowNumber)) + ylim(0,63000) +
  geom_bar(stat = "identity") +
  labs(x = "Survivors", y = "Number of Individuals")
