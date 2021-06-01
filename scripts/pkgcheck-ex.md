
git hash: (Not a git repository)

- &#9989; Package uses 'roxygen2'
- &#10060; Package does not have a 'contributing.md' file
- &#10060; Package does not have a 'CITATION' file
- &#10060; Package does not have a 'codemeta.json' file
- &#9989; All functions have examples
- &#10060; Package 'DESCRIPTION' does not have a URL field
- &#10060; Package 'DESCRIPTION' does not have a BugReports field
- &#9989; Package name is available
- &#9989; Package has continuous integration checks
- &#10060; Package coverage is 0% (should be at least 75%)
- &#9989; R CMD check found no errors
- &#9989; R CMD check found no warnings
- &#9989; This package still has TODO standards and can not be submitted

**Important:** All failing checks above must be addressed prior to proceeding

Package License: GPL-3

---

**1. srr**

This package is in the following category:

- *Regression and Supervised Learning*

&#9989; This package still has TODO standards and can not be submitted

[Click here to view output of 'srr_report'](https://ropenscilabs.github.io/roreviewapi/static/demo_srr77dfe392.html), which can be re-generated locally by running the [`srr_report() function](https://ropenscilabs.github.io/srr/reference/srr_report.html) from within a local clone of the repository.

---


**2. Statistical Properties**

This package features some noteworthy statistical properties which may need to be clarified by a handling editor prior to progressing.

<details>
<summary>Details of statistical properties (click to open)</summary>
<p>

The package has:

- code in R (35% in 5 files) and C++ (65% in 2 files)
- 1 authors
- no  vignette
- no internal data file
- 1 imported package
- no exported function
- 4 non-exported functions in R (median 3 lines of code)
- 3 C++ functions (median 4 lines of code)

---

Statistical properties of package structure as distributional percentiles in relation to all current CRAN packages
The following terminology is used:
- `loc` = "Lines of Code"
- `fn` = "function"
- `exp`/`not_exp` = exported / not exported

The final measure (`fn_call_network_size`) is the total number of calls between functions (in R), or more abstract relationships between code objects in other languages. Values are flagged as "noteworthy" when they lie in the upper or lower 5th percentile.

|measure              | value| percentile|noteworthy |
|:--------------------|-----:|----------:|:----------|
|files_R              |     5|       29.8|           |
|files_src            |     2|       77.4|           |
|files_vignettes      |     0|        0.0|TRUE       |
|files_tests          |     2|       64.1|           |
|loc_R                |    12|        0.5|TRUE       |
|loc_src              |    22|        0.3|TRUE       |
|loc_tests            |     6|        4.2|TRUE       |
|num_vignettes        |     0|        0.0|TRUE       |
|n_fns_r              |     4|        0.5|TRUE       |
|n_fns_r_exported     |     0|        0.0|TRUE       |
|n_fns_r_not_exported |     4|        2.6|TRUE       |
|n_fns_src            |     3|       77.0|           |
|n_fns_per_file_r     |     1|        0.0|TRUE       |
|n_fns_per_file_src   |     2|        6.7|           |
|num_params_per_fn    |     0|        0.0|TRUE       |
|loc_per_fn_r         |     3|        2.3|TRUE       |
|loc_per_fn_r_not_exp |     3|        4.0|TRUE       |
|loc_per_fn_src       |     4|        1.8|TRUE       |
|fn_call_network_size |     1|        0.3|TRUE       |

---
</p></details>


**2a. Network visualisation**

Interactive network visualisation of calls between objects in package can be viewed by [clicking here](https://ropenscilabs.github.io/roreviewapi/static/demo_pkgstats77dfe392.html)

---

**3. `goodpractice` and other checks**

<details>
<summary>Details of goodpractice and other checks (click to open)</summary>
<p>


---


**3b. `goodpractice` results**


**R CMD check**

R CMD check generated the following check_fails:

1. description_url
2. description_bugreports

**Test Coverage**

Package: 0

The following files are not completely covered by tests:

file | coverage
--- | ---
R/test.R | 0%
src/cpptest.cpp | 0%



</p>
</details>

---

<details>
<summary>Package Versions</summary>
<p>

|package  |version   |
|:--------|:---------|
|pkgstats |0.0.0.135 |
|pkgcheck |0.0.1.322 |
|srr      |0.0.1.75  |

</p>
</details>
