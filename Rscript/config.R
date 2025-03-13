#!/usr/bin/env Rscript
#################################################################
# Function: Configurate the R packages for Parallel-META
# Call: Rscript RM_Config.R
# Authors: Xiaoquan Su, Yuzhu Chen
# Updated at July 4, 2024
# Updated by [Your Name]
# Bioinformatics Group, College of Computer Science & Technology, Qingdao University
#################################################################

# Check if renv is installed
if (!requireNamespace("renv", quietly = TRUE)) {
  cat("renv is not installed. Installing renv...\n")
  install.packages("renv", repos = "http://cran.us.r-project.org/")
}

# Get the ParallelMETA directory
Env <- Sys.getenv("ParallelMETA")
if (nchar(Env) < 1) {
  cat('Please set the environment variable \"ParallelMETA\" to the directory\n')
  quit(status = 1)
}

# Activate renv environment
renv_activate_path <- file.path(Env, "renv/activate.R")
if (file.exists(renv_activate_path)) {
  source(renv_activate_path)
  cat("renv environment activated successfully.\n")
} else {
  cat("renv environment not found. Please run Rscript renv_setup.R first.\n")
  quit(status = 1)
}

# Load required packages
required_packages <- c(
  "optparse", "vegan", "gplots", "ggplot2", "grid", "igraph", 
  "reshape", "pheatmap", "pROC", "combinat", "plyr", "RColorBrewer",
  "grDevices", "permute", "lattice", "squash", "fossil", "abind",
  "randomForest", "psych", "ade4", "parallel", "reshape2"
)

# Check if all required packages are available
missing_packages <- required_packages[!sapply(required_packages, requireNamespace, quietly = TRUE)]
if (length(missing_packages) > 0) {
  cat("The following packages are missing from the renv environment:\n")
  cat(paste(missing_packages, collapse = ", "), "\n")
  cat("Please run Rscript renv_setup.R to install all required packages.\n")
  quit(status = 1)
}

cat("**R Packages Configuration Complete**\n")

