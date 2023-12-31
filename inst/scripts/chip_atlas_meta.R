#!/usr/bin/env R
# ChIP-Atlas metadata
library(xcore)
load("chip_atlas_promoters_f5.rda")

# Studies ids fix
srx2srastudy <- data.table::fread("../extdata/srx2study.csv")

chip_atlas_id <- colnames(chip_atlas_promoters_f5)

chip_atlas_meta <- chip_atlas_id %>%
  stringr::str_split(pattern = "\\.", n = 3) %>%
  do.call(what = rbind) %>%
  data.table::as.data.table()
colnames(chip_atlas_meta) <- c("tf", "biotype", "id")

# fix study ids
chip_atlas_meta$study <-
  srx2srastudy[match(chip_atlas_meta$id, srx2srastudy$Experiment), ]$SRAStudy
chip_atlas_meta$study <-
  ifelse(is.na(chip_atlas_meta$study),
         chip_atlas_meta$id,
         chip_atlas_meta$study)

# restore id
chip_atlas_meta$id <- chip_atlas_id

# CIS-BP TF classification
cis_bp <- data.table::fread("cis_bp_tf_class.txt")
cis_bp <-
  cis_bp[, .(tf_dbd = unique(DBDs)),
         by = TF_Name]
data.table::setnames(cis_bp, "TF_Name", "tf")
chip_atlas_meta <- cis_bp[chip_atlas_meta, on = c("tf" = "tf")]

data.table::setcolorder(chip_atlas_meta, c("id", "tf", "tf_dbd", "biotype", "study"))
save(chip_atlas_meta, file = "chip_atlas_meta.rda")
