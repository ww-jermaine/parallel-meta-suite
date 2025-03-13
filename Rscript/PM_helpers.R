#!/usr/bin/env Rscript
#################################################################
# Function:  Helper functions for consistent plotting
# Call: Source from other scripts
# R packages used: ggplot2
# Updated at March 13, 2025
# Bioinformatics Group, College of Computer Science & Technology, Qingdao University
#################################################################

# Helper function for consistent ggplot2 themes
pm_theme <- function() {
  theme_bw() +
  theme(
    axis.text.x = element_text(size=14, colour="black"),
    axis.text.y = element_text(size=14, colour="black"),
    axis.title.x = element_text(size=18),
    axis.title.y = element_text(size=18),
    panel.border = element_rect(fill=NA, linewidth=0.5),
    panel.grid.minor = element_blank(),
    panel.background = element_blank(),
    legend.key = element_rect(fill="white"),
    legend.text = element_text(size=14, color="black"),
    legend.key.size = unit(0.8,"cm"),
    legend.title = element_text(size = 16),
    plot.margin = unit(rep(1.5,4),'lines')
  )
} 