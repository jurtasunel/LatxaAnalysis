
### Libraries.
library(caret)
library(class)
library(nestedcv)

### Functions.

### Data.
setwd("C:/Users/zir826/Desktop/2024-25/other/roncal")
inputfile <- as.data.frame(read.csv("InformeResultados2024.csv"))
inputfile <- inputfile[14:nrow(inputfile),]

### Get columns from spreadsheet.
valgen <- inputfile[,3]
crotal <- inputfile[,18]
cana <- inputfile[,20]
crotalM <- inputfile[,27]
crotalP <- inputfile[,33]
npartosULT <- inputfile[,36]
fechapartoULT <- inputfile[,38]
nvivosULT <- inputfile[,41]
nmuertosULT <- inputfile[,43]
ncontrULT <- inputfile[,45]
diasULT <- inputfile[,48]
ordeULT <- inputfile[,50]
tipoULT <- inputfile[,52]
laPROM <- inputfile[,58]
diasPROM <- inputfile[,59]
orderPROM <- inputfile[,60]
tipoPROM <- inputfile[,61]
acumPROM <- inputfile[,64]

# Make dataframe and remove empty rows.
completeData <- as.data.frame(cbind(valgen, crotal, cana, crotalM, crotalP, npartosULT, fechapartoULT, nvivosULT, nmuertosULT, ncontrULT, diasULT, ordeULT, tipoULT, laPROM, diasPROM, orderPROM, tipoPROM, acumPROM))
completeData <- completeData[-c(which(completeData$crotal == "")),]
#rownames(completeData) <- paste0("animal_", 1:nrow(completeData))
write.csv(completeData, "completeData.csv", row.names = FALSE)

