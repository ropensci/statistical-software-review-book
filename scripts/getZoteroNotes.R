# Script to auto-compile the annotated bibliography from all entires in the
# zotero library which have "Note" entries. This enables any entry to be added
# to the annotated bibliography by simply adding some non-empty Note.

# Start by extracting all zotero entries with notes:
f <- "bibnotes.txt"
if (!file.exists (f)) { # rm file to update contents
    u <- paste0 ("https://api.zotero.org/groups/2416765/items")
    .params <- list (limit = 100)
    x <- httr::GET (u, query = .params)
    res <- httr::content (x, as = "text", encoding = "UTF-8")
    con <- file (f)
    writeLines (res, con = con)
    close (con)
}

# Read the full JSON data for all entries plus notes, noting that the latter are
# not kept as part of the main entry, rather in separate JSON entries with a
# corresponding "parentItem".
dat <- jsonlite::read_json (f)
names (dat) <- vapply (dat, function (i) i$data$key, character (1))
# index of items with "parentItem"
index <- which (vapply (dat, function (i)
                        "parentItem" %in% names (i$data),
                        logical (1)))

# function to convert zotero list items delineated with <ui><li>-type tags to
# markdown format
convert_list_items <- function (x) {
    # convert any list items
    x <- gsub ("<ul>\n<li>", "- ", x)
    x <- gsub ("<li>", "  - ", x)
    x <- gsub ("</li>|</ul>", "", x)
    x <- strsplit (gsub ("<.*?>", "\n", x), "\\n") [[1]]
    # remove any blank lines between list items.
    i1 <- grep ("^[[:space:]]+\\-", x) # list items
    if (length (i1) > 0) {
        # index of empty lines
        i2 <- which (nchar (x) == 0)
        i2 <- i2 [i2 >= min (i1) & i2 <= max (i1)]
        # get sequences of all i1 between list items
        i1 <- split (seq (x), findInterval (seq (x), i1))
        i1 <- unlist (unname (lapply (i1, function (i) i [-1])))
        # empty lines which lie between list items
        i2 <- i2 [which (i2 %in% i1)]
        x <- x [!seq (x) %in% i2]
    }
    return (x)
}

# The notes are formatted with lots of html tags. These must all be removed,
# and then the strings all split at line breaks.
notes <- lapply (index, function (i) {
                     res <- convert_list_items (dat [[i]]$data$note)

                     res <- lapply (res, function (j) strsplit (j, "\\n") [[1]])
                     nc <- unlist (lapply (res, length))
                     res [which (nc == 0)] <- ""
                     unlist (res)   })

keys <- vapply (index, function (i) dat [[i]]$data$parentItem, character (1))
names (notes) <- keys
index <- match (names (notes), names (dat))

itemTypes <- vapply (index, function (i) dat [[i]]$data$itemType, character (1))
titles <- vapply (index, function (i) dat [[i]]$data$title, character (1))
pubTitles <- vapply (index, function (i) {
                         pt <- dat [[i]]$data$publicationTitle
                         ifelse (length (pt) == 0, "", pt) }, character (1))
volumes <- vapply (index, function (i) {
                       vol <- dat [[i]]$data$volume
                       ifelse (length (vol) == 0, "", vol)}, character (1))
issues <- vapply (index, function (i) {
                      issue <- dat [[i]]$data$issue
                      ifelse (length (issue) == 0, "", issue) }, character (1))
pages <- vapply (index, function (i) {
                      p <- dat [[i]]$data$pages
                      ifelse (length (p) == 0, "", p) }, character (1))
creators <- vapply (index, function (i) {
                        cr <- dat [[i]]$data$creators
                        first <- vapply (cr, function (i) i$firstName,
                                         character (1))
                        last <- vapply (cr, function (i) i$lastName,
                                        character (1))
                        if (length (first) == 1 & first [1] == "")
                            cr <- last
                        else if (length (last) == 1 & last [1] == "")
                            cr <- first
                        else
                            cr <- paste0 (last, ", ", first)
                        if (length (cr) > 1)
                            cr <- paste0 (paste0 (cr [-length (cr)],
                                              collapse = "; "),
                                          "; and ", cr [length (cr)])
                        return (cr)
            }, character (1))
abstracts <- vapply (index, function (i) dat [[i]]$data$abstractNote, character (1))
dates <- vapply (index, function (i) dat [[i]]$data$date, character (1))
urls <- vapply (index, function (i) dat [[i]]$data$url, character (1))

# Then dump those notes to a single `.md` file:
out <- c ("---",
          "title: 'Annotated Bibliography for Statistical Software'",
          "output:",
          "    html_document:",
          "        toc: yes",
          "        toc_float: yes",
          "        number_sections: yes",
          "        theme: flatly",
          "---",
          "",
          "# Bibliography",
          "", "")
for (i in seq (notes)) {
    linkline <- paste (creators [i], " (", dates [i], ") ",
                       pubTitles [i])
    if (volumes [i] != "") {
        lineline <- paste0 (linkline, " **", volumes [i])
        if (issues [i] != "")
            linkline <- paste0 (linkline, " (", issues [i], ")")
        linkline <- paste0 (linkline, ": ", pages [i])
    }
    out <- c (out, paste0 ("## ", paste0 (titles [i], collapse = " ")),
              "",
              paste0 ("[", linkline, "](", urls [i], ")"),
              "",
              paste0 ("**Abstract** ", abstracts [i]),
              "")
    if (!is.null (notes [[i]]))
        out <- c (out, "**NOTES**", notes [[i]], "")
}
con <- file ("out.md", "w")
writeLines (out, con = con)
close (con)

# That `.md` file can then be manually copy-pasted into `reading.Rmd`, enabling
# any manual tidying, removing, changing of entries.

# The following lines convert the output to viewable html:
#rmarkdown::render ("out.md", output_file = "out.html")
#system2 ("xdg-open", c ("out.html", "&"))

