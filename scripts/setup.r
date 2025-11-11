#!/usr/bin/env Rscript

# -----------------------------
# R setup script for dependencies
# -----------------------------

# Helper function
install_if_missing <- function(pkg, bioc = FALSE) {
  if (!requireNamespace(pkg, quietly = TRUE)) {
    message("Installing ", pkg, " ...")
    if (bioc) {
      if (!requireNamespace("BiocManager", quietly = TRUE))
        install.packages("BiocManager", repos = "https://cloud.r-project.org")
      BiocManager::install(pkg, ask = FALSE, update = FALSE)
    } else {
      install.packages(pkg, repos = "https://cloud.r-project.org")
    }
  } else {
    message(pkg, " already installed ✅")
  }
}

# Install CRAN packages
install_if_missing("ini")

# Install Bioconductor packages
install_if_missing("rawrr", bioc = TRUE)

message("✅ Setup complete! rawrr and ini are ready to use.")
