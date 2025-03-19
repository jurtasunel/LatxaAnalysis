### Libraries.
library(caret)
library(class)
library(nestedcv)

### Functions.

### Data.
setwd("C:/Users/zir826/Desktop/2024-25/other/roncal")

### Preprocessing.
# inputfile <- as.data.frame(read.csv("InformeResultados2024.csv"))
# 
# # Get meaninful rows from spreadsheet.
# inputfile <- inputfile[14:nrow(inputfile),]
# # Get important columns from spreadsheet.
# valgen <- inputfile[,3]
# crotal <- inputfile[,18]
# cana <- inputfile[,20]
# crotalM <- inputfile[,27]
# crotalP <- inputfile[,33]
# npartosULT <- inputfile[,36]
# fechapartoULT <- inputfile[,38]
# nvivosULT <- inputfile[,41]
# nmuertosULT <- inputfile[,43]
# ncontrULT <- inputfile[,45]
# diasULT <- inputfile[,48]
# ordeULT <- inputfile[,50]
# tipoULT <- inputfile[,52]
# laPROM <- inputfile[,58]
# diasPROM <- inputfile[,59]
# orderPROM <- inputfile[,60]
# tipoPROM <- inputfile[,61]
# acumPROM <- inputfile[,64]
# 
# # Make dataframe and remove empty rows.
# completeData <- as.data.frame(cbind(valgen, crotal, cana, crotalM, crotalP, npartosULT, fechapartoULT, nvivosULT, nmuertosULT, ncontrULT, diasULT, ordeULT, tipoULT, laPROM, diasPROM, orderPROM, tipoPROM, acumPROM))
# completeData <- completeData[-c(which(completeData$crotal == "")),]
# rownames(completeData) <- 1:nrow(completeData)
# write.csv(completeData, "completeData2024.csv")
# 
# # Get rows with valgen and litros acumulados, and remove parent IDs and mostly empty columns.
# cleanData <- completeData[-c(which(completeData$valgen == "" | completeData$acumPROM == "")), -c(4,5,9)]
# rownames(cleanData) <- 1:nrow(cleanData)
# write.csv(cleanData, "cleanData2024.csv")
cleanData <- read.csv("cleanData2024.csv")

### Plotting valgen barplot.

# Gráfico
# Ensure crotal is a factor and acumPROM is numeric
cleanData$crotal <- as.factor(cleanData$crotal)
cleanData$acumPROM <- as.numeric(cleanData$acumPROM)

# Create the bar plot
p <- ggplot(cleanData, aes(x = crotal, y = acumPROM, fill = as.factor(npartosULT))) +
  geom_bar(stat = "identity", color = "black", size = 0.2) + # Bordes finos negros en las barras.
  theme_minimal() +
  labs(x = "Crotal", y = "Litros acumulados", fill = "Partos") + 
  scale_fill_brewer(palette = "Set3") +
  geom_segment(aes(x = crotal, xend = crotal, y = -40, yend = 0), color = "grey8", linewidth = 0.3) + # Lineas de cada barra a us crotal. 
  theme(
    panel.grid.major.x = element_blank(),   # Quitar las líneas de cuadrícula en el eje x
    panel.grid.minor.x = element_blank(),   # Quitar las líneas menores en el eje x
    panel.grid.major.y = element_line(color = "gray80")  # Hacer más claras las líneas del eje y
  ) +
  geom_text(aes(label = valgen), size = 2.5, angle = 60,  nudge_y = 30) + # Texto sobre las barras.
  geom_label(data = subset(cleanData, valgen > 30), # Markador sobre threshold.
             aes(label = valgen), fill = "white", color = "blue4", 
             size = 2.5, angle = 50, nudge_y = 30, label.size = 0.1) +
  theme(axis.title.x=element_blank(), # Quitar labels del eje x para pltoearlas a parte.
        axis.text.x=element_blank(),
        axis.ticks.x=element_blank()) +
  geom_text(aes(label = crotal, y = -50),  # Ajustar y según el rango de litros
            angle = 90, size = 2, vjust = 0.5, hjust = 1)

# Print the plot
p

