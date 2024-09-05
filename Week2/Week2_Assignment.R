# With the data frame you created last week you will:
uniquemain <-c("dog", "table", "grass", "cloud", "wool", "oxygen", "water", "bandaid", "lipstick", "hair", "wire", "fabric", "cake", "game", "program")
tvalue<- c("dog", "cat", "deer", "mouse", "hamster", "table", "chair", "desk", "couch", "cabinet", "oxygen", "nitrogen", "sulfur", "neon", "zinc")
nunique<- c(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15)
choosing<- c(1,1,1,2,3,4,4,4,5,6,6,7,8,9,9)
decimal<- c(1.1, 2,3,4.5,5,6,6.1,6.2,6.3,7,8.5,8.9,9,10,10.5)
mydata<-data.frame(uniquemain, tvalue, nunique, decimal, choosing)
colnames(mydata)<-c ("unique.char", "three.val", "unique.num", "deci", "repeat")
row.names(mydata)<-c (uniquemain)
mydata$unique.char<- NULL
new_row<- list("5", "1", "2", "3", "4")
mydata<- rbind(mydata, new_row)
# Create a barplot for one numeric column, grouped by the character vector with 3 unique values (10 points)
  # Add error bars with mean and standard deviation to the plot
  # Change the x and y labels and add a title
  # Export the plot as a PDF that is 4 inches wide and 7 inches tall.

# Create a scatter plot between two of your numeric columns. (10 points)
  # Change the point shape and color to something NOT used in the example.
  # Change the x and y labels and add a title
  # Export the plot as a JPEG by using the "Export" button in the plotting pane.

# Upload both plots with the script used to create them to GitHub. (5 points)
  # Follow the same file naming format as last week for the script.
  # Name plots as Lastname_barplot or Lastname_scatterplot. Save them to your "plots" folder. (5 points)
