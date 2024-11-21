
### Import libraries.
library(ggplot2)
library(RColorBrewer)

### Read input file from 2024 spreadsheet format.
informe <- as.data.frame(read.csv("InformeResultados2024.csv"))
# Get columns from spreadsheet, and format them for R numeric values.
valgen <- as.numeric(gsub(",", ".", informe[,3]))
crotal <- as.numeric(gsub(",", ".", informe[,18]))
canac <- as.numeric(gsub(",", ".", informe[,20]))
crotalM <- as.numeric(gsub(",", ".", informe[,27]))
crotalP <- as.numeric(gsub(",", ".", informe[,33]))
partos <- as.numeric(gsub(",", ".", informe[,36]))
litros <- as.numeric(gsub(",", ".", informe[,64]))

# Make dataframe.
informe <- as.data.frame(cbind(valgen, crotal, canac, crotalM, crotalP, partos, litros))
# Get all rows without relevant data.
rows_to_delete <- c()
for (i in 1:nrow(informe)){
  if (is.na(informe$valgen[i])){
    rows_to_delete <- c(rows_to_delete, i)
  }
}
# Remove the rows.
informe <- informe[-rows_to_delete, ]
# Convert all NA values to 0.
for (i in 1:nrow(informe)){
  for (j in 1:ncol(informe)){
    if (is.na(informe[i,j])){
      informe[i,j] <- 0
    }
  }
}
rownames(informe) <- informe$crotal
# Set thresholds.
litrosTH <- 200
partosTH <- 0 
valgenTH <- 30

# Sort according to litros.
best_litros <- informe[order(informe$litros, decreasing = TRUE),]
#write.csv(best_litros, "litros_sorted_2024.csv")
# Make partos a categorical variable for plotting.
informe$partos <- as.factor(informe$partos)
# Asegurarse de que el crotal sea un factor en el orden de aparición.
informe$crotal <- factor(informe$crotal, levels = informe$crotal)

# Gráfico
p <- ggplot(informe, aes(x = crotal, y = litros, fill = as.factor(partos))) +
  geom_bar(stat = "identity", color = "black", size = 0.2) +  # Bordes finos negros en las barras.
  theme_minimal() +
  labs(x = "Crotal", y = "Litros", fill = "Partos") + 
  scale_fill_brewer(palette = "Set3") +
  geom_segment(aes(x = crotal, xend = crotal, y = -40, yend = 0), color = "grey8", linewidth = 0.3) + # Lineas de cada barra a us crotal. 
  theme(
    panel.grid.major.x = element_blank(),   # Quitar las líneas de cuadrícula en el eje x
    panel.grid.minor.x = element_blank(),   # Quitar las líneas menores en el eje x
    panel.grid.major.y = element_line(color = "gray80")  # Hacer más claras las líneas del eje y
  ) +
  geom_text(aes(label = valgen), size = 2.2, angle = 70,  nudge_y = 30) + # Texto sobre las barras.
  geom_label(data = subset(informe, valgen > valgenTH), # Markador sobre threshold.
             aes(label = valgen), fill = "white", color = "blue4", 
             size = 2.2, angle = 70, nudge_y = 30, label.size = 0.1) +
  theme(axis.title.x=element_blank(), # Quitar labels del eje x para pltoearlas a parte.
        axis.text.x=element_blank(),
        axis.ticks.x=element_blank()) +
  geom_text(aes(label = crotal, y = -50),  # Ajustar y según el rango de litros
            angle = 90, size = 1.2, vjust = 0.5, hjust = 1) # Labels de crotal en eje x.

p

ggsave("InformeResultados2024Grafico.png", p)

### Analyze manually entered dataset from 2023.
informe <- as.data.frame(read.csv("InformeResultados2023.csv"))
informe$n <- rownames(informe)
rownames(informe) <- informe$crotal

# Sort according to valor genetico, milk production and partos.
best_valgen <- informe[order(informe$valorgenetico, decreasing = TRUE),]
best_partos <- informe[order(informe$partos, decreasing = TRUE),]
best_litros <- informe[order(informe$litros, decreasing = TRUE),]

#write.csv(best_litros, "litros_sorted.csv")
# Write out sorted dfs.
#write.csv(best_valgen, "best_valgen.csv")
#write.csv(best_partos, "best_partos.csv")
#write.csv(best_litros, "best_litros.csv")

# Make plot
#p <- ggplot(informe, aes(x = n, y = litros, color = partos)) +
#  geom_bar(stat = "identity", fill = "white")


# Make partos a categorical variable for plotting.
informe$partos <- as.factor(informe$partos)
# Asegurarse de que el crotal sea un factor en el orden de aparición
informe$crotal <- factor(informe$crotal, levels = informe$crotal)


# Gráfico
p <- ggplot(informe, aes(x = crotal, y = litros, fill = as.factor(partos))) +
  geom_bar(stat = "identity", color = "black", size = 0.2) +  # Bordes finos negros en las barras.
  theme_minimal() +
  labs(x = "Crotal", y = "Litros", fill = "Partos") + 
  scale_fill_brewer(palette = "Set3") +
  geom_segment(aes(x = crotal, xend = crotal, y = -40, yend = 0), color = "grey8", linewidth = 0.3) + # Lineas de cada barra a us crotal. 
  theme(
    panel.grid.major.x = element_blank(),   # Quitar las líneas de cuadrícula en el eje x
    panel.grid.minor.x = element_blank(),   # Quitar las líneas menores en el eje x
    panel.grid.major.y = element_line(color = "gray80")  # Hacer más claras las líneas del eje y
  ) +
  geom_text(aes(label = valorgenetico), size = 2.5, angle = 50,  nudge_y = 30) + # Texto sobre las barras.
  geom_label(data = subset(informe, valorgenetico > 30), # Markador sobre threshold.
             aes(label = valorgenetico), fill = "white", color = "blue4", 
             size = 2.5, angle = 50, nudge_y = 30, label.size = 0.1) +
  theme(axis.title.x=element_blank(), # Quitar labels del eje x para pltoearlas a parte.
        axis.text.x=element_blank(),
        axis.ticks.x=element_blank()) +
  geom_text(aes(label = crotal, y = -50),  # Ajustar y según el rango de litros
            angle = 90, size = 2, vjust = 0.5, hjust = 1)

p







