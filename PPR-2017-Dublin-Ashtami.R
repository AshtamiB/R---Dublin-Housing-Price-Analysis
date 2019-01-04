

#Reading input file and creating a dataframe
PPR_data <- read.csv("C:/Users/Ashtami/Documents/RSE/PPR-2017-Dublin_ashtami.csv", stringsAsFactors = F)
PPR_data <- data.frame(PPR_data)

#Changing names of columns for simplicity of use
names(PPR_data)[5] <- "Price" 
names(PPR_data)[3] <- "PostalCode" 
names(PPR_data)[1] <- "Date"


#To handle missing Postal Code values, substituting those blank values by "Not AVailable"
PPR_data$PostalCode <- sub("^$", "Not Available", PPR_data$PostalCode)

# 1. The average sale price in each Postal Code.
avgPrice <- aggregate(PPR_data$Price,list(PPR_data$PostalCode), mean)
print(avgPrice)

# 2. The address corresponding to the maximum sale price in each Postal Code
library(sqldf)
address <- sqldf("SELECT Address, MAX(Price), PostalCode FROM PPR_data GROUP BY PostalCode")
print(address)

# 3. The month in which the sale of the maximum sale price occurred. 
m <- format(as.POSIXct(PPR_data[PPR_data$Price == max(PPR_data$Price), "Date"]),"%B")
print(m)

# Bonus summary chart
summary(PPR_data$Price)

#From the summary it has been observed that you can have sale price of property from as lowest as ???7000 and as highest as ???33538000. The average sale price in Dublin is ???420130. 25% of the total available properties were purchased for the cost below ???242000.As the maximum value of property is very far from the mean as compared to lowest price, implies that there are few exclusive properties which are comparatively expensive than rest of the property prices in Dublin


