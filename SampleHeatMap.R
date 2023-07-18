#This is the sample code for creating a simple heatmap in R

if (!require("BiocManager", quietly = TRUE))
  install.packages("BiocManager")
BiocManager::install("ComplexHeatmap", force = TRUE) #installs ComplexHeatmap library
install.packages(readxl)
install.packages(stringr)
install.packages(data.table)
install.packages(janitor)
install.packages(devtools)
install.packages(ComplexHeatmap)
install.packages(circilize)
library(readxl)
library(stringr)
library(data.table)
library(janitor)
library(devtools)
library(ComplexHeatmap)
library(circilize)

dataframe1=read_excel('/Users/leejorj/Downloads/SampleGeneSet.xlsx') #reads in excel sheet as data frame
names=dataframe1[,1] #removes all other columns so the data frame only contains gene names
dataframe2 = read.table('/Users/leejorj/Downloads/SampleDataSet.txt',sep='\t') #reads in text file table as data frame
dataframe2 %>%
  row_to_names(row_number = 1) #replaces default dataframe row names with correct ones
dataframe3 <- data.frame(matrix(ncol = 12, nrow = 0)) #creates new data frame in preparation for iteration
list <- as.data.frame(t(names)) #transposes data frame column into list for iteration purposes

for (gene in list) {
  geneTitle <- str_to_title(gene) #equalizes the formatting of gene names
  if (nrow(dataframe2[dataframe2$V1 %like% geneTitle, ]) == 0) {
    next #skips current iteration if row associated with gene does not exist in df2
  }
  row <- (dataframe2[dataframe2$V1 %like% geneTitle, ])
  dataframe3[nrow(dataframe3) + 1,] <- row #adds matching row to blank data frame
}

rownames(df3) <- NULL #resets row names
colnames(df3) <- df2[1, ] #adds in original column names from df2
dataframeWT = subset(df3, select = c(gene_name, col1, col2, col3, col4, col5, col6)) #creates new data frame with desired samples based off df3 columns
dataframeWT$gene_name <- gsub('.*_','',dfWT$gene_name) #cleans up the formatting of gene names
matrix = data.matrix(subset(dfWT, select = c(col1, col2, col3, col4, col5, col6))) #converts dfWT to numeric matrix while including all samples
sampleColumn = data.frame("V1"= c("sample 1", "sample 2", "sample 3", "sample 4", "sample 5", "sample 6")) #creates data frame with column names for 6 samples corresponding to dfWT
rownames(matrix) = toupper(dfWT$gene_names) #formats gene names to all upper case and sets them as row names for mat
colnames(matrix) = col$V1 #carries over column names in col to matrix
#Heatmap(matrix, name = "mat", column_title = "VG6 WT Samples Naive v. Treated", column_names_gp = gpar(fontsize = 10), row_title = "Inflammasome Genes", row_names_gp = gpar(fontsize = 5.5), row_order = order(as.numeric(gsub("row", "", rownames(mat)))), column_order = order(as.numeric(gsub("column", "", colnames(mat))))) #Heatmap function for alphabetically sorted gene names
Heatmap(matrix, name = "mat", column_title = "VG6 WT Samples Naive v. Treated", column_names_gp = gpar(fontsize = 10), row_title = "Inflammasome Genes", row_names_gp = gpar(fontsize = 4)) #Heatmap function for clustered samples
