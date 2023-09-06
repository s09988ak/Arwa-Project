setwd("/mnt/bmh01-rds/UoOxford_David_W/Arwa")

#the next 3 lines will need to be changed for each cohort
cohort.name = "TCGA"
SNV.folder = "/mnt/bmh01-rds/UoOxford_David_W/Arwa/SNV_Calls/TCGA_BRCA"
postscript = "-09.annot.muts.vcf.gz"

vcf.files = list.files(path=SNV.folder,pattern = "*.vcf.gz")
driver.genes = read.table("driver_list.txt",header=F)[,1]
results.table = setNames(data.frame(matrix(ncol = 5, nrow = 0)), c("sample","chromosome","position","gene", "variant_type"))
for(vcf.file in vcf.files){
  vcf.data = read.table(gzfile(paste0(SNV.folder,"/",vcf.file)))
  
  samplename = gsub(postscript,"",vcf.file)
  for(driver in driver.genes){
    gene.rows = sapply(1:nrow(vcf.data),function(i){match=grep(driver,vcf.data[i,8]);ifelse(length(match)>0,paste(samplename,vcf.data[i,1],vcf.data[i,2],driver,strsplit(vcf.data[i,8],"\\|")[[1]][2],sep=","),c(",,"))})
    non.empty.rows = which(gene.rows!=",,")
    if(length(non.empty.rows)>0){
      for(r in non.empty.rows){
        results.table = rbind(results.table,strsplit(gene.rows[r],",")[[1]])
      }
    }
  }
}
names(results.table) = c("sample", "chromosome", "position", "gene", "variant_type")
write.csv(results.table,paste0(cohort.name,"_drivers.csv"),row.names = F,quote = F)
