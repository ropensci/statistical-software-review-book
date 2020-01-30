
Sys.setenv ("CHROMOTE_CHROME" = "/usr/bin/google-chrome-stable")
bookdown::render_book ("index.Rmd")

yml <- readLines ("_bookdown.yml")
rmd_files <- strsplit (yml [grepl ("^rmd\\_files:\\s", yml)],
                       "rmd\\_files:\\s\\[") [[1]] [2]
rmd_files <- strsplit (gsub ("\"|]\\s+", "", rmd_files), "\\,\\s") [[1]]
output_dir <- strsplit (yml [grepl ("^output\\_dir:\\s", yml)],
                        ":\\s+") [[1]] [2]
# html file names are defined by the tags given in first header
tags <- vapply (rmd_files, function (i) {
                    x <- readLines (i)
                    hdr <- x [grep ("^\\#\\s+", x)]
                    hdr <- hdr [which (!grepl ("\\{\\-\\}", hdr))]
                    if (!any (grepl ("\\{", hdr)))
                        ret <- i
                    else
                        ret <- gsub ("\\}", "",
                                     strsplit (hdr, "\\{\\#") [[1]] [2])
                    return (ret)    }, character (1), USE.NAMES = FALSE)
index <- which (!(is.na (tags) | grepl ("\\.Rmd", tags)))
tags [index] <- paste0 (tags [index], ".Rmd")
tags [which (is.na (tags))] <- rmd_files [which (is.na (tags))]
#tags <- tags [tags != "index.Rmd"]
html_files <- file.path (".", output_dir, gsub ("\\.Rmd", "\\.html", tags))
for (h in html_files) {
    x <- readLines (h)
    index <- grep ("\"github\": false", x)
    x [index] <- gsub ("false", "true", x [index])
    con <- file (h, "w")
    writeLines (x, con)
    close (con)
}
