
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





system2("C:/Program Files/Git/bin/git.exe",
        c("-C", shQuote(getwd()), "add", "analysis.R", "results/gene_summary.txt"))

system2("C:/Program Files/Git/bin/git.exe",
        c("-C", shQuote(getwd()), "commit", "-m",
          shQuote("Add TPM1 gene summary")))

system2("C:/Program Files/Git/bin/git.exe",
        c("-C", shQuote(getwd()), "push"))






# ==========================================
# STEP 2: Retrieve TPM1 protein accession
# ==========================================

# Fetch the assigned transcript's GenBank record
transcript_record <- entrez_fetch(
  db = "nuccore",
  id = transcript_accession,
  rettype = "gb",
  retmode = "text"
)

# Extract the NP_ protein accession
protein_accession <- regmatches(
  transcript_record,
  regexpr("NP_[0-9]+\\.[0-9]+", transcript_record)
)

# Display the accession
print(protein_accession)

# Fetch the protein FASTA sequence
protein_fasta <- entrez_fetch(
  db = "protein",
  id = protein_accession,
  rettype = "fasta",
  retmode = "text"
)

# Save protein FASTA
writeLines(
  protein_fasta,
  "data/TPM1_protein.fasta"
)

# Save accession information
accession_info <- c(
  paste("Gene:", gene_symbol),
  paste("Assigned transcript:", transcript_accession),
  paste("Matching protein accession:", protein_accession),
  paste("ClinVar Variation ID:", clinvar_id),
  "Source: NCBI Nucleotide and Protein"
)

writeLines(
  accession_info,
  "results/protein_accession.txt"
)

cat("Protein accession and FASTA saved successfully!\n")




system2("C:/Program Files/Git/bin/git.exe",
        c("-C", shQuote(getwd()), "add",
          "analysis.R",
          "data/TPM1_protein.fasta",
          "results/protein_accession.txt"))


system2("C:/Program Files/Git/bin/git.exe",
        c("-C", shQuote(getwd()), "commit", "-m",
          shQuote("Retrieve TPM1 protein accession and FASTA")))



system2("C:/Program Files/Git/bin/git.exe",
        c("-C", shQuote(getwd()), "push"))








# Step 4: Amino acid composition

# Read the TPM1 protein FASTA file
fasta_lines <- readLines("data/TPM1_protein.fasta")

# Remove the FASTA header and combine sequence lines
protein_sequence <- paste(
  fasta_lines[!grepl("^>", fasta_lines)],
  collapse = ""
)

# Count amino acids
amino_acids <- c(
  "A", "R", "N", "D", "C", "Q", "E", "G", "H", "I",
  "L", "K", "M", "F", "P", "S", "T", "W", "Y", "V"
)

aa_counts <- sapply(amino_acids, function(aa) {
  lengths(regmatches(protein_sequence, gregexpr(aa, protein_sequence)))
})

# Create composition table
aa_composition <- data.frame(
  Amino_Acid = amino_acids,
  Count = as.numeric(aa_counts)
)

aa_composition$Percentage <- 
  aa_composition$Count / nchar(protein_sequence) * 100

# Save the table
write.csv(
  aa_composition,
  "results/amino_acid_composition.csv",
  row.names = FALSE
)

# Print protein length and most abundant amino acids
cat("Protein length:", nchar(protein_sequence), "amino acids\n")

print(
  aa_composition[order(-aa_composition$Count), ][1:3, ]
)

# Create bar plot
aa_plot <- ggplot(aa_composition,
                  aes(x = Amino_Acid, y = Count)) +
  geom_col() +
  labs(
    title = "Amino Acid Composition of TPM1",
    x = "Amino Acid",
    y = "Count"
  ) +
  theme_minimal()

# Save plot
ggsave(
  "figures/01_amino_acid_composition.png",
  plot = aa_plot,
  width = 10,
  height = 6
)

cat("Amino acid composition and plot saved successfully!\n")

