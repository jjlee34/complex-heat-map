library(readxl)
library(stringr)
library(data.table)
library(janitor)
library(devtools)
library(ComplexHeatmap)
library(circlize)

df1=read_excel('/Users/leejorj/Downloads/IL-18Pathway.xlsx')
a=df1[,1]
df2 = read_excel('/Users/leejorj/Downloads/deseq_normalized_counts.xlsx')
df3 <- data.frame(matrix(ncol = 7, nrow = 0))
list <- as.data.frame(t(a))
for (gene in list) {
  geneTitle <- str_to_title(gene)
  if (nrow(df2[df2$gene_id %like% geneTitle, ]) == 0) {
    next
  }
  df3[nrow(df3) + 1,] <- (df2[df2$gene_id %like% geneTitle, ])
}
dfWT = subset(df3, select = c(X1, X2, X3, X4, X5, X6, X7))
#mat = data.matrix(subset(dfWT, select = c(X2, X3, X4, X5, X6, X7)))
mat = data.matrix(subset(dfWT, select = c(X3, X4, X5, X7)))
rownames(mat) = toupper(dfWT$X1)
scaledmat = t(apply(mat, 1, scale))
scaledmat = na.omit(scaledmat)
#scaledmat[is.nan(scaledmat)] = 0
#col = data.frame("V1"= c("Vg6_naive_WT1", "Vg6_naive_WT2", "Vg6_naive_WT3", "Vg6_treat_WT1", "Vg6_treat_WT2", "Vg6_treat_WT3"))
col = data.frame("V1"= c("Vg6_naive_WT2", "Vg6_naive_WT3", "Vg6_treat_WT1", "Vg6_treat_WT3"))
colnames(scaledmat) = col$V1
#Heatmap(scaledmat, name = "Normalized Count", column_title = "VG6 WT Samples Naive v. Treated", column_names_gp = gpar(fontsize = 6), row_title = "IL-18 Pathway Genes", row_names_gp = gpar(fontsize = 4), row_order = order(as.numeric(gsub("row", "", rownames(scaledmat)))), column_order = order(as.numeric(gsub("column", "", colnames(scaledmat)))))
Heatmap(scaledmat, name = "Normalized Count", column_title = "VG6 WT Samples Naive v. Treated", column_names_gp = gpar(fontsize = 6), row_title = "1L-18 Pathway Genes", row_names_gp = gpar(fontsize = 4))

