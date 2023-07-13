library(readxl)
library(stringr)
library(data.table)
library(janitor)
library(devtools)
library(ComplexHeatmap)

df1=read_excel('/Users/leejorj/Downloads/InflammasomeGeneSet.xlsx') #reads in excel sheet as data frame
a=df1[,1] #removes all other columns so the data frame only contains gene names
df2 = read.table('/Users/leejorj/Downloads/RawCountFile_rsemgenes.txt',sep='\t') #reads in text file table as data frame
df2 %>%
  row_to_names(row_number = 1) #replaces default dataframe row names with correct ones
df3 <- data.frame(matrix(ncol = 12, nrow = 0)) #creates new data frame in preparation for iteration
list <- as.data.frame(t(a)) #converts data frame column into list for iteration purposes
for (gene in list) {
  geneTitle <- str_to_title(gene) #equalizes the formatting of gene names
  if (nrow(df2[df2$V1 %like% geneTitle, ]) == 0) {
    next #skips current iteration if row associated with gene does not exist in df2
  }
  row <- (df2[df2$V1 %like% geneTitle, ])
  df3[nrow(df3) + 1,] <- row #adds matching row to blank data frame
}
rownames(df3) <- NULL #resets row names
colnames(df3) <- df2[1, ] #adds in original column names from df2
dfWT = subset(df3, select = c(gene_id, D6, B06, C06, D9, A12, D12)) #creates new data frame with desired samples based off df3 columns
dfWT$gene_id <- gsub('.*_','',dfWT$gene_id) #cleans up formatting of gene names
mat = data.matrix(subset(dfWT, select = c(D6, B06, C06, D9, A12, D12))) #converts dfWT to numeric matrix while including all samples
#mat = data.matrix(subset(dfWT, select = c(B06, C06, A12, D12))) #numeric matrix conversion with only 4 samples
col = data.frame("V1"= c("Vg6_naive_WT1", "Vg6_naive_WT2", "Vg6_naive_WT3", "Vg6_treat_WT1", "Vg6_treat_WT2", "Vg6_treat_WT3")) #creates data frame with column names for 6 samples corresponding to dfWT
#col = data.frame("V1"= c("Vg6_naive_WT2", "Vg6_naive_WT3", "Vg6_treat_WT2", "Vg6_treat_WT3")) #same as above but for 4 samples
rownames(mat) = toupper(dfWT$gene_id) #formats gene names to all upper case and sets them as row names for mat
colnames(mat) = col$V1 #carries over column names in col to matrix
#Heatmap(mat, name = "mat", column_title = "VG6 WT Samples Naive v. Treated", column_names_gp = gpar(fontsize = 10), row_title = "Inflammasome Genes", row_names_gp = gpar(fontsize = 4), row_order = order(as.numeric(gsub("row", "", rownames(mat)))), column_order = order(as.numeric(gsub("column", "", colnames(mat))))) #Heatmap function for alphabetically sorted gene names
Heatmap(mat, name = "mat", column_title = "VG6 WT Samples Naive v. Treated", column_names_gp = gpar(fontsize = 10), row_title = "Inflammasome Genes", row_names_gp = gpar(fontsize = 4)) #Heatmap function for clustered samples
