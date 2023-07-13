library(readxl)
library(stringr)
library(data.table)
library(janitor)
library(devtools)
library(ComplexHeatmap)

df1=read_excel('/Users/leejorj/Downloads/IL1aPathway.xlsx')
a=df1[,1]
df2 = read.table('/Users/leejorj/Downloads/RawCountFile_rsemgenes.txt',sep='\t')
df2 %>%
  row_to_names(row_number = 1)
df3 <- data.frame(matrix(ncol = 12, nrow = 0))
list <- as.data.frame(t(a))
for (gene in list) {
  geneTitle <- str_to_title(gene)
  if (nrow(df2[df2$V1 %like% geneTitle, ]) == 0) {
    next
  }
  df3[nrow(df3) + 1,] <- (df2[df2$V1 %like% geneTitle, ])
}
rownames(df3) <- NULL
colnames(df3) <- df2[1, ]
dfWT = subset(df3, select = c(gene_id, D6, B06, C06, D9, A12, D12))
dfWT$gene_id <- gsub('.*_','',dfWT$gene_id)
#mat = data.matrix(subset(dfWT, select = c(D6, B06, C06, D9, A12, D12)))
mat = data.matrix(subset(dfWT, select = c(B06, C06, A12, D12)))
#col = data.frame("V1"= c("Vg6_naive_WT1", "Vg6_naive_WT2", "Vg6_naive_WT3", "Vg6_treat_WT1", "Vg6_treat_WT2", "Vg6_treat_WT3"))
col = data.frame("V1"= c("Vg6_naive_WT2", "Vg6_naive_WT3", "Vg6_treat_WT2", "Vg6_treat_WT3"))
rownames(mat) = toupper(dfWT$gene_id)
colnames(mat) = col$V1
#Heatmap(mat, name = "mat", column_title = "VG6 WT Samples Naive v. Treated", column_names_gp = gpar(fontsize = 12), row_title = "IL1aPathway", row_names_gp = gpar(fontsize = 10), row_order = order(as.numeric(gsub("row", "", rownames(mat)))), column_order = order(as.numeric(gsub("column", "", colnames(mat)))))
Heatmap(mat, name = "mat", column_title = "VG6 WT Samples Naive v. Treated", column_names_gp = gpar(fontsize = 12), row_title = "IL1aPathway", row_names_gp = gpar(fontsize = 10))
