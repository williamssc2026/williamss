# With the data frame you created last week you will:
uniquemain <-c("dog", "table", "grass", "cloud", "wool", "oxygen", "water", "bandaid", "lipstick", "hair", "wire", "fabric", "cake", "game", "program")
tvalue<- c("dog", "dog", "dog", "dog", "table", "table", "table", "table", "table", "table", "neon", "neon", "neon", "neon", "neon")
nunique<- c(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15)
choosing<- c(1,1,1,2,3,4,4,4,5,6,6,7,8,9,9)
decimal<- c(1.1, 2,3,4.5,5,6,6.1,6.2,6.3,7,8.5,8.9,9,10,10.5)
mydata<-data.frame(uniquemain, tvalue, nunique, decimal, choosing)
colnames(mydata)<-c ("unique.char", "three.val", "unique.num", "deci", "repeat")
row.names(mydata)<-c (uniquemain)
mydata$unique.char<- NULL
new_row<- list("dog", "1", "2", "3", "4")
mydata<- rbind(mydata, new_row)
# Create a barplot for one numeric column, grouped by the character vector with 3 unique values (10 points)
df.mean <- aggregate(as.numeric(mydata$unique.num) ~mydata$three.val, FUN = "mean")
df.mean
colnames(df.mean) <- c("Factor","Mean")
df.mean
barplot(df.mean$Mean)
barplot(df.mean$Mean, names.arg = df.mean$Factor)
df.sd <- aggregate(mydata$unique.num ~mydata$three.val, FUN = "sd")
colnames(df.sd) <- c("Factor","StanDev")
df.sd
b.plot <- barplot(df.mean$Mean, names.arg = df.mean$Factor)
  # Add error bars with mean and standard deviation to the plot
arrows(b.plot, df.mean$Mean-df.sd$StanDev,
       b.plot, df.mean$Mean+df.sd$StanDev,angle=90,code=3)
b.plot <- barplot(df.mean$Mean, names.arg = df.mean$Factor, ylim = c(0,15))
arrows(b.plot, df.mean$Mean-df.sd$StanDev,
       b.plot, df.mean$Mean+df.sd$StanDev,angle=90,code=3)
  # Change the x and y labels and add a title
#missing the export function for the pdf

title(main = "maintitle")
title(xlab = "animal", ylab = "num")
barplot<- c(mydata$three.val ~ mydata$unique.num, xlab = "Explanatory", ylab = "Response")
barplot<- c(mydata$three.val ~ mydata$unique.num, xlab = "Explanatory", ylab = "Response", main = "Scatter Plot",  cex.axis=0.8, cex.main = 0.5, cex.lab = 1.25, pch=17, col = "grey40", cex = 1.5)
  # Export the plot as a PDF that is 4 inches wide and 7 inches tall.

# Create a scatter plot between two of your numeric columns. (10 points)
plot(mydata$unique.num ~ mydata$deci)
  # Change the point shape and color to something NOT used in the example.
plot(mydata$deci ~ mydata$unique.num, xlab = "Explanatory", ylab = "Response", main = "My Favorite Scatter Plot", 
     cex.axis=0.8, cex.main = 0.5, cex.lab = 1.30, pch=18)
plot(mydata$deci ~ mydata$unique.num, xlab = "Explanatory", ylab = "Response", main = "My Favorite Scatter Plot", 
     cex.axis=0.8, cex.main = 0.5, cex.lab = 1.30, pch=18, col = "purple")
  # Change the x and y labels and add a title
plot(mydata$deci ~ mydata$unique.num, xlab = "Explanatory", ylab = "Response")
plot(mydata$deci ~ mydata$unique.num, xlab = "Explanatory", ylab = "Response", main = "Scatter Plot")
  # Export the plot as a JPEG by using the "Export" button in the plotting pane.
#forgot to change x and y
#didn't change plot names after exporting...
# Upload both plots with the script used to create them to GitHub. (5 points)
  # Follow the same file naming format as last week for the script.
  # Name plots as Lastname_barplot or Lastname_scatterplot. Save them to your "plots" folder. (5 points)
