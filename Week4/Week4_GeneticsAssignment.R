# Look at the plot and model results for our Dryad data in the tutorial. 
  # Part 1: Without knowing which points represent which groups,give one explanation for why these data might be difficult
  # to draw spatial inferences about genes.(4 points)
It is hard to differenciate the data in the plot because some are overlapping. The axis lables are also difficult to understand because they do not describe what the plots are representing.
The numbers on the graph are also very large so it is difficult to get a reading where the points are when they are between 0 and 500,000.
#Axis labels exist...it's a legend that's missing.
  # Part 2: Despite the drawbacks, give the result or interpretation that you feel most confident in (4 points), and EXPLAIN WHY (6 points).
The graph shows a diverse number of genetics with lots of variation within all the plots. It also shows the readings are skewed to the left since most plots are on the left side of the diagram.
Some of the overlapping points show that there could also be a relationship between them since they have similar readings in data. 
#The plot shows latitude and longitude...look back at the tutorial for context. Skew also isn't the right term because what are they skewed away from or toward?
#The plot is showing overlapping regions, when you don't have context of the underlying geography.

# For your scripting assignment we will use the "ge_data" data frame found in the "stability" package.
  # Install the "stability" package, load it into your R environment, and use the data() function to load the "ge_data". (2 points)
install.packages("stability")
#need library to run the package
data(ge_data)
# Create two linear models for Yield Response: one related to the Environment and one to the Genotype. (2 points each)
  # 'Yield Response' in this dataset is a measure of phenotype expression.
  # Hint: Look at the help file for this dataset.
mod.lon <- lm(ge_data$Yield ~ ge_data$Env)
mod.lon2 <- lm(ge_data$Yield ~ ge_data$Gen)
mod.latlon <- lm(ge_data$Yield ~ ge_data$Env * ge_data$Gen)
plot(ge_data$Yield ~ ge_data$Env)
plot(ge_data$Yield ~ ge_data$Gen)
# Test the significance of both models and look at the model summary. (4 points each)
summary(mod.lon)
summary(mod.lon2)
summary(mod.latlon)
  # Which model is a better fit to explain the yield response, and WHY? (6 points)
mod.lon shows to have better significance since its p-value is lower than the other models. As shown in the graph, as a box and whisker plot,
it is easier to interpret the data since it is more spaced out and the data points are enlarged to read the numerical readings. The other model which is 
mod.lon2, seems to be overfitted with an excessive amount of data points. 
#boxplots don't have anything to do with interpreting the model results though and whether or not one is over-fitted. Why is the genotype model overfitted? It's about how many factors are significant relative to the total number used.
  # Hint: Does one model seem more likely to be over-fitted?

# Which environment would be your very WORST choice for generating a strong yield response? (2 points)
summary(ge_data$Env)
I would say Bahawalnagar has the worst reponse due to its low yield reading on the graph since it is between 3000-4000.
It also has one of the shortest sets of whiskers on both ends, making it a weaker reading than other small plots. It also does not contain any outliers. 
#The question was not about the absolute yeild, but the yeild response - so it's Sargodha and Khanewal that are problematic. 
