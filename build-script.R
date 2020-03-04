#!/usr/bin/env Rscript

source ("scripts/getZoteroNotes.R")
Sys.setenv("CHROMOTE_CHROME" = "/usr/bin/google-chrome-stable")
#bookdown::render_book ("index.Rmd", output_format = c ("html_document", "pdf_document"))
bookdown::render_book("index.Rmd")
