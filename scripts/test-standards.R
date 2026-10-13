#!/usr/bin/env Rscript
library(cli)

# Regex patterns for standard detection and validation
CANDIDATE_PATTERN <- "^\\s*- .*\\*\\*([A-Z]{1,2}\\d{1,2}\\.\\d{1,2}[a-z]?)\\*\\*"
MAIN_STANDARD_PATTERN <- "^- \\[\\*\\*([A-Z]{1,2}\\d{1,2}\\.\\d{1,2})\\*\\*\\]\\{#([A-Z]{1,2}\\d{1,2}_\\d{1,2})\\}"
SUB_STANDARD_PATTERN <- "^\\s+- \\[\\*\\*([A-Z]{1,2}\\d{1,2}\\.\\d{1,2}[a-z])\\*\\*\\]\\{#([A-Z]{1,2}\\d{1,2}_\\d{1,2}[a-z])\\}"
CODE_EXTRACTION_PATTERN <- "\\*\\*([A-Z]{1,2}\\d{1,2}\\.\\d{1,2}[a-z]?)\\*\\*"

#' Find all standard definition files
#'
#' @return Character vector of file paths to .Rmd files in standards/
find_standard_files <- function() {
  files <- list.files("standards", pattern = "\\.Rmd$", full.names = TRUE)
  if (length(files) == 0) {
    cli_alert_danger("No .Rmd files found in standards/ directory")
    quit(status = 1)
  }
  files
}

#' Extract standard code from a line
#'
#' @param line Character string to search for standard code
#' @return Character string of the extracted code (with **), or "" if not found
extract_standard_code <- function(line) {
  code_match <- regexpr(CODE_EXTRACTION_PATTERN, line)
  if (code_match > 0) {
    regmatches(line, code_match)
  } else {
    ""
  }
}

#' Check if a standard code is a sub-standard (has letter suffix)
#'
#' @param code_clean Character string of standard code without ** markers
#' @return Logical TRUE if code ends with lowercase letter
is_sub_standard <- function(code_clean) {
  grepl("[a-z]$", code_clean)
}

#' Validate standard format and return any issues
#'
#' @param line Character string to validate
#' @param file Character string of file path
#' @param line_num Numeric line number
#' @param code Character string of extracted code (with **)
#' @param is_sub Logical indicating if this is a sub-standard
#' @return List with issue details if validation fails, NULL if passes
validate_standard_format <- function(line, file, line_num, code, is_sub) {
  correct_pattern <- if (is_sub) SUB_STANDARD_PATTERN else MAIN_STANDARD_PATTERN

  if (!grepl(correct_pattern, line)) {
    return(list(
      file = file,
      line_num = line_num,
      type = "format_mismatch",
      code = code,
      is_sub = is_sub,
      content = line
    ))
  }

  # Validate anchor ID matches code
  match_res <- regmatches(line, regexec(correct_pattern, line))[[1]]
  if (length(match_res) > 0) {
    code_part <- match_res[2]
    anchor_part <- match_res[3]
    expected_anchor <- sub("\\.", "_", code_part)

    if (anchor_part != expected_anchor) {
      return(list(
        file = file,
        line_num = line_num,
        type = "anchor_mismatch",
        code = code_part,
        expected_anchor = expected_anchor,
        found_anchor = anchor_part,
        content = line
      ))
    }
  }

  NULL
}

#' Run validation on all standard files
#'
#' @return List of issues found during validation
run_validation <- function() {
  files <- find_standard_files()
  issues <- list()

  for (file in files) {
    lines <- readLines(file, warn = FALSE)

    for (i in seq_along(lines)) {
      line <- lines[i]

      if (!grepl(CANDIDATE_PATTERN, line)) {
        next
      }

      code <- extract_standard_code(line)
      code_clean <- gsub("\\*\\*", "", code)
      is_sub <- is_sub_standard(code_clean)

      issue <- validate_standard_format(line, file, i, code, is_sub)
      if (!is.null(issue)) {
        issues[[length(issues) + 1]] <- issue
      }
    }
  }

  issues
}

#' Report validation results
#'
#' @param issues List of issues found during validation
report_results <- function(issues) {
  if (length(issues) == 0) {
    cli_alert_success("All standards conform to expected format!")
    quit(status = 0)
  }

  cli_h1("Standards Format Validation Report")
  cli_alert_danger("Found {length(issues)} issue{?s}")
  cli_ul()

  for (issue in issues) {
    file_rel <- sub("^standards/", "", issue$file)
    line_info <- sprintf("%s:%d", file_rel, issue$line_num)

    if (issue$type == "format_mismatch") {
      if (issue$is_sub) {
        cli_alert_warning("{line_info} - Sub-standard format mismatch")
        cli_text("Expected: [spaces] - [**XX#.##[a-z]**]{#XX#_##[a-z]}")
      } else {
        cli_alert_warning("{line_info} - Main standard format mismatch")
        cli_text("Expected: - [**XX#.##**]{#XX#_##} (no leading whitespace)")
      }
      cli_text("Found code: {issue$code}")
      cli_code(substr(issue$content, 1, 70))
    } else if (issue$type == "anchor_mismatch") {
      cli_alert_warning("{line_info} - Anchor ID does not match code")
      cli_text("Code: {issue$code}")
      cli_text("Expected anchor: {issue$expected_anchor}")
      cli_text("Found anchor: {issue$found_anchor}")
    }
    cli_text("")
  }

  cli_end()
  quit(status = 1)
}

# Main execution
issues <- run_validation()
report_results(issues)
