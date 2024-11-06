# Load the packages from this week's tutorial, aka vignette
#We looked at brook trout population demographics in relationship to water quality and stream flashiness.
setwd("C:/GitHub/williamss/Week10")
pkgs <- installed.packages()
if (!('devtools' %in% pkgs)) { install.packages('devtools') }
if ('dbfishR' %in% pkgs) { remove.packages('dbfishR') }
devtools::install_github(repo = 'Team-FRI/dbfishR', upgrade = 'never')

library(dbfishR)


#1: Give two specific conclusions you can make from these patterns. (4 pts)

#The plot that compares YOY Ratio to RBI, shows as stream flashiness increases, younger trout abundance decreases. Because younger trout cannot handle harsher flow forces, they are less likely to be abundant on stronger flowing streams.
#The other plot comparing alkalinity to YOY Ratio shows that as alkalinity increases the abundance of young trout also increase. Because of the stable pH levels and higher nutrients in higher alkalinity levels, this increases the life of younger trout. 

#2: Rerun this analysis with either (a) a different metric of brook trout populations or a different species from the database. (6 pts)
#can change sizes/species from tutorial (lines 17-26)

sites <- get_sites()
events <- get_events()
events_meta <- merge(sites, events[,c("SiteCode","EventCode","WaterTemp","pH","SpecCond","Alk","DO")])
events_meta$year <-substring(as.character(events_meta$EventCode),1,4)

fish_rec <- get_fish_records()

brookie_count <- aggregate(ID~EventCode, data = subset(fish_rec, Species == "Brook Trout" & Pass == "Pass 1"), FUN = length)
colnames(brookie_count)[2] <- "TotalCount"
small_brookie_count <- aggregate(ID~EventCode, data = subset(fish_rec, Length_mm < 100 & Species == "Brook Trout" & Pass == "Pass 1"), FUN = length)
colnames(small_brookie_count)[2] <- "SmallCount"
big_brookie_count <- aggregate(ID~EventCode, data = subset(fish_rec, Length_mm > 99 & Species == "Brook Trout" & Pass == "Pass 1"), FUN = length)
colnames(big_brookie_count)[2] <- "BigCount"

df_list <- list(brookie_count,small_brookie_count, big_brookie_count)
all_brookies <- Reduce(function(x, y) merge(x,y, all= TRUE), df_list)

all_brookies$SmallCount[is.na(all_brookies$SmallCount)] <- 0 #this allows the replace NA below to only take care of 100% YOY NAs
all_brookies$YOYRatio <- all_brookies$SmallCount/(all_brookies$BigCount+all_brookies$SmallCount)
all_brookies$YOYRatio[is.na(all_brookies$YOYRatio)] <- 1 #NAs are 100% YOY.

brookie_events <- merge(all_brookies, events_meta)

library(dataRetrieval)

HUC6 <- "020501"#North Branch Susquehanna
HUC_list <-paste(rep(HUC6,10), seq(0, 9, length.out = 10), sep="0")#To do a full HUC6 at once, just pick your HUC6 and auto-populate the subwatersheds (only works up to 9 HUC8 in a HUC6)

gage_df <- readNWISdata(huc = HUC_list, parameterCd = "00060", startDate = "2010-01-01", endDate = "2020-12-31")

devtools::install_github(repo = 'leppott/ContDataQC', force = TRUE)
1
library(ContDataQC)
if(!require(remotes)){install.packages("remotes")}  #install if needed
remotes::install_github("leppott/ContDataQC")
1
install.packages("ContDataQC", dependencies = TRUE, INSTALL_opts = '--no-lock')

gage_df$year <- sapply(strsplit(as.character(gage_df$dateTime), "-"),"[[",1)#Create year to get annual R-B index

R_B_HUC <- aggregate(X_00060_00003~year+site_no, data = gage_df, FUN = RBIcalc)#Aggregate by year and site w/in the HUC
colnames(R_B_HUC)[3] <- "RBI" #rename column

fish_rec <- get_fish_records()

brookie_count <- aggregate(ID~EventCode, data = subset(fish_rec, Species == "Brown Trout" & Pass == "Pass 1"), FUN = length)
colnames(brookie_count)[2] <- "TotalCount"
small_brookie_count <- aggregate(ID~EventCode, data = subset(fish_rec, Length_mm < 100 & Species == "Brown Trout" & Pass == "Pass 1"), FUN = length)
colnames(small_brookie_count)[2] <- "SmallCount"
big_brookie_count <- aggregate(ID~EventCode, data = subset(fish_rec, Length_mm > 99 & Species == "Brown Trout" & Pass == "Pass 1"), FUN = length)
colnames(big_brookie_count)[2] <- "BigCount"

df_list <- list(brookie_count,small_brookie_count, big_brookie_count)
all_brookies <- Reduce(function(x, y) merge(x,y, all= TRUE), df_list)

all_brookies$SmallCount[is.na(all_brookies$SmallCount)] <- 0 #this allows the replace NA below to only take care of 100% YOY NAs
all_brookies$YOYRatio <- all_brookies$SmallCount/(all_brookies$BigCount+all_brookies$SmallCount)
all_brookies$YOYRatio[is.na(all_brookies$YOYRatio)] <- 1 #NAs are 100% YOY.

brookie_events <- merge(all_brookies, events_meta)

library(dataRetrieval)

HUC6 <- "020501"#North Branch Susquehanna
HUC_list <-paste(rep(HUC6,10), seq(0, 9, length.out = 10), sep="0")#To do a full HUC6 at once, just pick your HUC6 and auto-populate the subwatersheds (only works up to 9 HUC8 in a HUC6)

gage_df <- readNWISdata(huc = HUC_list, parameterCd = "00060", startDate = "2010-01-01", endDate = "2020-12-31")

devtools::install_github(repo = 'leppott/ContDataQC', force = TRUE)
1
1
library(ContDataQC)

gage_df$year <- sapply(strsplit(as.character(gage_df$dateTime), "-"),"[[",1)#Create year to get annual R-B index

R_B_HUC <- aggregate(X_00060_00003~year+site_no, data = gage_df, FUN = RBIcalc)#Aggregate by year and site w/in the HUC
colnames(R_B_HUC)[3] <- "RBI" #rename column

stations_meta <- readNWISsite(unique(R_B_HUC$site_no))

medium_stations <- subset(stations_meta, drain_area_va > 10 & drain_area_va < 100)

library(sf)
medium_stations_so <- st_as_sf(medium_stations,coords = c("dec_lat_va", "dec_long_va"))

events_so <- st_as_sf(brookie_events[!is.na(brookie_events$SiteLon),], coords = c("SiteLat","SiteLon"))#remove NAs to create spatial object

fish_flow_tmp <- st_join(events_so, medium_stations_so, join = st_nearest_feature)

library(nngeo)
#distances are in degrees
fish_flow_tmp$dist <- unlist(st_nn(events_so, medium_stations_so, returnDist = T)$dist)
fish_flow_tmp <- subset(fish_flow_tmp, dist < 0.5)

#because of year and spatial join needed to change order of operations. Space first, then time
fish_flow <- merge(fish_flow_tmp, R_B_HUC, by = c("year", "site_no"))

mod <- lm(TotalCount~RBI, data = fish_flow)
summary(mod)
mod2 <- lm(BigCount~RBI, data = fish_flow)
summary(mod2)
mod3 <- lm(SmallCount~RBI, data = fish_flow)
summary(mod3)
mod4 <- lm(YOYRatio~RBI, data = fish_flow)
summary(mod4)
library(itsadug)
plot(mod4$residuals)
gam.mod <- gam(YOYRatio~RBI, data = fish_flow, na.action = na.omit, method = "REML")#RBI only
summary(gam.mod)
AIC(gam.mod)
plot_smooth(gam.mod, view="RBI", rm.ranef=FALSE)


#3: How do the results of your analysis compare to the vignette? (5 pts)
#These results are almost the same as the brrok trout results because they show a decreasing relationship between flashiness and young brown trout.
#It shows that as stream flashiness increases, the abundance of brown trout decreases due to intense flow. 


#4: For your final project you'll need to find two separate data sources to combine similar to the process here. Bring one new dataset to compare to fish 
  #In prep for that, find one data source to compare with either the data in dbfishR OR DataRetrieval. (5 pts)
  #Read data from that source into your script. (5 pts)
  #Create any analysis of your choice that combines the two data sources, this can be as simple as a linear model. (5 pts)
#DryAd data set: https://datadryad.org/stash/dataset/doi:10.5061/dryad.sxksn02zj
#compares to dbfishR "stream flashiness" data by testing environmental factors like water flow, temperature, and pH effect fish within the stream.
install.packages("readxl")
library(readxl)
my_data <- read_excel("env.sel_spp_matrices.xlsx")
colnames(my_data)
summary(my_data)
events_meta$names<- paste(events_meta$SiteCode, events_meta$SiteID, events_meta$ChooseMe, events_meta$SiteName, events_meta$TribTo)
events_meta
events_meta.means <- aggregate(x = events_meta, by = list(events_meta$names), FUN = "mean")
events_meta.means1 <- events_meta.means[,-2]
events_meta.means2 <- events_meta.means1[,-4:-6]
