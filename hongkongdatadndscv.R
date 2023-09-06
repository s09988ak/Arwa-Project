# dndscv 
# install dndscv
library(devtools); install_github("im3sanger/dndscv")
library("dndscv")
library(dndscv)

load("/Users/arwa/Downloads/covariates_hg19_hg38_epigenome_pcawg.rda") # Loads the covs object
load("/Users/arwa/Downloads/RefCDS_human_GRCh38_GencodeV18_recommended.rda")
refDB="/User/arwa/Desktop/RefCDS_human_GRCh38_GencodeV18_recommended.rda"
hk_data="/Users/arwa/Downloads/hkbc_dndscv_input.csv"

mutations=read.csv(hk_data)
dndsout = dndscv(mutations, refdb = RefCDS, cv = covs)
sel_cv = dndsout$sel_cv
write.csv(sel_cv, "")

signif_genes = sel_cv[sel_cv$qglobal_cv<0.1, c("gene_name","qglobal_cv")]
rownames(signif_genes) = NULL
print(signif_genes)
print(dndsout$globaldnds)
print(dndsout$annotmuts)
print(dndsout$nbreg$theta)
signif_genes_localmodel = as.vector(dndsout$sel_loc$gene_name[dndsout$sel_loc$qall_loc<0.1])
print(signif_genes_localmodel)

