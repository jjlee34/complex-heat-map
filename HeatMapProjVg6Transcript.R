library(readxl)
library(stringr)
library(data.table)
library(janitor)
library(devtools)
library(ComplexHeatmap)
library(circlize)

df1=read_excel('/Users/leejorj/Downloads/InflammasomeGeneSet.xlsx')
a=df1[,1]
df2 = read.table('/Users/leejorj/Downloads/Vg6_Transcript_counts.txt',sep='\t')
df2 %>%
  row_to_names(row_number = 1)
df3 <- data.frame(matrix(ncol = 17, nrow = 0))
list <- as.data.frame(t(a))
for (gene in list) {
  geneTitle <- str_to_title(gene)
  if (nrow(df2[df2$V6 %like% geneTitle, ]) == 0) {
    next
  }
  df3[nrow(df3) + 1,] <- (df2[df2$V6 %like% geneTitle, ])
}
rownames(df3) <- NULL
colnames(df3) <- df2[1, ]
dfWT = subset(df3, select = c(Gene_Symbol, Vg6_naive_WT1, Vg6_naive_WT2, Vg6_naive_WT3, Vg6_treat_WT1, Vg6_treat_WT2, Vg6_treat_WT3))
mat = data.matrix(subset(df3, select = c(Vg6_naive_WT1, Vg6_naive_WT2, Vg6_naive_WT3, Vg6_treat_WT1, Vg6_treat_WT2, Vg6_treat_WT3)))
#mat = data.matrix(subset(df3, select = c(Vg6_naive_WT1, Vg6_naive_WT3, Vg6_treat_WT1, Vg6_treat_WT3)))
col = data.frame("V1"= c("Vg6_naive_WT1", "Vg6_naive_WT2", "Vg6_naive_WT3", "Vg6_treat_WT1", "Vg6_treat_WT2", "Vg6_treat_WT3"))
#col = data.frame("V1"= c("Vg6_naive_WT2", "Vg6_naive_WT3", "Vg6_treat_WT2", "Vg6_treat_WT3"))
rownames(mat) = toupper(dfWT$Gene_Symbol)
colnames(mat) = col$V1
#Heatmap(mat, name = "mat", column_title = "VG6 WT Samples Naive v. Treated", column_names_gp = gpar(fontsize = 10), row_title = "Inflammasome Genes", row_names_gp = gpar(fontsize = 5.5), row_order = order(as.numeric(gsub("row", "", rownames(mat)))), column_order = order(as.numeric(gsub("column", "", colnames(mat)))))
Heatmap(mat, name = "mat", column_title = "VG6 WT Samples Naive v. Treated", column_names_gp = gpar(fontsize = 10), row_title = "Inflammasome Genes", row_names_gp = gpar(fontsize = 5.5))
