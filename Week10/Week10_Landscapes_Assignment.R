# Load the packages from this week's tutorial, aka vignette
#We looked at brook trout population demographics in relationship to water quality and stream flashiness.
pkgs <- installed.packages()
if (!('devtools' %in% pkgs)) { install.packages('devtools') }
if ('dbfishR' %in% pkgs) { remove.packages('dbfishR') }
devtools::install_github(repo = 'Team-FRI/dbfishR', upgrade = 'never')

library(dbfishR)


#1: Give two specific conclusions you can make from these patterns. (4 pts)


#2: Rerun this analysis with either (a) a different metric of brook trout populations or a different species from the database. (6 pts)
#can change sizes/species from tutorial (lines 17-26)

#3: How do the results of your analysis compare to the vignette? (5 pts)



#4: For your final project you'll need to find two separate data sources to combine similar to the process here. Bring one new dataset to compare to fish 
  #In prep for that, find one data source to compare with either the data in dbfishR OR DataRetrieval. (5 pts)
  #Read data from that source into your script. (5 pts)
  #Create any analysis of your choice that combines the two data sources, this can be as simple as a linear model. (5 pts)