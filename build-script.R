#!/usr/bin/env Rscript

source("scripts/getZoteroNotes.R")
Sys.setenv("CHROMOTE_CHROME" = "/usr/bin/google-chrome-stable")
# bookdown::render_book("index.Rmd")
# bookdown::render_book("index.Rmd", output_format = c ("bookdown::gitbook", "bookdown::pdf_book"))
bookdown::render_book("index.Rmd", output_format = c("bookdown::gitbook"))
