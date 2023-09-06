library(dplyr)
library(plotly)
library(tidyr)

# Load and process the data
file_path <- "/Users/arwa/Downloads/HKBCfiltered.csv"
data <- read.csv(file_path)

# Group the data by sample and create a list of unique genes for each sample
grouped <- data %>%
  group_by(sample) %>%
  summarise(unique_genes = list(unique(gene)))

# Count gene occurrences
gene_counts <- table(data$gene)

# Find gene pairs
gene_pair_counts <- list()

# ... (rest of the code to find common_gene_pairs)

# Count gene pairs
gene_pair_counts <- data.frame(GenePair = names(gene_pair_counts), Count = unlist(gene_pair_counts))

# ... (rest of the code to calculate gene_total_counts and gene_pair_counts)

# Create a data frame to store gene occurrence counts
gene_occurrence_counts <- data.frame(Gene = gene_names, PairCount = 0)

# ... (rest of the code to loop through common_gene_pairs and increment PairCount)

# Sort the gene occurrence counts in descending order
gene_occurrence_counts <- gene_occurrence_counts %>%
  arrange(desc(PairCount))

# Display the result
print(gene_occurrence_counts)

# ... (rest of the code to create fisher_p_value_matrix)

# Specify the output file path for the Fisher P-Value Matrix
output_file_path <- "/Users/arwa/Downloads/HKFisher_PValue_Matrix1.csv"
write.csv(fisher_p_value_matrix, file = output_file_path, row.names = TRUE)
