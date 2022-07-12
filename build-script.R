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
# bookdown::render_book("index.Rmd")
# bookdown::render_book("index.Rmd", output_format = c ("bookdown::gitbook", "bookdown::pdf_book"))
quarto::quarto_render ()
