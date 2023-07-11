# ComplexHeatMap
This repository was made to document the creation of heat maps based off of an inflammasome gene set and 6 samples extracted from VG6 WT Naive and Treatment groups. Other gene pathways were also used. All code was run through RStudio.

Base website: https://bioconductor.org/packages/release/bioc/html/ComplexHeatmap.html
Full documentation: https://jokergoo.github.io/ComplexHeatmap-reference/book/index.html

Run in console to install ComplexHeatMap library: 
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("ComplexHeatmap")

For comments, please refer to HeatMapProjRawData. All files have near identical code but were used for different data sets.
