#!/usr/bin/env Rscript
#################################################################
# Function: Initialize renv environment for Parallel-META
# Call: Rscript renv_setup.R
# Authors: [Your Name]
# Updated at: March 13, 2025
# Bioinformatics Group, College of Computer Science & Technology, Qingdao University
#################################################################

# Install renv if not already installed
if (!requireNamespace("renv", quietly = TRUE)) {
  install.packages("renv", repos = "http://cran.us.r-project.org/")
}

# Load renv
library(renv)

# Initialize renv
renv::init()

# Install all required packages
required_packages <- c(
  # Core packages
  "optparse", "vegan", "gplots", "ggplot2", "grid", "igraph", 
  "reshape", "pheatmap", "pROC", "combinat", "plyr", "RColorBrewer",
  "grDevices", "permute", "lattice", "squash", "fossil", "abind",
  "randomForest", "psych", "ade4", "parallel", "reshape2"
)

# Install packages
for (pkg in required_packages) {
  if (!requireNamespace(pkg, quietly = TRUE)) {
    renv::install(pkg)
  }
}

# Take a snapshot of the current environment
renv::snapshot()

cat("**renv environment setup complete**\n")
cat("All required R packages have been installed and locked to specific versions.\n")
cat("To activate this environment in your R scripts, add: source('renv/activate.R')\n")