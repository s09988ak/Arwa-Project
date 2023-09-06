# dndscv 

# install dndscv
library(devtools); install_github("im3sanger/dndscv")


library(dndscv)

nigerian_data="/Users/arwa/Downloads/nigerian_dndscv_input.csv"

data("dataset_simbreast", package="dndscv")
dndsout = dndscv(mutations)
dndsout_nocovariates = dndscv(mutations, cv=NULL)
print(dndsout$sel_cv[dndsout$sel_cv$qglobal_cv<0.1, c("gene_name","qglobal_cv")])
m=read.csv(hkbc_data)
print(dndsout_nocovariates$sel_cv[dndsout_nocovariates$sel_cv$qglobal_cv<0.1, c("gene_name","qglobal_cv")])

dndsout = dndscv(m)
sel_cv = dndsout$sel_cv 
print(sel_cv)
# Save sel_cv results to a CSV file
write.csv(sel_cv, file = "NIsel_cv_results.csv", row.names = FALSE)
# up until here

signif_genes = sel_cv[sel_cv$qglobal_cv<0.1, c("gene_name","qglobal_cv")]
rownames(signif_genes) = NULL
print(signif_genes)
print(dndsout$globaldnds)
print(dndsout$annotmuts)
print(dndsout$nbreg$theta)
signif_genes_localmodel = as.vector(dndsout$sel_loc$gene_name[dndsout$sel_loc$qall_loc<0.1])
print(signif_genes_localmodel)

