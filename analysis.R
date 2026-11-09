
# TPM1 Muscle Contractility Project
# Step 1: Project setup

gene_symbol <- "TPM1"
transcript_accession <- "NM_001018005.2"
clinvar_id <- "12456"
variant_protein <- "p.Asp175Asn"

# Check the project folders
list.files()

install.packages(c("rentrez", "ggplot2"))

library(rentrez)
library(ggplot2)





# ==========================================
# STEP 1: Retrieve TPM1 gene information
# ==========================================

library(rentrez)

gene_symbol <- "TPM1"
transcript_accession <- "NM_001018005.2"
clinvar_id <- "12456"
variant_protein <- "p.Asp175Asn"

# Search NCBI Gene for human TPM1
gene_search <- entrez_search(
  db = "gene",
  term = paste0(gene_symbol, "[Gene Name] AND txid9606[Organism]"),
  retmax = 20
)

# Select the first matching Gene ID
gene_id <- gene_search$ids[1]

# Retrieve the NCBI Gene summary
gene_summary <- entrez_summary(
  db = "gene",
  id = gene_id
)

# Display important information
print(gene_id)
print(gene_summary$name)
print(gene_summary$description)
print(gene_summary$chromosome)
print(gene_summary$maplocation)

# Save gene information
gene_info <- c(
  paste("Gene symbol:", gene_symbol),
  paste("NCBI Gene ID:", gene_id),
  paste("Official name:", gene_summary$name),
  paste("Description:", gene_summary$description),
  paste("Chromosome:", gene_summary$chromosome),
  paste("Map location:", gene_summary$maplocation),
  paste("Transcript:", transcript_accession),
  paste("ClinVar Variation ID:", clinvar_id),
  paste("Protein variant:", variant_protein),
  "Source: NCBI Gene (https://www.ncbi.nlm.nih.gov/gene/)"
)

writeLines(gene_info, "results/gene_summary.txt")

cat("Gene information saved successfully!\n")
