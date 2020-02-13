#!/usr/bin/env Rscript

Sys.setenv ("CHROMOTE_CHROME" = "/usr/bin/google-chrome-stable")
bookdown::render_book ("index.Rmd")
