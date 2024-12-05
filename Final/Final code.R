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

#With the "filtered_data" dataframe, I reduced the amount of data shown to 20% because all the data was too clustered for interpretation without reduction.
#I had to put a limit on the x-axis so the data would show proportions clearly because showing the full 60,000 points was difficult to read.
#I made the points smaller and more spread out by altering "size" "width" "height" and "alpha"
#I made sure the two different points of exposure were different colors so they could be differentiated.
#Finally i was able to make the graph into a scatter plot.
sampled_data <- filtered_data[sample(nrow(filtered_data), size = 0.2 * nrow(filtered_data)), ]
ggplot(sampled_data, aes(x = 1:nrow(sampled_data), y =Survived, color = factor(Exposed))) +
  geom_jitter(aes(color = factor(Exposed)), size = 0.5, width = 0.2, height = 0.2, alpha = 0.6) +
  geom_point(size = 3) +  # Plot the points
  labs(
    x = "Number of Individuals",
    y = "Number of Days Survived",
    color = "Exposed"
  ) + ggtitle("Survival Days by Exposure Status")+
  scale_color_manual(values = c("mediumpurple1", "skyblue")) +  # Set colors for Exposed vs. Not Exposed
  theme_minimal() + xlim(0,5000)

#To make the next linear model, I had to clean the data of NA values.
clean<- na.omit(filtered_data)
#This linear model analyzes exposure to the fungus, and if death from it was prevalent. 
model3 <- lm(Died ~ Exposed, data = clean)
summary(model3)

#For the last figure, I had to count the number of "1" and "0" values in the "Died" column.
#Then I had to change the numeric values of the "Died" column to represent character values of "Death" and "Survived".
#Using this I made a bar graph showing number of individuals who survived and didn't.
  summary_data <- data.frame(
    Category = c("Death", "Survived"),
    Count = c(sum(df_merged$Died == 1), sum(df_merged$Died == 0))  # Count deaths and survivors
  )

  ggplot(summary_data, aes(x = Category, y = Count, fill = Category)) +
    geom_bar(stat = "identity") +  # Use stat="identity" to map actual data values to the bars
    scale_fill_manual(values = c("Death" = "darkred", "Survived" = "darkgreen")) +  # Custom colors
    labs(
      title = "Death and Survival Counts",
      x = "Survival Status",
      y = "Count"
    )  +
    theme_minimal() 
  