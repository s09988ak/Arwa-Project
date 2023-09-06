setwd("/mnt/bmh01-rds/UoOxford_David_W/Arwa")

# Cohort-specific information
cohort.name = "HONGKONG"
SNV.folder = "/mnt/bmh01-rds/UoOxford_David_W/Arwa/SNV_Calls/Annotated_HKBC"
file_extension = ".vcf.gz"

# List VCF files in the SNV folder
vcf.files = list.files(path = SNV.folder, pattern = paste0("*", file_extension))

# Read the list of driver genes
driver.genes = read.table("driver_list.txt", header = FALSE)[, 1]

# Initialize results table
results.table = setNames(data.frame(matrix(ncol = 5, nrow = 0)),
                         c("sample", "chromosome", "position", "gene", "variant_type"))

# Process each VCF file
for (vcf.file in vcf.files) {
  vcf.data = read.table(gzfile(file.path(SNV.folder, vcf.file)))
  
  samplename = gsub(file_extension, "", vcf.file)
  
  for (driver in driver.genes) {
    gene.rows = sapply(1:nrow(vcf.data), function(i) {
      match = grep(driver, vcf.data[i, 8])
      ifelse(length(match) > 0, paste(samplename, vcf.data[i, 1], vcf.data[i, 2], driver,
                                      strsplit(vcf.data[i, 8], "\\|")[[1]][2], sep = ","), c(",", ","))
    })
    
    non.empty.rows = which(gene.rows != ",,")
    
    if (length(non.empty.rows) > 0) {
      for (r in non.empty.rows) {
        results.table = rbind(results.table, strsplit(gene.rows[r], ",")[[1]])
      }
    }
  }
}

# Assign column names to the results table
names(results.table) = c("sample", "chromosome", "position", "gene", "variant_type")

# Write results table to a CSV file
write.csv(results.table, paste0(cohort.name, "_drivers.csv"), row.names = FALSE, quote = FALSE)
