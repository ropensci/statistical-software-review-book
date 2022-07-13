#!/usr/bin/env Rscript

source("scripts/getZoteroNotes.R")
Sys.setenv("CHROMOTE_CHROME" = "/usr/bin/google-chrome-stable")

# Put version from DESC file in quarto `_vars` file:
d <- data.frame (read.dcf (file.path (here::here (),
                                      "DESCRIPTION")))
version <- d$Version
if (length (gregexpr ("\\.", version) [[1]]) > 2) {
    version <- gsub ("\\.\\d{3}$", "", version, perl = TRUE)
}     
writeLines (paste0 ("version: ", version), "_variables.yml")

quarto::quarto_render (cache = TRUE)
