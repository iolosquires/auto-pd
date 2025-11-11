library(rawrr)
library(ini)

config <- read.ini("../config.ini")

args <- commandArgs(trailingOnly = TRUE)

if (length(args) < 1) {
  stop("Usage: Rscript process_raw.R <path/to/file.raw>")
}

rawfile <- args[1]
hdr <- readFileHeader(rawfile)

if (config$automatic_move_to_proteinchem == "1") {
  save_path <- "C:\\ProgramData\\Thermo\\Proteome Discoverer 2.4\\PublicFiles\\metadata.csv"
} else {
  save_path <- file.path(config$base_dir, "metadata.csv")
}

hdr_df <- as.data.frame(hdr) |>
  write.csv(save_path, row.names = FALSE)


cat(paste("Metadata for", rawfile, "saved to", save_path, "\n"))