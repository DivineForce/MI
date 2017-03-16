setwd("/home/apurva/Desktop/cage_weights/Batch13")

# Use grep and grep1 with subset


library(readxl)
library(plyr)



#CSV filenames to use 
Batch="Batch13"
number="B13-"

df <- read_excel("MI_P50_Batch13_23August2016.xlsx", col_names = T, na = "")



# Template 

transpnum
batchnumber
cagenumber
comments
resolution
weight_1
date_1
weight_2
date_2
weight_3
date_3
weight_4
date_4
weight_5
date_5
weight_6
date_6
weight_7
date_7
weight_8
date_8
weight_9
date_9
weight_10
date_10


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









yo<-as.data.frame(transpnum,batchnumber,date_weight)



# Append Batch to the cagenumber 

View(bcage)
rownames(tranp) <- NULL
transpnum<-tranp







#CSV file name 
name.to.use<-paste("P50-Novelty_Seeking-Processed_",Batch,".csv",sep="")

rm(list=ls())
