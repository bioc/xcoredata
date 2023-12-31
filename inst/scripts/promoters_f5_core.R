#!/usr/bin/env R
# FANTOM5 core promoters
library(xcore)
load("promoters_f5.rda")

dpi2symbol <- promoters_f5 %>%
  S4Vectors::mcols() %>%
  as.data.frame() %>%
  dplyr::filter(! (is.na(SYMBOL) | SYMBOL == "")) %>%
  dplyr::group_by(SYMBOL) %>%
  dplyr::slice(which.max(score)) %>%
  with(., setNames(SYMBOL, name))

# GENCODE confirmation
promoters_f5_core <- 
  promoters_f5[promoters_f5$gene_type_gencode == "protein_coding", ]

# ENCODE ROADMAP confirmation
roadmap_promoters <- rtracklayer::import.bed(con = "Epigenome5DRoadmapDHS_promoter_hg38_liftOver.bed")
GenomeInfoDb::seqlevels(roadmap_promoters, pruning.mode = "coarse") <-
  GenomeInfoDb::seqlevels(promoters_f5_core)
promoters_f5_core <- IRanges::subsetByOverlaps(x = promoters_f5_core, ranges = roadmap_promoters)


# Best promoter per gene based on FANTOM5 score
best_promoters <- GenomicRanges::mcols(promoters_f5_core) %>%
  as.data.frame() %>%
  dplyr::group_by(SYMBOL) %>%
  dplyr::slice(which.max(score)) %>%
  dplyr::pull(name)
promoters_f5_core <-
  promoters_f5_core[promoters_f5_core$name %in% best_promoters, ]

save(promoters_f5_core, file = "promoters_f5_core.rda")
