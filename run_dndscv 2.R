# dndscv 

# install dndscv
library(devtools); install_github("im3sanger/dndscv")


library(dndscv)

nigerian_data="/Users/arwa/Downloads/nigerian_dndscv_input.csv"

m=read.csv(nigerian_data)

dndsout = dndscv(m)
sel_cv = dndsout$sel_cv 
print(sel_cv) # up until here

signif_genes = sel_cv[sel_cv$qglobal_cv<0.1, c("gene_name","qglobal_cv")]
rownames(signif_genes) = NULL
print(signif_genes)
print(dndsout$globaldnds)
print(dndsout$annotmuts)
print(dndsout$nbreg$theta)
signif_genes_localmodel = as.vector(dndsout$sel_loc$gene_name[dndsout$sel_loc$qall_loc<0.1])
print(signif_genes_localmodel)
