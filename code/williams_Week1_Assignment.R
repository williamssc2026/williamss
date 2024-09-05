# Now it is time to create your own data frame using the tools we have learned this week.
# First, resave this script as: yourlastname_Week1_Assignment [1 point]
  # e.g. mine would be Wilson_Week1_Assignment
stuff

# Create 3 numeric vectors and 2 character vectors that are each 15 values in length with the following structures: [15 points; 3 each]
  # One character vector with all unique values
uniquemain <-c("dog", "table", "grass", "cloud", "wool", "oxygen", "water", "bandaid", "lipstick", "hair", "wire", "fabric", "cake", "game", "program")
  # One character vector with exactly 3 unique values
tvalue<- c("dog", "cat", "deer", "mouse", "hamster", "table", "chair", "desk", "couch", "cabinet", "oxygen", "nitrogen", "sulfur", "neon", "zinc")
  # One numeric vector with all unique values
nunique<- c(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15)
  # One numeric vector with some repeated values (number of your choosing)
choosing<- c(1,1,1,2,3,4,4,4,5,6,6,7,8,9,9)
  # One numeric vector with some decimal values (of your choosing)
decimal<- c(1.1, 2,3,4.5,5,6,6.1,6.2,6.3,7,8.5,8.9,9,10,10.5)

# Bind the vectors into a single data frame, rename the columns, and make the character vector with unique values the row names.[3 points]
mydata<-data.frame(uniquemain, tvalue, nunique, decimal, choosing)
colnames(mydata)<-c ("unique.char", "three.val", "unique.num", "deci", "repeat")
row.names(mydata)<-c (uniquemain)

# Remove the character vector with unique values from the data frame.[2 points]
mydata$unique.char<- NULL
# Add 1 row with unique numeric values to the data frame.[2 points]
new_row<- list("5", "1", "2", "3", "4")
mydata<- rbind(mydata, new_row)
# Export the data frame as a .csv file [2 points]
write.csv(mydata, file = "mydatafile")
# Generate summary statistics of your data frame and copy them as text into your script under a new section heading. [2 points]
summary(mydata)
#summary of data frame:
# three.val          unique.num            deci              repeat         
Length:16          Length:16          Length:16          Length:16         
Class :character   Class :character   Class :character   Class :character  
Mode  :character   Mode  :character   Mode  :character   Mode  :character  
# Push your script and your .csv file to GitHub in a new "Week1" folder. [3 points]


