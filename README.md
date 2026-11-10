# Protein Structure and Mutation Analysis: TPM1

## Project Overview

This project analyzes the human **TPM1 (tropomyosin 1)** gene, focusing on the missense variant **p.Asp175Asn** and its potential effects on muscle contractility.

The analysis uses NCBI and ClinVar data, R programming, and visualizations to examine the protein sequence, amino acid composition, and location of the assigned variant.

## Gene and Variant Information

| Description | Information |
|---|---|
| Gene symbol | TPM1 |
| NCBI Gene ID | 7168 |
| Gene description | Tropomyosin 1 |
| Chromosome | 15 |
| Cytogenetic location | 15q22.2 |
| Assigned transcript | NM_001018005.2 |
| Protein accession | NP_001018005.1 |
| Coding variant | c.523G>A |
| Protein variant | p.Asp175Asn |
| ClinVar Variation ID | 12456 |
| Variant type | Missense |

## Project Files

### Data
- `data/TPM1_protein.fasta` – TPM1 protein sequence retrieved from NCBI.

### Results
- `results/gene_summary.txt` – Gene information from NCBI.
- `results/protein_accession.txt` – Assigned transcript and matching protein accession.
- `results/amino_acid_composition.csv` – Amino acid counts and percentages.
- `results/clinvar_variant_notes.txt` – Information about the assigned ClinVar variant.
- `results/discussion.txt` – Biological discussion of TPM1 and the variant.

### Figures
- `figures/01_amino_acid_composition.png` – Bar graph of TPM1 amino acid composition.
- `figures/02_variant_position.png` – Protein map showing the variant at amino acid position 175.

## Analysis Summary

The retrieved TPM1 protein sequence contains 284 amino acids. The three most abundant amino acids in the analyzed sequence are:

- Glutamic acid (E): 56 residues (19.72%)
- Lysine (K): 38 residues (13.38%)
- Alanine (A): 36 residues (12.68%)

The protein map identifies the assigned missense variant at amino acid position 175.

## Tools and Resources

- R and RStudio
- rentrez
- ggplot2
- NCBI Gene and Protein databases
- ClinVar

## References

- NCBI Gene: https://www.ncbi.nlm.nih.gov/gene/7168
- NCBI Protein: https://www.ncbi.nlm.nih.gov/protein/NP_001018005.1
- ClinVar: https://www.ncbi.nlm.nih.gov/clinvar/variation/12456/

