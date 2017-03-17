setwd("/home/apurva/Desktop/cage_weights/Batch13")

# Use grep and grep1 with subset


library(readxl)
library(plyr)



#CSV filenames to use 
Batch="Batch13"
number="B13-"

df <- read_excel("MI_P50_Batch13_23August2016.xlsx", col_names = T, na = "")

# Step 1
# First convert all column names to lower case
names(df) <- tolower(names(df))

# 1. tranpsnum 
transpnum_index<-grep("transpnum",names(df))
transpnum<-df[,transpnum_index]


# 2. batchnumber
# Use variable Batch
r<-nrow(df)
batchnumber<-rep('Batch13',r)
names(batchnumber)="batchnumber"

# 3. cagenumber
cage_index<-grep("^cage$",names(df))
cagenumber<-df[,cage_index]
names(cagenumber)<-"cagenumber"
#Append batch to cagenumber 
cagenumber<-paste(number,cagenumber,sep="")

# 4. Comments
comments_index<-grep("^comments$",names(df))
comments<-df[,comments_index]

# 5. Resolution
resolution_index<-grep("^resolution$",names(df))
resolution<-df[,resolution_index]

# weight and date values 
# Grep everything after resolution index 
date_weight<-df[(resolution_index+1):ncol(df)]
ncol(date_weight)
# If the above value is odd 
#delete last column with all NAs
no_vals<-sapply(date_weight, function(x)all(is.na(x)))
no_vals<-which(no_vals)
date_weight<-date_weight[,-no_vals]


#Create empty data frame with ncrow equal to number of animals
#Number of columns will be constant = 20 
#Create a empty dataframe
final_weights<-data.frame(matrix(NA, nrow = nrow(df), ncol = 20))
final_weights[,1:ncol(date_weight)]<-date_weight

colnames(final_weights)<-c("Date_1","Weight_1","Date_2","Weight_2","Date_3","Weight_3","Date_4","Weight_4","Date_5","Weight_5","Date_6","Weight_6","Date_7","Weight_7","Date_8","Weight_8","Date_9","Weight_9","Date_10","Weight_10")

#Check if dates are in sorted orders 
#is.unsorted should return False if they are sorted 
date1<-unique(final_weights$Date_1)
date2<-unique(final_weights$Date_2)
date3<-unique(final_weights$Date_3)
date4<-unique(final_weights$Date_4)
date5<-unique(final_weights$Date_5)
date6<-unique(final_weights$Date_6)
date7<-unique(final_weights$Date_7)
date8<-unique(final_weights$Date_8)
date9<-unique(final_weights$Date_9)
date10<-unique(final_weights$Date_10)
dates<-cbind.data.frame(date1,date2,date3,date4,date5,date6,date7,date8,date9,date10)
is.unsorted(dates,na.rm=T)

#Combine all required columns 
df<-data.frame(transpnum,batchnumber,cagenumber,comments,resolution,final_weights)

#Convert all column names to lower case 
names(df) <- tolower(names(df))
#Re-arrange column order according to DB template
df<-df[c("transpnum","batchnumber","cagenumber","comments","resolution","weight_1","date_1","weight_2","date_2","weight_3","date_3","weight_4","date_4","weight_5","date_5","weight_6","date_6","weight_7","date_7","weight_8","date_8","weight_9","date_9","weight_10","date_10")]

df <- apply(df,2,function(x){x[x=='n/a'] <- NA;x})
df<-data.frame(df)


#CSV file name 
name.to.use<-paste("P50-MI-Cage-Weights_",Batch,".csv",sep="")

rm(list=ls())
