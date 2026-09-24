# 6  Standards: Version 0.2.0

This Chapter serves as the reference for rOpenSci’s standards for statistical software. Software accepted for peer-review must fit one or more of our categories, and thus all packages must comply with the *General Standards* listed in the first of the following sections, as well as at least one of the category-specific sets of standards listed in the subsequent sections.

Our standards are open and intended to change and evolve in response to public feedback. Please contribute via the [GitHub discussions pages for this book](https://github.com/ropensci/statistical-software-review-book/discussions). We particularly encourage anybody preparing software for submission to discuss any aspects of our standards, including applicability, validity, phrasing, expectations, reasons for standards, and even the addition or removal of specific standards.

------------------------------------------------------------------------

## 6.1 General Standards for Statistical Software

These general standards, and all category-specific standards that follow, are intended to serve as *recommendations* for best practices. Note in particular that many standards are written using the word “*should*” in explicit acknowledgement that adhering to such standards may not always be possible. All standards phrased in these terms are intended to be interpreted as applicable under such conditions as “*Where possible*”, or “*Where applicable*”. Developers are requested to note any standards which they deem not applicable to their software via the [`srr` package](https://ropensci-review-tools.github.io/srr/), as described in [Chapter 3](#pkgdev).

These standards refer to **Data Types** as the fundamental types defined by the [R language](https://cran.r-project.org/doc/manuals/R-lang.html) itself. Information on these types can be seen by clicking here.

The [R language](https://cran.r-project.org/doc/manuals/R-lang.html) defines the following data types:

- Logical
- Integer
- Continuous (`class = "numeric"` / `typeof = "double"`)
- Complex
- String / character

The base R system also includes what are considered here to be direct extensions of fundamental types to include:

- Factor
- Ordered Factor
- Date/Time

The continuous type has a `typeof` of “double” because that represents the storage mode in the C representation of such objects, while the `class` as defined within R is referred to as “numeric”. While `typeof` is not the same as `class`, with reference to continuous variables, “numeric” may be considered identical to “double” throughout.

The term “character” is interpreted here to refer to a vector each element of which is an individual “character” object. The term “string” does not relate to any official R nomenclature, but is used here to refer for convenience to a character vector of length one; in other words, a “string” is the sole element of a single-length “character” vector.

------------------------------------------------------------------------

\

### 6.1.1 Documentation

- **G1.0** *Statistical Software should list at least one primary reference from published academic literature.*

We consider that statistical software submitted under our system will either (i) implement or extend prior methods, in which case the *primary reference* will be to the most relevant published version(s) of prior methods; or (ii) be an implementation of some new method. In the second case, it will be expected that the software will eventually form the basis of an academic publication. Until that time, the most suitable reference for equivalent algorithms or implementations should be provided.

- **G1.1** *Statistical Software should document whether the algorithm(s) it implements are:*
  - *The first implementation of a novel algorithm*; or
  - *The first implementation within **R** of an algorithm which has previously been implemented in other languages or contexts*; or
  - *An improvement on other implementations of similar algorithms in **R***.

The second and third options additionally require references to comparable algorithms or implementations to be documented somewhere within the software, including references to all known implementations in other computer languages. (A common location for such is a statement of “*Prior Art*” or similar at the end of the main `README` document.)

- **G1.2** *Statistical Software should include a* Life Cycle Statement *describing current and anticipated future states of development.*

We encourage these to placed within a repository’s [`CONTRIBUTING.md` file](https://devguide.ropensci.org/collaboration.html#contributing-guide), as in [this example](https://github.com/ecohealthalliance/fasterize/blob/master/CONTRIBUTING.md). A simple *Life Cycle Statement* may be formed by selecting one of the following four statements.

    This package is

        - In a stable state of development, with minimal subsequent development
          envisioned.
        - In a stable state of development, with active subsequent development
          primarily in response to user feedback.
        - In a stable state of development, with some degree of active subsequent
          development as envisioned by the primary authors.
        - In an initially stable state of development, with a great deal of active
          subsequent development envisioned.

#### 6.1.1.1 Statistical Terminology

- **G1.3** *All statistical terminology should be clarified and unambiguously defined.*

Developers should not presume anywhere in the documentation of software that specific statistical terminology may be “generally understood”, and therefore not need explicit clarification. Even terms which many may consider sufficiently generic as to not require such clarification, such as “null hypotheses” or “confidence intervals”, will generally need explicit clarification. For example, both the estimation and interpretation of confidence intervals are dependent on distributional properties and associated assumptions. Any particular implementation of procedures to estimate or report on confidence intervals will accordingly reflect assumptions on distributional properties (among other aspects), both the nature and implications of which must be explicitly clarified.

#### 6.1.1.2 Function-level Documentation

- **G1.4** *Software should use [`roxygen2`](https://roxygen2.r-lib.org/) to document all functions.*
  - **G1.4a** *All internal (non-exported) functions should also be documented in standard [`roxygen2`](https://roxygen2.r-lib.org/) format, along with a final `@noRd` tag to suppress automatic generation of `.Rd` files or [`@keywords internal`](https://roxygen2.r-lib.org/reference/tags-index-crossref.html?q=keywords%20internal#null) if documentation is still desired.*

#### 6.1.1.3 Supplementary Documentation

The following standards describe several forms of what might be considered “Supplementary Material”. While there are many places within an R package where such material may be included, common locations include vignettes, or in additional directories (such as `data-raw`) listed in `.Rbuildignore` to prevent inclusion within installed packages.

Where software supports a publication, all claims made in the publication with regard to software performance (for example, claims of algorithmic scaling or efficiency; or claims of accuracy), the following standard applies:

- **G1.5** *Software should include all code necessary to reproduce results which form the basis of performance claims made in associated publications.*

Where claims regarding aspects of software performance are made with respect to other extant R packages, the following standard applies:

- **G1.6** *Software should include code necessary to compare performance claims with alternative implementations in other R packages.*

### 6.1.2 Input Structures

This section considers general standards for *Input Structures*. These standards may often effectively be addressed through implementing class structures, although this is not a general requirement. Developers are nevertheless encouraged to examine the guide to [S3 vectors](https://vctrs.r-lib.org/articles/s3-vector.html#casting-and-coercion) in the [`vctrs` package](https://vctrs.r-lib.org) as an example of the kind of assurances and validation checks that are possible with regard to input data. Systems like those demonstrated in that vignette provide a very effective way to ensure that software remains robust to diverse and unexpected classes and types of input data. Packages such [`checkmate`](https://mllg.github.io/checkmate/index.html) enable direct and simple ways to check and assert input structures.

#### 6.1.2.1 Uni-variate (Vector) Input

It is important to note for univariate data that single values in R are vectors with a length of one, and that `1` is of exactly the same *data type* as `1:n`. Given this, inputs expected to be univariate should:

- **G2.0** *Implement assertions on lengths of inputs, particularly through asserting that inputs expected to be single- or multi-valued are indeed so.*
  - **G2.0a** Provide explicit secondary documentation of any expectations on lengths of inputs
- **G2.1** *Implement assertions on types of inputs (see the initial point on nomenclature above).*
  - **G2.1a** *Provide explicit secondary documentation of expectations on data types of all vector inputs.*
- **G2.2** *Appropriately prohibit or restrict submission of multivariate input to parameters expected to be univariate.*
- **G2.3** *For univariate character input:*
  - **G2.3a** *Use [`match.arg()`](https://rdrr.io/r/base/match.arg.html) or equivalent where applicable to only permit expected values.*
  - **G2.3b** *Either: use [`tolower()`](https://rdrr.io/r/base/chartr.html) or equivalent to ensure input of character parameters is not case dependent; or explicitly document that parameters are strictly case-sensitive.*
- **G2.4** *Provide appropriate mechanisms to convert between different data types, potentially including:*
  - **G2.4a** *explicit conversion to `integer` via [`as.integer()`](https://rdrr.io/r/base/integer.html)*
  - **G2.4b** *explicit conversion to continuous via [`as.numeric()`](https://rdrr.io/r/base/numeric.html)*
  - **G2.4c** *explicit conversion to character via [`as.character()`](https://rdrr.io/r/base/character.html) (and not `paste` or `paste0`)*
  - **G2.4d** *explicit conversion to factor via [`as.factor()`](https://rdrr.io/r/base/factor.html)*
  - **G2.4e** *explicit conversion from factor via `as...()` functions*
- **G2.5** *Where inputs are expected to be of `factor` type, secondary documentation should explicitly state whether these should be `ordered` or not, and those inputs should provide appropriate error or other routines to ensure inputs follow these expectations.*

A few packages implement R versions of “static type” forms common in other languages, whereby the type of a variable must be explicitly specified prior to assignment. Use of such approaches is encouraged, including but not restricted to approaches documented in packages such as [`vctrs`](https://vctrs.r-lib.org), or the experimental package [`typed`](https://github.com/moodymudskipper/typed). One additional standard for vector input is:

- **G2.6** *Software which accepts one-dimensional input should ensure values are appropriately pre-processed regardless of class structures.*

The [`units` package](https://github.com/r-quantities/units/) provides a good example, in creating objects that may be treated as vectors, yet which have a class structure that does not inherit from the `vector` class. Using these objects as input often causes software to fail. The `storage.mode` of the underlying objects may nevertheless be examined, and the objects transformed or processed accordingly to ensure such inputs do not lead to errors.

#### 6.1.2.2 Tabular Input

This sub-section concerns input in “tabular data” forms, meaning the base R forms `array`, `matrix`, and `data.frame`, and other forms and classes derived from these. Tabular data generally have two dimensions, although may have more (such as for `array` objects). There is a primary distinction within R itself between `array` or `matrix` representations, and `data.frame` and associated representations. The former are restricted to storing data of a single uniform type (for example, all `integer` or all `character` values), whereas `data.frame` as associated representations (generally) store each column as a list item, allowing different columns to hold values of different types. Further noting that a `matrix` may, [as of R version 4.0](https://developer.r-project.org/Blog/public/2019/11/09/when-you-think-class.-think-again/index.html), be considered as a strictly two-dimensional array, tabular inputs for the purposes of these standards are considered to imply data represented in one or more of the following forms:

- `matrix` form when referring to specifically two-dimensional data of one uniform type
- `array` form as a more general expression, or when referring to data that are not necessarily or strictly two-dimensional
- `data.frame`
- Extensions such as
  - [`tibble`](https://tibble.tidyverse.org)
  - [`data.table`](https://rdatatable.gitlab.io/data.table)
  - domain-specific classes such as [`tsibble`](https://tsibble.tidyverts.org) for time series, or [`sf`](https://r-spatial.github.io/sf/) for spatial data.

Both `matrix` and `array` forms are actually stored as vectors with a single `storage.mode`, and so all of the preceding standards **G2.0**–**G2.5** apply. The other rectangular forms are not stored as vectors, and do not necessarily have a single `storage.mode` for all columns. These forms are referred to throughout these standards as “`data.frame`-type tabular forms”, which may be assumed to refer to data represented in either the [`base::data.frame`](https://rdrr.io/r/base/data.frame.html) format, and/or any of the classes listed in the final of the above points.

General Standards applicable to software which is intended to accept any one or more of these `data.frame`-type tabular inputs are then that:

- **G2.7** *Software should accept as input as many of the above standard tabular forms as possible, including extension to domain-specific forms.*

Software need not necessarily test abilities to accept different types of inputs, because that may require adding packages to the `Suggests` field of a package for that purpose alone. Nevertheless, software which somehow uses (through `Depends` or `Suggests`) any packages for representing tabular data should confirm in tests the ability to accept these types of input.

- **G2.8** *Software should provide appropriate conversion or dispatch routines as part of initial pre-processing to ensure that all other sub-functions of a package receive inputs of a single defined class or type.*
- **G2.9** *Software should issue diagnostic messages for type conversion in which information is lost (such as conversion of variables from factor to character; standardisation of variable names; or removal of meta-data such as those associated with [`sf`-format](https://r-spatial.github.io/sf/) data) or added (such as insertion of variable or column names where none were provided).*

Note, for example, that an `array` may have column names which start with numeric values, but that a `data.frame` may not.

      2
    1 1

      X2
    1  1

If `array` or `matrix` class objects are accepted as input, then **G2.8** implies that routines should be implemented to check for such conversion of column names.

The next standard concerns the following inconsistencies between three common tabular classes in regard the column extraction operator, `[`.

- Extracting a single column from a `data.frame` returns a `vector` by default, and a `data.frame` if `drop = FALSE`.
- Extracting a single column from a `tibble` returns a single-column `tibble` by default, and a `vector` if `drop = TRUE`.
- Extracting a single column from a `data.table` always returns a `data.table`, and the `drop` argument has no effect.

Given such inconsistencies,

- **G2.10** *Software should ensure that extraction or filtering of single columns from tabular inputs should not presume any particular default behaviour, and should ensure all column-extraction operations behave consistently regardless of the class of tabular data used as input.*

Adherence to the above standard **G2.8** will ensure that any implicitly or explicitly assumed default behaviour will yield consistent results regardless of input classes.

**Columns of tabular inputs**

The following standards apply to `data.frame`-like tabular objects (including all derived and otherwise compatible classes), and so do not apply to `matrix` or `array` objects.

- **G2.11** *Software should ensure that `data.frame`-like tabular objects which have columns which do not themselves have standard class attributes (typically, `vector`) are appropriately processed, and do not error without reason. This behaviour should be tested. Again, columns created by the [`units` package](https://github.com/r-quantities/units/) provide a good test case.*
- **G2.12** *Software should ensure that `data.frame`-like tabular objects which have list columns should ensure that those columns are appropriately pre-processed either through being removed, converted to equivalent vector columns where appropriate, or some other appropriate treatment such as an informative error. This behaviour should be tested.*

#### 6.1.2.3 Missing or Undefined Values

- **G2.13** *Statistical Software should implement appropriate checks for missing data as part of initial pre-processing prior to passing data to analytic algorithms.*
- **G2.14** *Where possible, all functions should provide options for users to specify how to handle missing (`NA`) data, with options minimally including:*
  - **G2.14a** *error on missing data*
  - **G2.14b** *ignore missing data with default warnings or messages issued*
  - **G2.14c** *replace missing data with appropriately imputed values*
- **G2.15** *Functions should never assume non-missingness, and should never pass data with potential missing values to any base routines with default `na.rm = FALSE`-type parameters (such as [`mean()`](https://stat.ethz.ch/R-manual/R-devel/library/base/html/mean.html), [`sd()`](https://stat.ethz.ch/R-manual/R-devel/library/stats/html/sd.html) or [`cor()`](https://stat.ethz.ch/R-manual/R-devel/library/stats/html/cor.html)).*
- **G2.16** *All functions should also provide options to handle undefined values (e.g., `NaN`, `Inf` and `-Inf`), including potentially ignoring or removing such values.*

### 6.1.3 Algorithms

- **G3.0** *Statistical software should never compare floating point numbers for equality. All numeric equality comparisons should either ensure that they are made between integers, or use appropriate tolerances for approximate equality.*

This standard applies to all computer languages included in any package. In R, values can be affirmed to be integers through [`is.integer()`](https://rdrr.io/r/base/integer.html), or asserting that the [`storage.mode()`](https://rdrr.io/r/base/mode.html) of an object is “integer”. One way to compare numeric values with tolerance is with the [`all.equal()` function](https://stat.ethz.ch/R-manual/R-devel/library/base/html/all.equal.html), which accepts an additional `tolerance` parameter with a default for `numeric` comparison of `sqrt(.Machine$double.eps)`, which is typically around e(-8–10). In other languages, including C and C++, comparisons of floating point numbers are commonly implemented by conditions such as `if (abs(a - b) < tol)`, where `tol` specifies the tolerance for equality.

Importantly, R functions such as [`duplicated()`](https://stat.ethz.ch/R-manual/R-devel/library/base/html/duplicated.html) and [`unique()`](https://stat.ethz.ch/R-manual/R-devel/library/base/html/unique.html) rely on equality comparisons, and this standard extends to require that software should not apply any functions which themselves rely on equality comparisons to floating point numbers.

- **G3.1** *Statistical software which relies on covariance calculations should enable users to choose between different algorithms for calculating covariances, and should not rely solely on covariances from the [`stats::cov`](https://rdrr.io/r/stats/cor.html) function.*
  - **G3.1a** *The ability to use arbitrarily specified covariance methods should be documented (typically in examples or vignettes).*

Estimates of covariance can be very sensitive to outliers, and a variety of methods have been developed for “robust” estimates of covariance, implemented in such packages as [`rms`](https://cran.r-project.org/package=rms), [`robust`](https://cran.r-project.org/package=robust), and [`sandwich`](https://cran.r-project.org/package=sandwich). Adhering to this standard merely requires an ability for a user to specify a particular covariance function, such as through an additional parameter. The [`stats::cov`](https://rdrr.io/r/stats/cor.html) function can be used as a default, and additional packages such as the three listed here need not necessarily be listed as `Imports` to a package.

### 6.1.4 Output Structures

- **G4.0** *Statistical Software which enables outputs to be written to local files should parse parameters specifying file names to ensure appropriate file suffixes are automatically generated where not provided.*

### 6.1.5 Testing

All packages should follow rOpenSci standards on [testing](https://devguide.ropensci.org/building.html#testing) and [continuous integration](https://devguide.ropensci.org/ci.html), including aiming for high test coverage. Extant R packages which may be useful for testing include [`testthat`](https://testthat.r-lib.org), [`tinytest`](https://github.com/markvanderloo/tinytest), [`roxytest`](https://github.com/mikldk/roxytest), and [`xpectr`](https://github.com/LudvigOlsen/xpectr).

#### 6.1.5.1 Test Data Sets

- **G5.0** *Where applicable or practicable, tests should use standard data sets with known properties (for example, the [NIST Standard Reference Datasets](https://www.itl.nist.gov/div898/strd/), or data sets provided by other widely-used R packages).*
- **G5.1** *Data sets created within, and used to test, a package should be exported (or otherwise made generally available) so that users can confirm tests and run examples.*

#### 6.1.5.2 Responses to Unexpected Input

- **G5.2** *Appropriate error and warning behaviour of all functions should be explicitly demonstrated through tests. In particular,*
  - **G5.2a** *Every message produced within R code by [`stop()`](https://rdrr.io/r/base/stop.html), [`warning()`](https://rdrr.io/r/base/warning.html), [`message()`](https://rdrr.io/r/base/message.html), or equivalent should be unique*
  - **G5.2b** *Explicit tests should demonstrate conditions which trigger every one of those messages, and should compare the result with expected values.*
- **G5.3** *For functions which are expected to return objects containing no missing (`NA`) or undefined (`NaN`, `Inf`) values, the absence of any such values in return objects should be explicitly tested.*

#### 6.1.5.3 Algorithm Tests

For testing *statistical algorithms*, tests should include tests of the following types:

- **G5.4** **Correctness tests** *to test that statistical algorithms produce expected results to some fixed test data sets (potentially through comparisons using binding frameworks such as [RStata](https://github.com/lbraglia/RStata)).*
  - **G5.4a** *For new methods, it can be difficult to separate out correctness of the method from the correctness of the implementation, as there may not be reference for comparison. In this case, testing may be implemented against simple, trivial cases or against multiple implementations such as an initial R implementation compared with results from a C/C++ implementation.*
  - **G5.4b** *For new implementations of existing methods, correctness tests should include tests against previous implementations. Such testing may explicitly call those implementations in testing, preferably from fixed-versions of other software, or use stored outputs from those where that is not possible.*
  - **G5.4c** *Where applicable, stored values may be drawn from published paper outputs when applicable and where code from original implementations is not available*
- **G5.5** *Correctness tests should be run with a fixed random seed*
- **G5.6** **Parameter recovery tests** *to test that the implementation produce expected results given data with known properties. For instance, a linear regression algorithm should return expected coefficient values for a simulated data set generated from a linear model.*
  - **G5.6a** *Parameter recovery tests should generally be expected to succeed within a defined tolerance rather than recovering exact values.*
  - **G5.6b** *Parameter recovery tests should be run with multiple random seeds when either data simulation or the algorithm contains a random component. (When long-running, such tests may be part of an extended, rather than regular, test suite; see G5.10-4.12, below).*

Note that authors should ensure that they use [at least v3 of the `testthat` package](https://testthat.r-lib.org), which introduced a [`testthat_tolerance()`](https://testthat.r-lib.org/reference/compare.html), defaulting to the value defined by `base::all_equal()` of `sqrt(.Machine$double.eps)` on all `expect_equal()` expectations.

- **G5.7** **Algorithm performance tests** *to test that implementation performs as expected as properties of data change. For instance, a test may show that parameters approach correct estimates within tolerance as data size increases, or that convergence times decrease for higher convergence thresholds.*
- **G5.8** **Edge condition tests** *to test that these conditions produce expected behaviour such as clear warnings or errors when confronted with data with extreme properties including but not limited to:*
  - **G5.8a** *Zero-length data*
  - **G5.8b** *Data of unsupported types (e.g., character or complex numbers in for functions designed only for numeric data)*
  - **G5.8c** *Data with all-`NA` fields or columns or all identical fields or columns*
  - **G5.8d** *Data outside the scope of the algorithm (for example, data with more fields (columns) than observations (rows) for some regression algorithms)*
- **G5.9** **Noise susceptibility tests** *Packages should test for expected stochastic behaviour, such as through the following conditions:*
  - **G5.9a** *Adding trivial noise (for example, at the scale of `.Machine$double.eps`) to data does not meaningfully change results*
  - **G5.9b** *Running under different random seeds or initial conditions does not meaningfully change results*

#### 6.1.5.4 Extended tests

Thorough testing of statistical software may require tests on large data sets, tests with many permutations, or other conditions leading to long-running tests. In such cases it may be neither possible nor advisable to execute tests continuously, or with every code change. Software should nevertheless test any and all conditions regardless of how long tests may take, and in doing so should adhere to the following standards:

- **G5.10** *Extended tests should included and run under a common framework with other tests but be switched on by flags such as as a `<MYPKG>_EXTENDED_TESTS="true"` environment variable.*
  - The extended tests can be then run automatically by GitHub Actions for example by adding the following to the `env` section of the workflow:

    `MYPKG_EXTENDED_TESTS: ${{contains(github.event.head_commit.message, 'run-extended')}}`

    Extended tests will then be run in response to any commit message which contains the phrase `run-extended`.
- **G5.11** *Where extended tests require large data sets or other assets, these should be provided for downloading and fetched as part of the testing workflow.*
  - **G5.11a** *When any downloads of additional data necessary for extended tests fail, the tests themselves should not fail, rather be skipped and implicitly succeed with an appropriate diagnostic message.*
- **G5.12** *Any conditions necessary to run extended tests such as platform requirements, memory, expected runtime, and artefacts produced that may need manual inspection, should be described in developer documentation such as a `CONTRIBUTING.md` or `tests/README.md` file.*

------------------------------------------------------------------------

## 6.2 Bayesian and Monte Carlo Software

Bayesian and Monte Carlo software centres on quantitative estimation of components of [Baye’s theorem](https://en.wikipedia.org/wiki/Bayes%27_theorem), particularly on estimation or application of prior and/or posterior probability distributions. The procedures implemented to estimate the properties of such distributions are commonly based on random sampling procedures, hence referred to as “*Monte Carlo*” routines in reference to the random yet quantifiable nature of casino games. The scope of this category also includes algorithms which focus on sampling routines only, such as Markov-Chain Monte Carlo (MCMC) procedures, independent of application in Bayesian analyses.

The term “model” is understood with reference here to Bayesian software to refer to an encoded description of how parameters specifying aspects of one or more prior distributions are transformed into (properties of) one or more posterior distributions.

Some examples of Bayesian and Monte Carlo software include:

1.  The [`bayestestR` package](https://joss.theoj.org/papers/10.21105/joss.01541) which “provides tools to describe … posterior distributions”
2.  The [`ArviZ` package](https://joss.theoj.org/papers/10.21105/joss.01143) python package for exploratory analyses of Bayesian models, particularly posterior distributions.
3.  The [`GammaGompertzCR` package](https://joss.theoj.org/papers/10.21105/joss.00216), which features explicit diagnostics of MCMC convergence statistics.
4.  The [`BayesianNetwork` package](https://joss.theoj.org/papers/10.21105/joss.00425), which is in many ways a wrapper package primarily serving a `shiny` app, and is also accordingly a package in the EDA category.
5.  The [`fmcmc` package](https://joss.theoj.org/papers/10.21105/joss.01427), which is a “classic” MCMC package which directly provides its own implementation, and generates its own convergence statistics.
6.  The [`rsimsum` package](https://joss.theoj.org/papers/10.21105/joss.00739) which “summarise\[s\] results from Monte Carlo simulation studies”. Many of the statistics generated by this package are useful for assessing and comparing Bayesian and Monte Carlo software in general. (See also the [`MCMCvis` package](https://joss.theoj.org/papers/10.21105/joss.00640), with more of a focus on visualisation.)
7.  The [`walkr` package](https://joss.theoj.org/papers/10.21105/joss.00061) for “MCMC Sampling from Non-Negative Convex Polytopes”. This package is also indicative of the difficulties of deriving generally applicable assessments of software in this category, because MCMC *sampling* relies on fundamentally different inputs and outputs than many other MCMC routines.

Click on the following link to view a demonstration [Application of Bayesian and Monte Carlo Standards](https://hackmd.io/zVWTAl9ZQeCcj_bvMGcmMQ).

Bayesian and Monte Carlo Software (hereafter referred to for simplicity as “Bayesian Software”) is presumed to perform one or more of the following steps:

1.  Document how to specify inputs including:
    - 1.1 Data
    - 1.2 Parameters determining prior distributions
    - 1.3 Parameters determining the computational processes
2.  Accept and validate all of forms of input
3.  Apply data transformation and pre-processing steps
4.  Apply one or more analytic algorithms, generally sampling algorithms used to generate estimates of posterior distributions
5.  Return the result of that algorithmic application
6.  Offer additional functionality such as printing or summarising return results

This chapter details standards for each of these steps, each prefixed with “BS”.

### 6.2.1 Documentation of Inputs

Prior to actual standards for documentation of inputs, we note one terminological standard for Bayesian software which uses the term “hyperparameter”:

- **BS1.0** *Bayesian software which uses the term “hyperparameter” should explicitly clarify the meaning of that term in the context of that software.*

This standard reflects the dual facts that this term is frequently used in Bayesian software, yet has no unambiguous definition or interpretation. The term “hyperparameter” is also used in other statistical contexts in ways that are often distinctly different from its common use in Bayesian analyses. Examples of the kinds of clarifications required to adhere to this standard include,

> Hyperparameters refer here to parameters determining the form of prior distributions that conditionally depend on other parameters.

Such a clarification would then require further explicit distinction between “parameters” and “hyperparameters”. The remainder of these standards does not refer to “hyperparameters”, rather attempts to make explicit distinctions between different kinds of parameters, such as distributional or algorithmic control parameters. Beyond this standard, Bayesian Software should provide the following documentation of how to specify inputs:

- **BS1.1** *Descriptions of how to enter data, both in textual form and via code examples. Both of these should consider the simplest cases of single objects representing independent and dependent data, and potentially more complicated cases of multiple independent data inputs.*
- **BS1.2** *Description of how to specify prior distributions, both in textual form describing the general principles of specifying prior distributions, along with more applied descriptions and examples, within:*
  - **BS1.2a** *The main package `README`, either as textual description or example code*
  - **BS1.2b** *At least one package vignette, both as general and applied textual descriptions, and example code*
  - **BS1.2c** *Function-level documentation, preferably with code included in examples*
- **BS1.3** *Description of all parameters which control the computational process (typically those determining aspects such as numbers and lengths of sampling processes, seeds used to start them, thinning parameters determining post-hoc sampling from simulated values, and convergence criteria). In particular:*
  - **BS1.3a** *Bayesian Software should document, both in text and examples, how to use the output of previous simulations as starting points of subsequent simulations.*
  - **BS1.3b** *Where applicable, Bayesian software should document, both in text and examples, how to use different sampling algorithms for a given model.*
- **BS1.4** *For Bayesian Software which implements or otherwise enables convergence checkers, documentation should explicitly describe and provide examples of use with and without convergence checkers.*
- **BS1.5** *For Bayesian Software which implements or otherwise enables multiple convergence checkers, differences between these should be explicitly tested.*

### 6.2.2 Input Data Structures and Validation

This section contains standards primarily intended to ensure that input data, including model specifications, are validated prior to passing through to the main computational algorithms.

#### 6.2.2.1 Input Data

Bayesian Software is commonly designed to accept generic one- or two-dimensional forms such as vector, matrix, or `data.frame` objects, for which the following standard applies.

- **BS2.1** *Bayesian Software should implement pre-processing routines to ensure all input data is dimensionally commensurate, for example by ensuring commensurate lengths of vectors or numbers of rows of tabular inputs.*
  - **BS2.1a** *The effects of such routines should be tested.*

#### 6.2.2.2 Prior Distributions, Model Specifications, and Distributional Parameters

The second set of standards in this section concern specification of prior distributions, model structures, or other equivalent ways of specifying hypothesised relationships among input data structures. R already has a diverse range of Bayesian Software with distinct approaches to this task, commonly either through specifying a model as a character vector representing an R function, or an external file either as R code, or encoded according to some alternative system (such as for [`rstan`](https://mc-stan.org/rstan/)).

Bayesian Software should:

- **BS2.2** *Ensure that all appropriate validation and pre-processing of distributional parameters are implemented as distinct pre-processing steps prior to submitting to analytic routines, and especially prior to submitting to multiple parallel computational chains.*
- **BS2.3** *Ensure that lengths of vectors of distributional parameters are checked, with no excess values silently discarded (unless such output is explicitly suppressed, as detailed below).*
- **BS2.4** *Ensure that lengths of vectors of distributional parameters are commensurate with expected model input (see example immediately below)*
- **BS2.5** *Where possible, implement pre-processing checks to validate appropriateness of numeric values submitted for distributional parameters; for example, by ensuring that distributional parameters defining second-order moments such as distributional variance or shape parameters, or any parameters which are logarithmically transformed, are non-negative.*

The following example demonstrates how standards like the above (BS2.4-2.5) might be addressed. Consider the following function which defines a log-likelihood estimator for a linear regression, controlled via a vector of three distributional parameters, `p`:

``` downlit
ll <- function (x, y, p) dnorm (y - (p[1] + x * p[2]), sd = p[3], log = TRUE)
```

Pre-processing stages should be used to determine:

1.  That the dimensions of the input data, `x` and `y`, are commensurate (BS2.1); non-commensurate inputs should error by default.
2.  The length of the vector `p` (BS2.3)

The latter task is not necessarily straightforward, because the definition of the function, `ll()`, will itself generally be part of the input to an actual Bayesian Software function. This functional input thus needs to be examined to determine expected lengths of hyperparameter vectors. The following code illustrates one way to achieve this, relying on utilities for parsing function calls in R, primarily through the [`getParseData`](https://stat.ethz.ch/R-manual/R-devel/library/utils/html/getParseData.html) function from the `utils` package. The parse data for a function can be extracted with the following line:

``` downlit
x <- getParseData (parse (text = deparse (ll)))
```

The object `x` is a `data.frame` of every R token (such as an expression, symbol, or operator) parsed from the function `ll`. The following section illustrates how this data can be used to determine the expected lengths of vector inputs to the function, `ll()`.

click to see details

Input arguments used to define parameter vectors in any R software are accessed through R’s standard vector access syntax of `vec[i]`, for some element `i` of a vector `vec`. The parse data for such begins with the `SYMBOL` of `vec`, the `[`, a `NUM_CONST` for the value of `i`, and a closing `]`. The following code can be used to extract elements of the parse data which match this pattern, and ultimately to extract the various values of `i` used to access members of `vec`.

``` downlit
vector_length <- function (x, i) {
    xn <- x [which (x$token %in% c ("SYMBOL", "NUM_CONST", "'['", "']'")), ]
    # split resultant data.frame at first "SYMBOL" entry
    xn <- split (xn, cumsum (xn$token == "SYMBOL"))
    # reduce to only those matching the above pattern
    xn <- xn [which (vapply (xn, function (j)
                             j$text [1] == i & nrow (j) > 3,
                             logical (1)))]
    ret <- NA_integer_ # default return value
    if (length (xn) > 0) {
        # get all values of NUM_CONST as integers
        n <- vapply (xn, function (j)
                         as.integer (j$text [j$token == "NUM_CONST"] [1]),
                         integer (1), USE.NAMES = FALSE)
        # and return max of these
        ret <- max (n)
    }
    return (ret)
}
```

That function can then be used to determine the length of any inputs which are used as hyperparameter vectors:

``` downlit
ll <- function (p, x, y) dnorm (y - (p[1] + x * p[2]), sd = p[3], log = TRUE)
p <- parse (text = deparse (ll))
x <- utils::getParseData (p)

# extract the names of the parameters:
params <- unique (x$text [x$token == "SYMBOL"])
lens <- vapply (params, function (i) vector_length (x, i), integer (1))
lens
#>  y  p  x 
#> NA  3 NA
```

And the vector `p` is used as a hyperparameter vector containing three parameters. Any initial value vectors can then be examined to ensure that they have this same length.

------------------------------------------------------------------------

\

Not all Bayesian Software is designed to accept model inputs expressed as R code. The [`rstan` package](https://github.com/stan-dev/rstan), for example, implements its own model specification language, and only allows distributional parameters to be named, and not addressed by index. While this largely avoids problems of mismatched lengths of parameter vectors, the software (at v2.21.1) does not ensure the existence of named parameters prior to starting the computational chains. This ultimately results in each chain generating an error when a model specification refers to a non-existent or undefined distributional parameter. Such controls should be part of a single pre-processing stage, and so should only generate a single error.

#### 6.2.2.3 Computational Parameters

Computational parameters are considered here distinct from distributional parameters, and commonly passed to Bayesian functions to directly control computational processes. They typically include parameters controlling lengths of runs, lengths of burn-in periods, numbers of parallel computations, other parameters controlling how samples are to be generated, or convergence criteria. All Computational Parameters should be checked for general “sanity” prior to calling primary computational algorithms. The standards for such sanity checks include that Bayesian Software should:

- **BS2.6** *Check that values for computational parameters lie within plausible ranges.*

While admittedly not always possible to define, plausible ranges may be as simple as ensuring values are greater than zero. Where possible, checks should nevertheless ensure appropriate responses to extremely large values, for example by issuing diagnostic messages about likely long computational times. The following two sub-sections consider particular cases of computational parameters.

#### 6.2.2.4 Parameters Controlling Start Values

Bayesian software generally relies on sequential random sampling procedures, with each sequence uniquely determined by (among other aspects) the value at which it is started. Given that, Bayesian software should:

- **BS2.7** *Enable starting values to be explicitly controlled via one or more input parameters, including multiple values for software which implements or enables multiple computational “chains.”*
- **BS2.8** *Enable results of previous runs to be used as starting points for subsequent runs.*

Bayesian Software which implements or enables multiple computational chains should:

- **BS2.9** *Ensure each chain is started with a different seed by default.*
- **BS2.10** *Issue diagnostic messages when identical seeds are passed to distinct computational chains.*
- **BS2.11** *Software which accepts starting values as a vector should provide the parameter with a plural name: for example, “starting_values” and not “starting_value”.*

To avoid potential confusion between separate parameters to control random seeds and starting values, we recommended a single “starting values” rather than “seeds” argument, with appropriate translation of these parameters into seeds where necessary.

#### 6.2.2.5 Output Verbosity

All Bayesian Software should implement computational parameters to control output verbosity. Bayesian computations are often time-consuming, and often performed as batch computations. The following standards should be adhered to in regard to output verbosity:

- **BS2.12** *Bayesian Software should implement at least one parameter controlling the verbosity of output, defaulting to verbose output of all appropriate messages, warnings, errors, and progress indicators.*
- **BS2.13** *Bayesian Software should enable suppression of messages and progress indicators, while retaining verbosity of warnings and errors. This should be tested.*
- **BS2.14** *Bayesian Software should enable suppression of warnings where appropriate. This should be tested.*
- **BS2.15** *Bayesian Software should explicitly enable errors to be caught, and appropriately processed either through conversion to warnings, or otherwise captured in return values. This should be tested.*

### 6.2.3 Pre-processing and Data Transformation

#### 6.2.3.1 Missing Values

In additional to the *General Standards* for missing values (**G2.13**–**2.16**), and in particular **G2.13**, Bayesian Software should:

- **BS3.0** *Explicitly document assumptions made in regard to missing values; for example that data is assumed to contain no missing (`NA`, `Inf`) values, and that such values, or entire rows including any such values, will be automatically removed from input data.*

#### 6.2.3.2 Perfect Collinearity

Where appropriate, Bayesian Software should:

- **BS3.1** *Implement pre-processing routines to diagnose perfect collinearity, and provide appropriate diagnostic messages or warnings*
- **BS3.2** *Provide distinct routines for processing perfectly collinear data, potentially bypassing sampling algorithms*

An appropriate test for **BS3.2** would confirm that [`system.time()`](https://rdrr.io/r/base/system.time.html) or equivalent timing expressions for perfectly collinear data should be *less* than equivalent routines called with non-collinear data. Alternatively, a test could ensure that perfectly collinear data passed to a function with a stopping criteria generated no results, while specifying a fixed number of iterations may generate results.

### 6.2.4 Analytic Algorithms

As mentioned, analytic algorithms for Bayesian Software are commonly algorithms to simulate posterior distributions, and to draw samples from those simulations. Numerous extant R packages implement and offer sampling algorithms, and not all Bayesian Software will internally implement sampling algorithms. The following standards apply to packages which do implement internal sampling algorithms:

- **BS4.0** *Packages should document sampling algorithms (generally via literary citation, or reference to other software)*
- **BS4.1** *Packages should provide explicit comparisons with external samplers which demonstrate intended advantage of implementation (generally via tests, vignettes, or both).*

Regardless of whether or not Bayesian Software implements internal sampling algorithms, it should:

- **BS4.2** *Implement at least one means to validate posterior estimates.*

An example of posterior validation is the [Simulation Based Calibration](https://arxiv.org/abs/1804.06788) approach implemented in the [`rstan`](https://mc-stan.org/rstan) function [`sbc`](https://mc-stan.org/rstan/reference/sbc.html)). (Note also that the [`BayesValidate` package](https://cran.r-project.org/package=BayesValidate) has not been updated for almost 15 years, so should not be directly used, although ideas from that package may be adapted for validation purposes.) Beyond this, where possible or applicable, Bayesian Software should:

- **BS4.3** *Implement or otherwise offer at least one type of convergence checker, and provide a documented reference for that implementation.*
- **BS4.4** *Enable computations to be stopped on convergence (although not necessarily by default).*
- **BS4.5** *Ensure that appropriate mechanisms are provided for models which do not converge.*

This is often achieved by having default behaviour to stop after specified numbers of iterations regardless of convergence.

- **BS4.6** *Implement tests to confirm that results with convergence checker are statistically equivalent to results from equivalent fixed number of samples without convergence checking.*
- **BS4.7** *Where convergence checkers are themselves parametrised, the effects of such parameters should also be tested. For threshold parameters, for example, lower values should result in longer sequence lengths.*

### 6.2.5 Return Values

Unlike software in many other categories, Bayesian Software should generally return several kinds of distinct data, both the raw data derived from statistical algorithms, and associated metadata. Such distinct and generally disparate forms of data will be generally best combined into a single object through implementing a defined class structure, although other options are possible, including (re-)using extant class structures (see the CRAN Task view on [Bayesian Inference](https://cran.r-project.org/web/views/Bayesian.html) for reference to other packages and class systems). Regardless of the precise form of return object, and whether or not defined class structures are used or implemented, the following standards apply:

- **BS5.0** *Return values should include starting value(s) or seed(s), including values for each sequence where multiple sequences are included*
- **BS5.1** *Return values should include appropriate metadata on types (or classes) and dimensions of input data*

The latter standard may also include returning a unique hash computed from the input data, to enable results to be uniquely associated with that input data. With regard to the input function, or alternative means of specifying prior distributions:

- **BS5.2** *Bayesian Software should either return the input function or prior distributional specification in the return object; or enable direct access to such via additional functions which accept the return object as single argument.*

Where convergence checkers are implemented or provided:

- **BS5.3** *Bayesian Software should return convergence statistics or equivalent*
- **BS5.4** *Where multiple checkers are enabled, Bayesian Software should return details of convergence checker used*
- **BS5.5** *Appropriate diagnostic statistics to indicate absence of convergence should either be returned or immediately able to be accessed.*

### 6.2.6 Additional Functionality

With regard to additional methods implemented for, or dispatched on, return objects:

- **BS6.0** *Software should implement a default `print` method for return objects*
- **BS6.1** *Software should implement a default `plot` method for return objects*
- **BS6.2** *Software should provide and document straightforward abilities to plot sequences of posterior samples, with burn-in periods clearly distinguished*
- **BS6.3** *Software should provide and document straightforward abilities to plot posterior distributional estimates*

Beyond these points:

- **BS6.4** *Software may provide `summary` methods for return objects*
- **BS6.5** *Software may provide abilities to plot both sequences of posterior samples and distributional estimates together in single graphic*

### 6.2.7 Tests

#### 6.2.7.1 Parameter Recovery Tests

Bayesian software should implement the following parameter recovery tests:

- **BS7.0** *Software should demonstrate and confirm recovery of parametric estimates of a prior distribution*
- **BS7.1** *Software should demonstrate and confirm recovery of a prior distribution in the absence of any additional data or information*
- **BS7.2** *Software should demonstrate and confirm recovery of a expected posterior distribution given a specified prior and some input data*

#### 6.2.7.2 Algorithmic Scaling Tests

- **BS7.3** *Bayesian software should include tests which demonstrate and confirm the scaling of algorithmic efficiency with sizes of input data.*

An example of adhering to this standard would be documentation or tests which demonstrate or confirm that computation times increase approximately logarithmically with increasing sizes of input data.

#### 6.2.7.3 Scaling of Input to Output Data

- **BS7.4** *Bayesian software should implement tests which confirm that predicted or fitted values are on (approximately) the same scale as input values.*
  - **BS7.4a** *The implications of any assumptions on scales on input objects should be explicitly tested in this context; for example that the scales of inputs which do not have means of zero will not be able to be recovered.*

------------------------------------------------------------------------

## 6.3 Exploratory Data Analysis and Summary Statistics

Exploration is a part of all data analyses, and Exploratory Data Analysis (EDA) is not something that is entered into and exited from at some point prior to “real” analysis. Exploratory Analyses are also not strictly limited to *Data*, but may extend to exploration of *Models* of those data. The category could thus equally be termed, “*Exploratory Data and Model Analysis*”, yet we opt to utilise the standard acronym of EDA in this document.

Summary statistics are generally intended to aid data exploration, and software providing summary statistics is also considered here as a form of EDA software. For simplicity, both kinds of software are referred to throughout these standards as “EDA software”, a phrase intended at all times to also encompass summary statistics software.

The category of EDA is somewhat different to many other categories considered here. Primary differences include:

- EDA software often has a strong focus upon visualization, which is a category which we have otherwise explicitly excluded from the scope of the project at the present stage.
- The assessment of EDA software requires addressing more general questions than software in most other categories, notably including the important question of intended audience(s).

Examples of EDA software include:

1.  A package rejected by rOpenSci as out-of-scope, [`gtsummary`](https://github.com/ddsjoberg/gtsummary), which provides, “Presentation-ready data summary and analytic result tables.”
2.  The [`smartEDA` package](https://github.com/daya6489/SmartEDA) (with accompanying [JOSS paper](https://joss.theoj.org/papers/10.21105/joss.01509)) “for automated exploratory data analysis”. The package, “automatically selects the variables and performs the related descriptive statistics. Moreover, it also analyzes the information value, the weight of evidence, custom tables, summary statistics, and performs graphical techniques for both numeric and categorical variables.” This package is potentially as much a workflow package as it is a statistical reporting package, and illustrates the ambiguity between these two categories.
3.  The [`modeLLtest` package](https://github.com/ShanaScogin/modeLLtest) (with accompanying [JOSS paper](https://joss.theoj.org/papers/10.21105/joss.01542)) is “An R Package for Unbiased Model Comparison using Cross Validation.” Its main functionality allows different statistical models to be compared, likely implying that this represents a kind of meta package.
4.  The [`insight` package](https://github.com/easystats/insight) (with accompanying [JOSS paper](https://joss.theoj.org/papers/10.21105/joss.01412)) provides “a unified interface to access information from model objects in R,” with a strong focus on unified and consistent reporting of statistical results.
5.  The [`arviz` software for python](https://github.com/arviz-devs/arviz) (with accompanying [JOSS paper](https://joss.theoj.org/papers/10.21105/joss.01143)) provides “a unified library for exploratory analysis of Bayesian models in Python.”
6.  The [`iRF` package](https://github.com/sumbose/iRF) (with accompanying [JOSS paper](https://joss.theoj.org/papers/10.21105/joss.01077)) enables “extracting interactions from random forests”, yet also focusses primarily on enabling interpretation of random forests through reporting on interaction terms.

Click on the following link to view a demonstration [Application of Exploratory Data Analysis Standards](https://hackmd.io/K8F1RIhdQeuZFqMnzdqNVw).

Reflecting these considerations, the following standards are somewhat differently structured than equivalent standards developed to date for other categories, particularly through being more qualitative and abstract. In particular, while documentation is an important component of standards for all categories, clear and instructive documentation is of paramount importance for EDA Software, and so warrants its own sub-section within this document.

### 6.3.1 Documentation Standards

The following refer to *Primary Documentation*, implying in main package `README` or vignette(s), and *Secondary Documentation*, implying function-level documentation.

The *Primary Documentation* (`README` and/or vignette(s)) of EDA software should:

- **EA1.0** *Identify one or more target audiences for whom the software is intended*
- **EA1.1** *Identify the kinds of data the software is capable of analysing (see* Kinds of Data\* below).\*
- **EA1.2** *Identify the kinds of questions the software is intended to help explore.*

Important distinctions between kinds of questions include whether they are inferential, predictive, associative, causal, or representative of other modes of statistical enquiry. The *Secondary Documentation* (within individual functions) of EDA software should:

- **EA1.3** *Identify the kinds of data each function is intended to accept as input*

### 6.3.2 Input Data

A further primary difference of EDA software from that of our other categories is that input data for statistical software may be generally presumed of one or more specific types, whereas EDA software often accepts data of more general and varied types. EDA software should aim to accept and appropriately transform as many diverse kinds of input data as possible, through addressing the following standards, considered in terms of the two cases of input data in uni- and multi-variate form. All of the general standards for kinds of input (G2.0 - G2.12) apply to input data for EDA Software.

#### 6.3.2.1 Index Columns

The following standards refer to an *index column*, which is understood to imply an explicitly named or identified column which can be used to provide a unique index index into any and all rows of that table. Index columns ensure the universal applicability of standard table join operations, such as those implemented via the [`dplyr` package](https://dplyr.tidyverse.org).

- **EA2.0** *EDA Software which accepts standard tabular data and implements or relies upon extensive table filter and join operations should utilise an **index column** system*
- **EA2.1** *All values in an index column must be unique, and this uniqueness should be affirmed as a pre-processing step for all input data.*
- **EA2.2** *Index columns should be explicitly identified, either:*
  - **EA2.2a** *by using an appropriate class system, or*
  - **EA2.2b** *through setting an `attribute` on a table, `x`, of `attr(x, "index") <- <index_col_name>`.*

For EDA software which either implements custom classes or explicitly sets attributes specifying index columns, these attributes should be used as the basis of all table join operations, and in particular:

- **EA2.3** *Table join operations should not be based on any assumed variable or column names*

#### 6.3.2.2 Multi-tabular input

EDA software designed to accept multi-tabular input should:

- **EA2.4** *Use and demand an explicit class system for such input (for example, via the [`DM` package](https://github.com/krlmlr/dm)).*
- **EA2.5** *Ensure all individual tables follow the above standards for Index Columns*

#### 6.3.2.3 Classes and Sub-Classes

*Classes* are understood here to be the classes define single input objects, while *Sub-Classes* refer to the class definitions of components of input objects (for example, of columns of an input `data.frame`). EDA software which is intended to receive input in general vector formats (see *Uni-variate Input* section of [*General Standards*](#general-standards)) should ensure that it complies with **G2.**, so that vector input is appropriately processed regardless of input class. An additional standard for EDA software is that,

- **EA2.6** *Routines should appropriately process vector data regardless of additional attributes*

The following code illustrates some ways by which “metadata” defining classes and additional attributes associated with a standard vector object may by modified.

``` downlit
x <- 1:10
class (x) <- "notvector"
attr (x, "extra_attribute") <- "another attribute"
attr (x, "vector attribute") <- runif (5)
attributes (x)
#> $class
#> [1] "notvector"
#> 
#> $extra_attribute
#> [1] "another attribute"
#> 
#> $`vector attribute`
#> [1] 0.03521663 0.49418081 0.60129563 0.75804346 0.16073301
```

All statistical software should appropriately deal with such input data, as exemplified by the [`storage.mode()`](https://rdrr.io/r/base/mode.html), [`length()`](https://rdrr.io/r/base/length.html), and [`sum()`](https://rdrr.io/r/base/sum.html) functions of the `base` package, which return the appropriate values regardless of redefinition of class or additional attributes.

``` downlit
storage.mode (x)
#> [1] "integer"
length (x)
#> [1] 10
sum (x)
#> [1] 55
storage.mode (sum (x))
#> [1] "integer"
```

Tabular inputs in `data.frame` class may contain columns which are themselves defined by custom classes, and which possess additional attributes. The ability of software to accept such inputs is covered by the *Tabular Input* section of the [*General Standards*](#general-standards).

### 6.3.3 Analytic Algorithms

EDA software will generally not directly implement what might be considered as statistical algorithms in their own right. Where algorithms are implemented, the following standards apply.

- **EA3.0** *The algorithmic components of EDA Software should enable automated extraction and/or reporting of statistics as some sufficiently “meta” level (such as variable or model selection), for which previous or reference implementations require manual intervention.*
- **EA3.1** *EDA software should enable standardised comparison of inputs, processes, models, or outputs which previous or reference implementations otherwise only enable in some comparably unstandardised form.*

Both of these standards also relate to the following standards for output values, visualisation, and summary output.

### 6.3.4 Return Results / Output Data

- **EA4.0** *EDA Software should ensure all return results have types which are consistent with input types.*

Examples of such compliance include ensuring that `sum`, `min`, or `max` values applied to `integer`-type vectors return `integer` values.

- **EA4.1** *EDA Software should implement parameters to enable explicit control of numeric precision*
- **EA4.2** *The primary routines of EDA Software should return objects for which default `print` and `plot` methods give sensible results. Default `summary` methods may also be implemented.*

### 6.3.5 Visualization and Summary Output

Visualization commonly represents one of the primary functions of EDA Software, and thus visualization output is given greater consideration in this category than in other categories in which visualization may nevertheless play an important role. In particular, one component of this sub-category is *Summary Output*, taken to refer to all forms of screen-based output beyond conventional graphical output, including tabular and other text-based forms. Standards for visualization itself are considered in the two primary sub-categories of static and dynamic visualization, where the latter includes interactive visualization.

Prior to these individual sub-categories, we consider a few standards applicable to visualization in general, whether static or dynamic.

- **EA5.0** *Graphical presentation in EDA software should be as accessible as possible or practicable. In particular, EDA software should consider accessibility in terms of:*
  - **EA5.0a** *Typeface sizes, which should default to sizes which explicitly enhance accessibility*
  - **EA5.0b** *Default colour schemes, which should be carefully constructed to ensure accessibility.*
- **EA5.1** *Any explicit specifications of typefaces which override default values provided through other packages (including the `graphics` package) should consider accessibility*

#### 6.3.5.1 Summary and Screen-based Output

- **EA5.2** *Screen-based output should never rely on default print formatting of `numeric` types, rather should also use some version of `round(., digits)`, `formatC`, `sprintf`, or similar functions for numeric formatting according the parameter described in* **EA4.1**.
- **EA5.3** *Column-based summary statistics should always indicate the `storage.mode`, `class`, or equivalent defining attribute of each column.*

An example of compliance with the latter standard is the `print.tibble` method of the [`tibble` package](https://tibble.tidyverse.org).

#### 6.3.5.2 General Standards for Visualization (Static and Dynamic)

- **EA5.4** *All visualisations should ensure values are rounded sensibly (for example, via [`pretty()`](https://rdrr.io/r/base/pretty.html) function).*
- **EA5.5** *All visualisations should include units on all axes where such are specified or otherwise obtainable from input data or other routines.*

#### 6.3.5.3 Dynamic Visualization

Dynamic visualization routines are commonly implemented as interfaces to `javascript` routines. Unless routines have been explicitly developed as an internal part of an R package, standards shall not be considered to apply to the code itself, rather only to decisions present as user-controlled parameters exposed within the R environment. That said, one standard may nevertheless be applied, which aims to maximise inter-operability between packages.

- **EA5.6** *Any packages which internally bundle libraries used for dynamic visualization and which are also bundled in other, pre-existing R packages, should explain the necessity and advantage of re-bundling that library.*

### 6.3.6 Testing

#### 6.3.6.1 Return Values

- **EA6.0** *Return values from all functions should be tested, including tests for the following characteristics:*
  - **EA6.0a** *Classes and types of objects*
  - **EA6.0b** *Dimensions of tabular objects*
  - **EA6.0c** *Column names (or equivalent) of tabular objects*
  - **EA6.0d** *Classes or types of all columns contained within `data.frame`-type tabular objects*
  - **EA6.0e** *Values of single-valued objects; for `numeric` values either using `testthat::expect_equal()` or equivalent with a defined value for the `tolerance` parameter, or using `round(..., digits = x)` with some defined value of `x` prior to testing equality.*

#### 6.3.6.2 Graphical Output

- **EA6.1** *The properties of graphical output from EDA software should be explicitly tested, for example via the [`vdiffr` package](https://github.com/r-lib/vdiffr) or equivalent.*

Tests for graphical output are frequently only run as part of an extended test suite.

------------------------------------------------------------------------

## 6.4 Machine Learning Software

R has an extensive and diverse ecosystem of Machine Learning (ML) software which is very well described in the corresponding [CRAN Task View](https://cran.r-project.org/web/views/MachineLearning.html). Unlike most other categories of statistical software considered here, the primary distinguishing feature of ML software is not (necessarily or directly) algorithmic, rather pertains to a *workflow* typical of machine learning tasks. In particular, we consider ML software to approach data analysis via the two primary steps of:

1.  Passing a set of *training* data to an algorithm in order to generate a candidate mapping between that data and some form of pre-specified output or response variable. Such mappings will be referred to here as “models”, with a single analysis of a single set of training data generating one model.
2.  Passing a set of test data to the model(s) generated by the first step in order to derive some measure of predictive accuracy for that model.

A single ML task generally yields two distinct outputs:

1.  The model derived in the first of the previous steps; and
2.  Associated statistics of model performance, as evaluated within the context of the test data used to assess that performance.

Click on the following link to view a demonstration [Application of Machine Learning Software Standards](https://hackmd.io/Ix1YwD8YTWGuzdiXsVQadA).

**A Machine Learning Workflow**

Given those initial considerations, we now attempt the difficult task of envisioning a typical standard workflow for inherently diverse ML software. The following workflow ought to be considered an “extensive” workflow, with shorter versions, and correspondingly more restricted sets of standards, possible dependent upon envisioned areas of application. For example, the workflow presumes input data to be too large to be stored as a single entity in local memory. Adaptation to situations in which all training data can be loaded into memory may mean that some of the following workflow stages, and therefore corresponding standards, may not apply.

Just as typical workflows are potentially very diverse, so are outputs of ML software, which depend on areas of application and intended purpose of software. The following refers to the “desired output” of ML software, a phrase which is intentionally left non-specific, but which it intended to connote any and all forms of “response variable” and other “pre-specified outputs” such as categorical labels or validation data, along with outputs which may not necessarily be able to be pre-specified in simple uni- or multi-variate form, such as measures of distance between sets of training and validation data.

Such “desired outputs” are presumed to be quantified in terms of a “loss” or “cost” function (hereafter, simply “loss function”) quantifying some measure of distance between a model estimate (resulting from applying the model to one or more components of a training data set) and a pre-defined “valid” output (during training), or a test data set (following training).

Given the foregoing considerations, we consider a typical ML workflow to progress through (at least some of) the following steps:

1.  ***Input Data Specification*** Obtain a local copy of input data, often as multiple *objects* (either on-disk or in memory) in some suitably structured form such as in a series of sub-directories or accompanied by additional data defining the structural properties of input objects. Regardless of form, multiple objects are commonly given generic labels which distinguish between `training` and `test` data, along with optional additional categories and labels such as `validation` data used, for example, to determine accuracy of models applied to training data yet prior to testing.
2.  ***Pre-Processing*** Define transformations of input data, including but not restricted to, broadcasting dimensions (as defined below) and standardising data ranges (typically to defined values of mean and standard deviation).
3.  ***Model and Algorithm Specification*** Specify the model and associated processes which will be applied to map the input data on to the desired output. This step minimally includes the following distinct stages (generally in no particular order):
    1.  Specify the kind of model which will be applied to the training data. ML software often allows the use of pre-trained models, in which case this this step includes downloading or otherwise obtaining a pre-trained model, along with specification of which aspects of those models are to be modified through application to a particular set of training and validation data.
    2.  Specify the kind of algorithm which will be used to explore the search space (for example some kind of gradient descent algorithm), along with parameters controlling how that algorithm will be applied (for example a learning rate, as defined above).
    3.  Specify the kind of loss function will be used to quantify distance between model estimates and desired output.
4.  ***Model Training*** Apply the specified model to the training data to generate a series of estimates from the specified loss function. This stage may also include specifying parameters such as stopping or exit criteria, and parameters controlling batch processing of input data. Moreover, this stage may involve retaining some of the following additional data:
    1.  Potential “pre-processing” stages such as initial estimates of optimal learning rates (see above).
    2.  Details of summaries of actual paths taken through the search space towards convergence on local or global minimum.
5.  ***Model Output and Performance*** Measure the performance of the trained model when applied to the test data set, generally requiring the specification of a metric of model performance or accuracy.

Importantly, ML workflows may be partly iterative. This may in turn potentially confound distinctions between training and test data, and accordingly confound expectations commonly placed upon statistical analyses of statistical independence of response variables. ML routines such as cross-validation repeatedly (re-)partition data between training and test sets. Resultant models can then not be considered to have been developed through application to any single set of truly “independent” data. In the context of the standards that follow, these considerations admit a potential lack of clarity in any notional categorical distinction between training and test data, and between model specification and training.

The preceding workflow mentioned a couple of concepts the interpretations of which in the context of these standards may be seen by clicking on the corresponding items below. Following that, we proceed to standards for ML software, enumerated and developed with reference to the preceding workflow steps. In order that the following standards initially adhere to the enumeration of workflow steps given above, more general standards pertaining to aspects such as documentation and testing are given following the initial five “workflow” standards.

Click for a definition of *broadcasting*, referred to in Step 2, above.

The following definition comes from a vignette for the [`rray` package](https://github.com/r-lib/rray) named [*Broadcasting*](https://rray.r-lib.org/articles/broadcasting.html).

- ***Broadcasting*** is, “repeating the dimensions of one object to match the dimensions of another.”

This concept runs counter to aspects of standards in other categories, which often suggest that functions should error when passed input objects which do not have commensurate dimensions. Broadcasting is a pre-processing step which enables objects with incommensurate dimensions to be dimensionally reconciled.

The following demonstration is taken directly from the [`rray` package](https://github.com/r-lib/rray) (which is not currently on CRAN).

Broadcasting is commonly employed in ML software because it enables ML operations to be implemented on objects with incommensurate dimensions. One example is image analysis, in which training data may all be dimensionally commensurate, yet test images may have different dimensions. Broadcasting allows data to be submitted to ML routines regardless of potentially incommensurate dimensions.

Click for a definition of *learning rate*, referred to in Step 5, above.

- ***Learning Rate*** (generally) determines the step size used to search for local optima as a fraction of the local gradient.

This parameter is particularly important for training ML algorithms like neural networks, the results of which can be very sensitive to variations in learning rates. A useful overview of the importance of learning rates, and a useful approach to automatically determining appropriate values, is given in [this blog post](https://sgugger.github.io/how-do-you-find-a-good-learning-rate.html).

\

Partly because of widespread and current relevance, the category of Machine Learning software is one for which there have been other notable attempts to develop standards. A particularly useful reference is the [MLPerf organization](https://www.mlperf.org/) which, among other activities, hosts several [github repositories](https://github.com/mlperf) providing reference datasets and benchmark conditions for comparing performance aspects of ML software. While such reference or benchmark standards are not explicitly referred to in the current version of the following standards, we expect them to be gradually adapted and incorporated as we start to apply and refine our standards in application to software submitted to our review system.

### 6.4.1 Input Data Specification

Many of the following standards refer to the labelling of input data as “testing” or “training” data, along with potentially additional labels such as “validation” data. In regard to such labelling, the following two standards apply,

- **ML1.0** *Documentation should make a clear conceptual distinction between training and test data (even where such may ultimately be confounded as described above.)*
  - **ML1.0a** *Where these terms are ultimately eschewed, these should nevertheless be used in initial documentation, along with clear explanation of, and justification for, alternative terminology.*
- **ML1.1** *Absent clear justification for alternative design decisions, input data should be expected to be labelled “test”, “training”, and, where applicable, “validation” data.*
  - **ML1.1a** *The presence and use of these labels should be explicitly confirmed via pre-processing steps (and tested in accordance with **ML7.0**, below).*
  - **ML1.1b** *Matches to expected labels should be case-insensitive and based on partial matching such that, for example, “Test”, “test”, or “testing” should all suffice.*

The following three standards (**ML1.2**–**ML1.4**) represent three possible design intentions for ML software. Only one of these three will generally be applicable to any one piece of software, although it is nevertheless possible that more than one of these standards may apply. The first of these three standards applies to ML software which is intended to process, or capable of processing, input data as a single (generally tabular) object.

- **ML1.2** *Training and test data sets for ML software should be able to be input as a single, generally tabular, data object, with the training and test data distinguished either by*
  - *A specified variable containing, for example, `TRUE`/`FALSE` or `0`/`1` values, or which uses some other system such as missing (`NA`) values to denote test data); and/or*
  - *An additional parameter designating case or row numbers, or labels of test data.*

The second of these three standards applies to ML software which is intended to process, or capable of processing, input data represented as multiple objects which exist in local memory.

- **ML1.3** *Input data should be clearly partitioned between training and test data (for example, through having each passed as a distinct `list` item), or should enable an additional means of categorically distinguishing training from test data (such as via an additional parameter which provides explicit labels). Where applicable, distinction of validation and any other data should also accord with this standard.*

The third of these three standards for data input applies to ML software for which data are expected to be input as references to multiple external objects, generally expected to be read from either local or remote connections.

- **ML1.4** *Training and test data sets, along with other necessary components such as validation data sets, should be stored in their own distinctly labelled sub-directories (for distinct files), or according to an explicit and distinct labelling scheme (for example, for database connections). Labelling should in all cases adhere to **ML1.1**, above.*

The following standard applies to all ML software regardless of the applicability or otherwise of the preceding three standards.

- **ML1.5** *ML software should implement a single function which summarises the contents of test and training (and other) data sets, minimally including counts of numbers of cases, records, or files, and potentially extending to tables or summaries of file or data types, sizes, and other information (such as unique hashes for each component).*

#### 6.4.1.1 Missing Values

Missing data are handled differently by different ML routines, and it is also difficult to suggest generally applicable standards for pre-processing missing values in ML software. The [*General Standards*](#general-standards) for missing values (**G2.13**–**G2.16**) do not apply to Machine Learning software, in the place of which the following standards attempt to cover a practical range of typical approaches and applications.

- **ML1.6** *ML software which does not admit missing values, and which expects no missing values, should implement explicit pre-processing routines to identify whether data has any missing values, and should generally error appropriately and informatively when passed data with missing values. In addition, ML software which does not admit missing values should:*
  - **ML1.6a** *Explain why missing values are not admitted.*
  - **ML1.6b** *Provide explicit examples (in function documentation, vignettes, or both) for how missing values may be imputed, rather than simply discarded.*
- **ML1.7** *ML software which admits missing values should clearly document how such values are processed.*
  - **ML1.7a** *Where missing values are imputed, software should offer multiple user-defined ways to impute missing data.*
  - **ML1.7b** *Where missing values are imputed, the precise imputation steps should also be explicitly documented, either in tests (see **ML7.2** below), function documentation, or vignettes.*
- **ML1.8** *ML software should enable equal treatment of missing values for both training and test data, with optional user ability to control application to either one or both.*

### 6.4.2 Pre-processing

As reflected in the workflow envisioned at the outset, ML software operates somewhat differently to statistical software in many other categories. In particular, ML software often requires explicit specification of a workflow, including specification of input data (as per the standards of the preceding sub-section), and of both transformations and statistical models to be applied to those data. This section of standards refers exclusively to the transformation of input data as a pre-processing step prior to any specification of, or submission to, actual models.

- **ML2.0** *A dedicated function should enable pre-processing steps to be defined and parametrized.*
  - **ML2.0a** *That function should return an object which can be directly submitted to a specified model (see section 3, below).*
  - **ML2.0b** *Absent explicit justification otherwise, that return object should have a defined class minimally intended to implement a default `print` method which summarizes the input data set (as per **ML1.5** above) and associated transformations (see the following standard).*

Standards for most other categories of statistical software suggest that pre-processing routines should ensure that input data sets are commensurate, for example, through having equal numbers of cases or rows. In contrast, ML software is commonly intended to accept input data which can not be guaranteed to be dimensionally commensurate, such as software intended to process rectangular image files which may be of different sizes.

- **ML2.1** *ML software which uses broadcasting to reconcile dimensionally incommensurate input data should offer an ability to at least optionally record transformations applied to each input file.*

Beyond broadcasting and dimensional transformations, the following standards apply to the pre-processing stages of ML software.

- **ML2.2** *ML software which requires or relies upon numeric transformations of input data (such as change in mean values or variances) should allow optimal explicit specification of target values, rather than restricting transformations to default generic values only (such as transformations to z-scores).*
  - **ML2.2a** *Where the parameters have default values, reasons for those particular defaults should be explicitly described.*
  - **ML2.2b** *Any extended documentation (such as vignettes) which demonstrates the use of explicit values for numeric transformations should explicitly describe why particular values are used.*

For all transformations applied to input data, whether of dimension (**ML2.1**) or scale (**ML2.2**),

- **ML2.3** *The values associated with all transformations should be recorded in the object returned by the function described in the preceding standard (**ML2.0**).*
- **ML2.4** *Default values of all transformations should be explicitly documented, both in documentation of parameters where appropriate (such as for numeric transformations), and in extended documentation such as vignettes.*
- **ML2.5** *ML software should provide options to bypass or otherwise switch off all default transformations.*
- **ML2.6** *Where transformations are implemented via distinct functions, these should be exported to a package’s namespace so they can be applied in other contexts.*
- **ML2.7** *Where possible, documentation should be provided for how transformations may be reversed. For example, documentation may demonstrate how the values retained via **ML2.3**, above, can be used along with transformations either exported via **ML2.6** or otherwise exemplified in demonstration code to independently transform data, and then to reverse those transformations.*

### 6.4.3 Model and Algorithm Specification

A “model” in the context of ML software is understood to be a means of specifying a mapping between input and output data, generally applied to training and validation data. Model specification is the step of specifying *how* such a mapping is to be constructed. The specification of *what* the values of such a model actually are occurs through training the model, and is described in the following sub-section. These standards also refer to *control parameters* which specify how models are trained. These parameters commonly include values specifying numbers of iterations, training rates, and parameters controlling algorithmic processes such as re-sampling or cross-validation.

- **ML3.0** *Model specification should be implemented as a distinct stage subsequent to specification of pre-processing routines (see Section 2, above) and prior to actual model fitting or training (see Section 4, below). In particular,*
  - **ML3.0a** *A dedicated function should enable models to be specified without actually fitting or training them, or if this (**ML3**) and the following (**ML4**) stages are controlled by a single function, that function should have a parameter enabling models to be specified yet not fitted (for example, `nofit = FALSE`).*
  - **ML3.0b** *That function should accept as input the objects produced by the previous Input Data Specification stage, and defined according to **ML2.0**, above.*
  - **ML3.0c** *The function described above (**ML3.0a**) should return an object which can be directly trained as described in the following sub-section (**ML4**).*
  - **ML3.0d** *That return object should have a defined class minimally intended to implement a default `print` method which summarises the model specification, including values of all relevant parameters.*
- **ML3.1** *ML software should allow the use of both untrained models, specified through model parameters only, as well as pre-trained models. Use of the latter commonly entails an ability to submit a previously-trained model object to the function defined according to **ML3.0a**, above.*
- **ML3.2** *ML software should enable different models to be applied to the object specifying data inputs and transformations (see sub-sections 1–2, above) without needing to re-define those preceding steps.*

A function fulfilling **ML3.0–3.2** might, for example, permit the following arguments:

1.  `data`: Input data specification constructed according to **ML1**
2.  `model`: An optional previously-trained model
3.  `control`: A list of parameters controlling how the model algorithm is to be applied during the subsequent training phase (**ML4**).

A function with the arguments defined above would fulfil the preceding three standards, because the `data` stage would represent the output of **ML1**, while the `model` stage would allow for different pre-trained models to be submitted using the same data and associated specifications (**ML3.1**). The provision of a separate `.data` argument would fulfil **ML3.2** by allowing one or both `model` or `control` parameters to be re-defined while submitting the same `data` object.

- **ML3.3** *Where ML software implements its own distinct classes of model objects, the properties and behaviours of those specific classes of objects should be explicitly compared with objects produced by other ML software. In particular, where possible, ML software should provide extended documentation (as vignettes or equivalent) comparing model objects with those from other ML software, noting both unique abilities and restrictions of any implemented classes.*
- **ML3.4** *Where training rates are used, ML software should provide explicit documentation both in all functions which use training rates, and in extended form such as vignettes, of the importance of, and/or sensitivity to, different values of training rates. In particular,*
  - **ML3.4a** *Unless explicitly justified otherwise, ML software should offer abilities to automatically determine appropriate or optimal training rates, either as distinct pre-processing stages, or as implicit stages of model training.*
  - **ML3.4b** *ML software which provides default values for training rates should clearly document anticipated restrictions of validity of those default values; for example through clear suggestions that user-determined and -specified values may generally be necessary or preferable.*

#### 6.4.3.1 Control Parameters

Control parameters are considered here to specify how a model is to be applied to a set of training data. These are generally distinct from parameters specifying the actual model (such as model architecture). While we recommend that control parameters be submitted as items of a single named list, this is neither a firm expectation nor an explicit part of the current standards.

- **ML3.5** *Parameters controlling optimization algorithms should minimally include:*
  - **ML3.5a** *Specification of the type of algorithm used to explore the search space (commonly, for example, some kind of gradient descent algorithm)*
  - **ML3.5b** *The kind of loss function used to assess distance between model estimates and desired output.*
- **ML3.6** *Unless explicitly justified otherwise (for example because ML software under consideration is an implementation of one specific algorithm), ML software should:*
  - **ML3.6a** *Implement or otherwise permit usage of multiple ways of exploring search space*
  - **ML3.6b** *Implement or otherwise permit usage of multiple loss functions.*

#### 6.4.3.2 CPU and GPU processing

ML software often involves manipulation of large numbers of rectangular arrays for which graphics processing units (GPUs) are often more efficient than central processing units (CPUs). ML software thus commonly offers options to train models using either CPUs or GPUs. While these standards do not currently suggest any particular design choice in this regard, we do note the following:

- **ML3.7** *For ML software in which algorithms are coded in C++, user-controlled use of either CPUs or GPUs (on NVIDIA processors at least) should be implemented through direct use of [`libcudacxx`](https://github.com/NVIDIA/libcudacxx).*

This library can be “switched on” through activating a single C++ header file to switch from CPU to GPU.

### 6.4.4 Model Training

Model training is the stage of the ML workflow envisioned here in which the actual computation is performed by applying a model specified according to **ML3** to data specified according to **ML1** and **ML2**.

- **ML4.0** *ML software should generally implement a unified single-function interface to model training, able to receive as input a model specified according to all preceding standards. In particular, models with categorically different specifications, such as different model architectures or optimization algorithms, should be able to be submitted to the same model training function.*
- **ML4.1** *ML software should at least optionally retain explicit information on paths taken as an optimizer advances towards minimal loss. Such information should minimally include:*
  - **ML4.1a** *Specification of all model-internal parameters, or equivalent hashed representation.*
  - **ML4.1b** *The value of the loss function at each point*
  - **ML4.1c** *Information used to advance to next point, for example quantification of local gradient.*
- **ML4.2** *The subsequent extraction of information retained according to the preceding standard should be explicitly documented, including through example code.*

#### 6.4.4.1 Batch Processing

The following standards apply to ML software which implements batch processing, commonly to train models on data sets too large to be loaded in their entirety into memory.

- **ML4.3** *All parameters controlling batch processing and associated terminology should be explicitly documented, and it should not, for example, be presumed that users will understand the definition of “epoch” as implemented in any particular ML software.*

According to that standard, it would for example be inappropriate to have a parameter, `nepochs`, described as “Number of epochs used in model training”. Rather, the definition and particular implementation of “epoch” must be explicitly defined.

- **ML4.4** *Explicit guidance should be provided on selection of appropriate values for parameter controlling batch processing, for example, on trade-offs between batch sizes and numbers of epochs (with both terms provided as Control Parameters in accordance with the preceding standard, **ML3**).*
- **ML4.5** *ML software may optionally include a function to estimate likely time to train a specified model, through estimating initial timings from a small sample of the full batch.*
- **ML4.6** *ML software should by default provide explicit information on the progress of batch jobs (even where those jobs may be implemented in parallel on GPUs). That information may be optionally suppressed through additional parameters.*

#### 6.4.4.2 Re-sampling

As described at the outset, ML software does not always rely on pre-specified and categorical distinctions between training and test data. For example, models may be fit to what is effectively one single data set in which specified cases or rows are used as training data, and the remainder as test data. Re-sampling generally refers to the practice of re-defining categorical distinctions between training and test data. One training run accordingly connotes training a model on one particular set of training data and then applying that model to the specified set of test data. Re-sampling starts that process anew, through constructing an alternative categorical partition between test and training data.

Even where test and training data are distinguished by more than a simple data-internal category (such as a labelling column), for example, by being stored in distinctly-named sub-directories, re-sampling may be implemented by effectively shuffling data between training and test sub-directories.

- **ML4.7** *ML software should provide an ability to combine results from multiple re-sampling iterations using a single parameter specifying numbers of iterations.*
- **ML4.8** *Absent any additional specification, re-sampling algorithms should by default partition data according to proportions of original test and training data.*
  - **ML4.8a** *Re-sampling routines of ML software should nevertheless offer an ability to explicitly control or override such default proportions of test and training data.*

### 6.4.5 Model Output and Performance

Model output is considered here as a stage distinct from model performance. Model output refers to the end result of model training (**ML4**), while model performance involves the assessment of a trained model against a test data set. The present section first describes standards for model output, which are standards guiding the form of a model trained according to the preceding standards (**ML4**). Model Performance is then considered as a separate stage.

#### 6.4.5.1 Model Output

- **ML5.0** *The result of applying the training processes described above should be contained within a single model object returned by the function defined according to **ML4.0**, above. Even where the output reflects application to a test data set, the resultant object need not include any information on model performance (see **ML5.3**–**ML5.4**, below).*
  - **ML5.0a** *That object should either have its own class, or extend some previously-defined class.*
  - **ML5.0b** *That class should have a defined `print` method which summarises important aspects of the model object, including but not limited to summaries of input data and algorithmic control parameters.*
- **ML5.1** *As for the untrained model objects produced according to the above standards, and in particular as a direct extension of **ML3.3**, the properties and behaviours of trained models produced by ML software should be explicitly compared with equivalent objects produced by other ML software. (Such comparison will generally be done in terms of comparing model performance, as described in the following standard **ML5.3**–**ML5.4**).*
- **ML5.2** *The structure and functionality of objects representing trained ML models should be thoroughly documented. In particular,*
  - **ML5.2a** *Either all functionality extending from the class of model object should be explicitly documented, or a method for listing or otherwise accessing all associated functionality explicitly documented and demonstrated in example code.*
  - **ML5.2b** *Documentation should include examples of how to save and re-load trained model objects for their re-use in accordance with **ML3.1**, above.*
  - **ML5.2c** *Where general functions for saving or serializing objects, such as [`saveRDS`](https://stat.ethz.ch/R-manual/R-devel/library/base/html/readRDS.html) are not appropriate for storing local copies of trained models, an explicit function should be provided for that purpose, and should be demonstrated with example code.*

The [`R6` system](https://r6.r-lib.org) for representing classes in R is an example of a system with explicit functionality, all components of which are accessible by a simple [`ls()`](https://stat.ethz.ch/R-manual/R-devel/library/base/html/ls.html) call. Adherence to **ML5.2a** would nevertheless require explicit description of the ability of [`ls()`](https://stat.ethz.ch/R-manual/R-devel/library/base/html/ls.html) to supply a list of all functions associated with an object. The [`mlr` package](https://github.com/mlr-org/mlr3), for example, uses [`R6` classes](https://r6.r-lib.org), yet neither explicitly describes the use of [`ls()`](https://stat.ethz.ch/R-manual/R-devel/library/base/html/ls.html) to list all associated functions, nor explicitly lists those functions.

#### 6.4.5.2 Model Performance

Model performance refers to the quantitative assessment of a trained model when applied to a set of test data.

- **ML5.3** *Assessment of model performance should be implemented as one or more functions distinct from model training.*
- **ML5.4** *Model performance should be able to be assessed according to a variety of metrics.*
  - **ML5.4a** *All model performance metrics represented by functions internal to a package must be clearly and distinctly documented.*
  - **ML5.4b** *It should be possible to submit custom metrics to a model assessment function, and the ability to do so should be clearly documented including through example code.*

The remaining sub-sections specify general standards beyond the preceding workflow-specific ones.

### 6.4.6 Documentation

- **ML6.0** *Descriptions of ML software should make explicit reference to a workflow which separates training and testing stages, and which clearly indicates a need for distinct training and test data sets.*

The following standard applies to packages which are intended or other able to only encompass a restricted subset of the six primary workflow steps enumerated at the outset. Envisioned here are packages explicitly intended to aid one particular aspect of the general workflow envisioned here, such as implementations of ML optimization functions, or specific loss measures.

- **ML6.1** *ML software intentionally designed to address only a restricted subset of the workflow described here should clearly document how it can be embedded within a typical full ML workflow in the sense considered here.*
  - **ML6.1a** *Such demonstrations should include and contrast embedding within a full workflow using at least two other packages to implement that workflow.*

### 6.4.7 Testing

#### 6.4.7.1 Input Data

- **ML7.0** *Test should explicitly confirm partial and case-insensitive matching of “test”, “train”, and, where applicable, “validation” data.*
- **ML7.1** *Tests should demonstrate effects of different numeric scaling of input data (see **ML2.2**).*
- **ML7.2** *For software which imputes missing data, tests should compare internal imputation with explicit code which directly implements imputation steps (even where such imputation is a single-step implemented via some external package). These tests serve as an explicit reference for how imputation is performed.*

#### 6.4.7.2 Model Classes

The following standard applies to models in both untrained and trained forms, considered to be the respective outputs of the preceding standards **ML3** and **ML4**.

- **ML7.3** *Where model objects are implemented as distinct classes, tests should explicitly compare the functionality of these classes with functionality of equivalent classes for ML model objects from other packages.*
  - **ML7.3a** *These tests should explicitly identify restrictions on the functionality of model objects in comparison with those of other packages.*
  - **ML7.3b** *These tests should explicitly identify functional advantages and unique abilities of the model objects in comparison with those of other packages.*

#### 6.4.7.3 Model Training

- **ML7.4** *ML software should explicit document the effects of different training rates, and in particular should demonstrate divergence from optima with inappropriate training rates.*
- **ML7.5** *ML software which implements routines to determine optimal training rates (see **ML3.4**, above) should implement tests to confirm the optimality of resultant values.*
- **ML7.6** *ML software which implement independent training “epochs” should demonstrate in tests the effects of lesser versus greater numbers of epochs.*
- **ML7.7** *ML software should explicitly test different optimization algorithms, even where software is intended to implement one specific algorithm.*
- **ML7.8** *ML software should explicitly test different loss functions, even where software is intended to implement one specific measure of loss.*
- **ML7.9** *Tests should explicitly compare all possible combinations in categorical differences in model architecture, such as different model architectures with same optimization algorithms, same model architectures with different optimization algorithms, and differences in both.*
  - **ML7.9a** *Such combinations will generally be formed from multiple categorical factors, for which explicit use of functions such as [`expand.grid()`](https://stat.ethz.ch/R-manual/R-devel/library/base/html/expand.grid.html) is recommended.*

The following example illustrates:

        Var1 Var2  Var3
    1  archA optA costA
    2  archB optA costA
    3  archA optB costA
    4  archB optB costA
    5  archA optC costA
    6  archB optC costA
    7  archA optA costB
    8  archB optA costB
    9  archA optB costB
    10 archB optB costB
    11 archA optC costB
    12 archB optC costB
    13 archA optA costC
    14 archB optA costC
    15 archA optB costC
    16 archB optB costC
    17 archA optC costC
    18 archB optC costC

All possible combinations of these categorical parameters could then be tested by iterating over the rows of that output.

- **ML7.10** *The successful extraction of information on paths taken by optimizers (see **ML5.1**, above), should be tested, including testing the general properties, but not necessarily actual values of, such data.*

#### 6.4.7.4 Model Performance

- **ML7.11** *All performance metrics available for a given class of trained model should be thoroughly tested and compared.*
  - **ML7.11a** *Tests which compare metrics should do so over a range of inputs (generally implying differently trained models) to demonstrate relative advantages and disadvantages of different metrics.*

------------------------------------------------------------------------

## 6.5 Regression and Supervised Learning

This sub-section details standards for Regression and Supervised Learning Software – referred to from here on for simplicity as “Regression Software”. Regression Software implements algorithms which aim to construct or analyse one or more mappings between two defined data sets (for example, a set of “independent” data, \\X\\, and a set of “dependent” data, \\Y\\). In contrast, the analogous category of Unsupervised Learning Software aims to construct or analyse one or more mappings between a defined set of input or independent data, and a second set of “output” data which are not necessarily known or given prior to the analysis.

Common purposes of Regression Software are to fit models to estimate relationships or to make predictions between specified inputs and outputs. Regression Software includes tools with inferential or predictive foci, Bayesian, frequentist, or probability-free Machine Learning (ML) approaches, parametric or or non-parametric approaches, discrete outputs (such as in classification tasks) or continuous outputs, and models and algorithms specific to applications or data such as time series or spatial data. In many cases other standards specific to these subcategories may apply.

Examples of the diversity of Regression and Unsupervised Learning software include the following.

1.  [`xrnet`](https://joss.theoj.org/papers/10.21105/joss.01761) to perform “hierarchical regularized regression to incorporate external data”, where “external data” in this case refers to structured meta-data as applied to genomic features.
2.  [`survPen`](https://joss.theoj.org/papers/10.21105/joss.01434) is, “an R package for hazard and excess hazard modelling with multidimensional penalized splines”
3.  [`areal`](https://joss.theoj.org/papers/10.21105/joss.01221) is, “an R package for areal weighted interpolation”.
4.  [`ChiRP`](https://joss.theoj.org/papers/10.21105/joss.01287) is a package for “Chinese Restaurant Process mixtures for regression and clustering”, which implements a class of non-parametric Bayesian Monte Carlo models.
5.  [`klrfome`](https://joss.theoj.org/papers/10.21105/joss.00722) is a package for, “kernel logistic regression on focal mean embeddings,” with a specific and exclusive application to the prediction of likely archaeological sites.
6.  [`gravity`](https://joss.theoj.org/papers/10.21105/joss.01038) is a package for “estimation methods for gravity models in R,” where “gravity models” refers to models of spatial interactions between point locations based on the properties of those locations.
7.  [`compboost`](https://joss.theoj.org/papers/10.21105/joss.00967) is an example of an R package for gradient boosting, which is inherently a regression-based technique, and so standards for regression software ought to consider such applications.
8.  [`ungroup`](https://joss.theoj.org/papers/10.21105/joss.00937) is, “an R package for efficient estimation of smooth distributions from coarsely binned data.” As such, this package is an example of regression-based software for which the input data are (effectively) categorical. The package is primarily intended to implement a particular method for “unbinning” the data, and so represents a particular class of interpolation methods.
9.  [`registr`](https://joss.theoj.org/papers/10.21105/joss.00557) is a package for “registration for exponential family functional data,” where registration in this context is effectively an interpolation method applied within a functional data analysis context.
10. [`ggeffects`](https://joss.theoj.org/papers/10.21105/joss.00772) for “tidy data frames of marginal effects from regression models.” This package aims to make statistics quantifying marginal effects readily understandable, and so implements a standard (tidyverse-based) methodology for representing and visualising statistics relating to marginal effects.

Click on the following link to view a demonstration [Application of Regression and Supervised Learning Standards](https://hackmd.io/VZ-wgQtZRV2pb-wFZNDM5g).

The following standards are divided among several sub-categories, with each standard prefixed with “RE”.

### 6.5.1 Input data structures and validation

- **RE1.0** *Regression Software should enable models to be specified via a formula interface, unless reasons for not doing so are explicitly documented.*
- **RE1.1** *Regression Software should document how formula interfaces are converted to matrix representations of input data.*

See Max Kuhn’s [RStudio blog post](https://rviews.rstudio.com/2017/02/01/the-r-formula-method-the-good-parts/) for examples of how to implement and describe such conversions.

- **RE1.2** *Regression Software should document expected format (types or classes) for inputting predictor variables, including descriptions of types or classes which are not accepted.*

Examples documentation addressing this standard include clarifying that software accepts only numeric inputs in `vector` or `matrix` form, or that all inputs must be in `data.frame` form with both column and row names.

- **RE1.3** *Regression Software which passes or otherwise transforms aspects of input data onto output structures should ensure that those output structures retain all relevant aspects of input data, notably including row and column names, and potentially information from other [`attributes()`](https://rdrr.io/r/base/attributes.html).*
  - **RE1.3a** *Where otherwise relevant information is not transferred, this should be explicitly documented.*

This standard reflects the common process in regression software of transforming a rectangular input structure into a modified version which includes additional columns of model fits or predictions. Software which constructs such modified versions anew often copies numeric values from input columns, and may implicitly drop additional information such as attributes. This standard requires all such information to be retained.

- **RE1.4** *Regression Software should document any assumptions made with regard to input data; for example distributional assumptions, or assumptions that predictor data have mean values of zero. Implications of violations of these assumptions should be both documented and tested.*

### 6.5.2 Pre-processing and Variable Transformation

- **RE2.0** *Regression Software should document any transformations applied to input data, for example conversion of label-values to `factor`, and should provide ways to explicitly avoid any default transformations (with error or warning conditions where appropriate).*
- **RE2.1** *Regression Software should implement explicit parameters controlling the processing of missing values, ideally distinguishing `NA` or `NaN` values from `Inf` values (for example, through use of [`na.omit()`](https://rdrr.io/r/stats/na.fail.html) and related functions from the `stats` package).*

Note that fulfilling this standard ensures compliance with all *General Standard* for missing values (**G2.13**–**G2.16**).

- **RE2.2** *Regression Software should provide different options for processing missing values in predictor and response data. For example, it should be possible to fit a model with no missing predictor data in order to generate values for all associated response points, even where submitted response values may be missing.*
- **RE2.3** *Where applicable, Regression Software should enable data to be centred (for example, through converting to zero-mean equivalent values; or to z-scores) or offset (for example, to zero-intercept equivalent values) via additional parameters, with the effects of any such parameters clearly documented and tested.*
- **RE2.4** *Regression Software should implement pre-processing routines to identify whether aspects of input data are perfectly collinear, notably including:*
  - **RE2.4a** *Perfect collinearity among predictor variables*
  - **RE2.4b** *Perfect collinearity between independent and dependent variables*

These pre-processing routines should also be tested as described below.

### 6.5.3 Algorithms

The following standards apply to the model fitting algorithms of Regression Software which implement or rely on iterative algorithms which are expected to converge to generate model statistics. Regression Software which implements or relies on iterative convergence algorithms should:

- **RE3.0** *Issue appropriate warnings or other diagnostic messages for models which fail to converge.*
- **RE3.1** *Enable such messages to be optionally suppressed, yet should ensure that the resultant model object nevertheless includes sufficient data to identify lack of convergence.*
- **RE3.2** *Ensure that convergence thresholds have sensible default values, demonstrated through explicit documentation.*
- **RE3.3** *Allow explicit setting of convergence thresholds, unless reasons against doing so are explicitly documented.*

### 6.5.4 Return Results

- **RE4.0** *Regression Software should return some form of “model” object, generally through using or modifying existing class structures for model objects (such as `lm`, `glm`, or model objects from other packages), or creating a new class of model objects.*
- **RE4.1** *Regression Software may enable an ability to generate a model object without actually fitting values. This may be useful for controlling batch processing of computationally intensive fitting algorithms.*

#### 6.5.4.1 Accessor Methods

Regression Software should provide functions to access or extract as much of the following kinds of model data as possible or practicable. Access should ideally rely on class-specific methods which extend, or implement otherwise equivalent versions of, the methods from the `stats` package which are named in parentheses in each of the following standards.

Model objects should include, or otherwise enable effectively immediate access to the following descriptors. It is acknowledged that not all regression models can sensibly provide access to these descriptors, yet should include access provisions to all those that are applicable.

- **RE4.2** *Model coefficients (via [`coef()`](https://rdrr.io/r/stats/coef.html) / [`coefficients()`](https://rdrr.io/r/stats/coef.html))*
- **RE4.3** *Confidence intervals on those coefficients (via [`confint()`](https://rdrr.io/r/stats/confint.html))*
- **RE4.4** *The specification of the model, generally as a formula (via [`formula()`](https://rdrr.io/r/stats/formula.html))*
- **RE4.5** *Numbers of observations submitted to model (via [`nobs()`](https://rdrr.io/r/stats/nobs.html))*
- **RE4.6** *The variance-covariance matrix of the model parameters (via [`vcov()`](https://rdrr.io/r/stats/vcov.html))*
- **RE4.7** *Where appropriate, convergence statistics*

Note that compliance with **RE4.6** should also heed *General Standard* **G3.1** in offering user control over covariance algorithms. Regression Software should further provide simple and direct methods to return or otherwise access the following form of data and metadata, where the latter includes information on any transformations which may have been applied to the data prior to submission to modelling routines.

- **RE4.8** *Response variables, and associated “metadata” where applicable.*
- **RE4.9** *Modelled values of response variables.*
- **RE4.10** *Model Residuals, including sufficient documentation to enable interpretation of residuals, and to enable users to submit residuals to their own tests.*
- **RE4.11** *Goodness-of-fit and other statistics associated such as effect sizes with model coefficients.*
- **RE4.12** *Where appropriate, functions used to transform input data, and associated inverse transform functions.*

Regression software may additionally opt to provide simple and direct methods to return or otherwise access the following:

- **RE4.13** *Predictor variables, and associated “metadata” where applicable.*

#### 6.5.4.2 Prediction, Extrapolation, and Forecasting

Not all regression software is intended to, or can, provide distinct abilities to extrapolate or forecast. Moreover, identifying cases in which a regression model is used to extrapolate or forecast may often be a non-trivial exercise. It may nevertheless be possible, for example when input data used to construct a model are unidimensional, and data on which a prediction is to be based extend beyond the range used to construct the model. Where reasonably unambiguous identification of extrapolation or forecasting using a model is possible, the following standards apply:

- **RE4.14** *Where possible, values should also be provided for extrapolation or forecast* errors*.*
- **RE4.15** *Sufficient documentation and/or testing should be provided to demonstrate that forecast errors, confidence intervals, or equivalent values increase with forecast horizons.*

Distinct from extrapolation or forecasting abilities, the following standard applies to regression software which relies on, or otherwise provides abilities to process, categorical grouping variables:

- **RE4.16** *Regression Software which models distinct responses for different categorical groups should include the ability to submit new groups to [`predict()`](https://rdrr.io/r/stats/predict.html) methods.*

#### 6.5.4.3 Reporting Return Results

- **RE4.17** *Model objects returned by Regression Software should implement or appropriately extend a default `print` method which provides an on-screen summary of model (input) parameters and (output) coefficients.*
- **RE4.18** *Regression Software may also implement `summary` methods for model objects, and in particular should implement distinct `summary` methods for any cases in which calculation of summary statistics is computationally non-trivial (for example, for bootstrapped estimates of confidence intervals).*

### 6.5.5 Documentation

Beyond the [*General Standards*](#general-standards) for documentation, Regression Software should explicitly describe the following aspects, and ideally provide extended documentation including summary graphical reports of:

- **RE5.0** *Scaling relationships between sizes of input data (numbers of observations, with potential extension to numbers of variables/columns) and speed of algorithm.*

### 6.5.6 Visualization

- **RE6.0** *Model objects returned by Regression Software (see* **RE4***) should have default `plot` methods, either through explicit implementation, extension of methods for existing model objects, or through ensuring default methods work appropriately.*
- **RE6.1** *Where the default `plot` method is **NOT** a generic `plot` method dispatched on the class of return objects (that is, through an S3-type `plot.<myclass>` function or equivalent), that method dispatch (or equivalent) should nevertheless exist in order to explicitly direct users to the appropriate function.*
- **RE6.2** *The default `plot` method should produce a plot of the `fitted` values of the model, with optional visualisation of confidence intervals or equivalent.*

The following standard applies only to software fulfilling RE4.14-4.15, and the conditions described prior to those standards.

- **RE6.3** *Where a model object is used to generate a forecast (for example, through a [`predict()`](https://rdrr.io/r/stats/predict.html) method), the default `plot` method should provide clear visual distinction between modelled (interpolated) and forecast (extrapolated) values.*

### 6.5.7 Testing

#### 6.5.7.1 Input Data

Tests for Regression Software should include the following conditions and cases:

- **RE7.0** *Tests with noiseless, exact relationships between predictor (independent) data.*
  - **RE7.0a** In particular, these tests should confirm ability to reject perfectly noiseless input data.
- **RE7.1** *Tests with noiseless, exact relationships between predictor (independent) and response (dependent) data.*
  - **RE7.1a** *In particular, these tests should confirm that model fitting is at least as fast or (preferably) faster than testing with equivalent noisy data (see RE2.4b).*

#### 6.5.7.2 Return Results

Tests for Regression Software should

- **RE7.2** Demonstrate that output objects retain aspects of input data such as row or case names (see **RE1.3**).
- **RE7.3** Demonstrate and test expected behaviour when objects returned from regression software are submitted to the accessor methods of **RE4.2**–**RE4.7**.
- **RE7.4** Extending directly from **RE4.15**, where appropriate, tests should demonstrate and confirm that forecast errors, confidence intervals, or equivalent values increase with forecast horizons.

------------------------------------------------------------------------

## 6.6 Spatial Software

Standards for spatial software begin with a consideration and standardisation of domains of applicability. Following that we proceed to standards according to which spatial software is presumed to perform one or more of the following steps:

1.  Accept and validate input data
2.  Apply one or more analytic algorithms
3.  Return the result of that algorithmic application
4.  Offer additional functionality such as printing or summarising return results
5.  Testing

Each standard for spatial software is prefixed with “**SP**”.

### 6.6.1 Spatial Domains

Many developers of spatial software in R, including many of those those featured on the CRAN Task view on [“Analysis of Spatial Data”](https://cran.r-project.org/web/views/Spatial.html), have been primarily focussed on geographic data; that is, data quantifying positions, structures, and relationships on the Earth and other planets. Spatial analyses are nevertheless both broader and more general than geography alone. In particular, spatial software may be *geometric* – that is, concerned with positions, structures, and relationships in space in any general or specific sense, not necessarily confined to geographic systems alone.

It is important to distinguish these two domains because many algorithms and procedures devised in one of these two domains are not necessarily (directly) applicable in the other, most commonly because geometric algorithms presume space to be rectilinear or Cartesian, while geographic algorithms (generally) presume it be have a specific curvilinear form (commonly spherical or elliptical). Algorithms designed for Cartesian space may not be directly applicable in curvilinear space, and vice-versa.

Moreover, spatial software and algorithms might be intended to apply in spaces of arbitrary dimensionality. The phrase “Cartesian” refers to any space of arbitrary dimensionality in which all dimensions are orthogonal and described by straight lines; dimensions in a curvilinear space or arbitrary dimensionality are described by curved lines. A planar geometry is a two-dimensional Cartesian space; a spherical geometry is a two- (or maybe three-)dimensional curvilinear space.

One of the earliest and still most widely used R spatial packages, [`spatstat`](https://cran.r-project.org/web/packages/spatstat/) (first released 2002), describes itself as, “\[f\]ocused mainly on two-dimensional point patterns, including multitype/marked points, in any spatial region.” Routines from this package are thus generally applicable to two-dimensional Cartesian data only, even through the final phrase might be interpreted to indicate a comprehensive generality. `spatstat` routines may not necessarily give accurate results when applied in curvilinear space.

These considerations motivate the first standard for spatial software:

- **SP1.0** *Spatial software should explicitly indicate its domain of applicability, and in particular distinguish whether the software may be applied in Cartesian/rectilinear/geometric domains, curvilinear/geographic domains, or both.*

We encourage the use of clear and unambiguous phrases such as “planar”, “spherical”, “Cartesian”, “rectilinear” or “curvilinear”, along with clear indications of dimensionality such as “two-” or “three-dimensional.” Concepts of dimensionality should be interpreted to refer explicitly to the dimensionality of independent spatial coordinates. Elevation is a third spatial dimension, and time may also be considered an additional dimension. Beyond those two, other attributes measured at spatial locations do not represent additional dimensions.

- **SP1.1** *Spatial software should explicitly indicate its dimensional domain of applicability, in particular through identifying whether it is applicable to two or three dimensions only, or whether there are any other restrictions on dimensionality.*

These considerations of domains of applicability permeate much of the ensuring standards, which distinguish “geometric software” from “geographic software”, where these phrases are to be interpreted as shorthand references to software intended for use in the respective domains.

### 6.6.2 Input data structures and validation

Input validation is an important software task, and an important part of our standards. While there are many ways to approach validation, the class systems of R offer a particularly convenient and effective means. For Spatial Software in particular, a range of class systems have been developed, for which we refer to the CRAN Task view on [“Analysis of Spatial Data”](https://cran.r-project.org/web/views/Spatial.html). Software which uses and relies on defined classes can often validate input through affirming appropriate class(es). Software which does not use or rely on class systems will generally need specific routines to validate input data structures.

As for our standards for [Time-Series Software](https://stats-devguide.ropensci.org/standards.html#standards-time-series), these standards for Spatial Software also suggest that software should use explicit class systems designed and intended for spatial data. New packages may implement new class systems for spatial data, and these may even be as simple as appending a class attribute to a matrix of coordinates. The primary motivation of the following standard is nevertheless to encourage and enhance inter-operability with the rich system of classes for spatial data in R.

- **SP2.0** *Spatial software should only accept input data of one or more classes explicitly developed to represent such data.*
  - **SP2.0a** *Where new classes are implemented, conversion to other common classes for spatial data in R should be documented.*
  - **SP2.0b** *Class systems should ensure that functions error appropriately, rather than merely warning, in response to data from inappropriate spatial domains.*

**Spatial Workflows, Packages, and Classes**

Spatial software encompasses an enormous diversity, yet workflows implemented by spatial software often share much in common. In particular, coordinate reference systems used to precisely relate pairs of coordinates to precise locations in a curvilinear space, and in particular to the Earth’s ellipsoid, need to be able to be compared and transformed regardless of the specificities of individual software. This ubiquitous need has fostered the development of the [`PROJ` library](https://proj.org/) for representing and transforming spatial coordinates. Several other libraries have been built on top or or alongside that, notably including the [`GDAL` (“Geospatial Data Abstraction Library”)](https://gdal.org) and [`GEOS` (“Geometry Engine, Open Source”)](https://trac.osgeo.org/geos/) libraries. These libraries are used by, and integrated within, most geographical spatial software commonly used today, and will likely continue to be used.

While not a standard in itself, it is expected that spatial software should not, absent very convincing and explicit justification, attempt to reconstruct aspects of these generic libraries. Given that, the following standards aim to ensure that spatial software remains as compatible as possible with workflows established by preceding packages which have aimed to expose and integrate as much of the functionality of these generic libraries as possible. The use of specific class systems for spatial data, and the workflows encapsulated in associated packages, ensures maximal ongoing compatibility with these libraries and with spatial workflows in general.

Notable class systems and associated packages in R include [`sp`](https://cran.r-project.org/package=sp), [`sf`](https://cran.r-project.org/package=sf), and [`raster`](https://rspatial.org/raster/), and more recent extensions such as [`stars`](https://cran.r-project.org/package=stars), [`terra`](https://rspatial.org/terra), and [`s2`](https://r-spatial.github.io/s2/). With regard to these packages, the following single standard applies, because the maintainer of sp has made it clear that new software [should build upon sf, not sp](https://github.com/r-spatial/discuss/issues/48#issuecomment-798543339).

- **SP2.1** *Spatial Software should not use the [`sp` package](https://cran.r-project.org/package=sp), rather should use [`sf`](https://cran.r-project.org/package=sf).*

More generally,

- **SP2.2** *Geographical Spatial Software should ensure maximal compatibility with established packages and workflows, minimally through:*
  - **SP2.2a** *Clear and extensive documentation demonstrating how routines from that software may be embedded within, or otherwise adapted to, workflows which rely on these established packages; and*
  - **SP2.2b** *Tests which clearly demonstrate that routines from that software may be successfully translated into forms and workflows which rely on these established packages.*

This standard is further refined in a number of subsequent standards concerning documentation and testing.

- **SP2.3** *Software which accepts spatial input data in any standard format established in other R packages (such as any of the formats able to be read by [`GDAL`](https://gdal.org), and therefore by the [`sf` package](https://cran.r-project.org/package=sf)) should include example and test code which load those data in spatial formats, rather than R-specific binary formats such as `.Rds`.*

See the `sf` vignette on [“*Reading, Writing and Converting Simple Features*”](https://cran.r-project.org/web/packages/sf/vignettes/sf2.html) for useful examples.

**Coordinate Reference Systems**

As described above, one of the primary reasons for the development of classes in Spatial Software is to represent the coordinate reference systems in which data are represented, and to ensure compatibility with the [`PROJ` system](https://proj.org/) and other generic spatial libraries. The [`PROJ`](https://proj.org/) standards and associated software library have been recently (2020) updated (to version number 7) with “breaking changes” that are not backwards-compatible with previous versions, and in particular with the long-standing version 4. The details and implications of these changes within the context of spatial software in R can be examined in [this blog entry](https://www.r-spatial.org//r/2020/03/17/wkt.html) on [`r-spatial.org`](https://r-spatial.org), and in [this vignette](https://cran.r-project.org/web/packages/rgdal/vignettes/PROJ6_GDAL3.html) for the [`rgdal` package](https://cran.r-project.org/web/packages/rgdal/). The “breaking” nature of these updates partly reflects analogous “breaking changes” associated with updates in the [“Well-Known Text” (WKT)](http://docs.opengeospatial.org/is/12-063r5/12-063r5.html) system for representing coordinate reference systems.

The following standard applies to software which directly or indirectly relies on geographic data which uses or relies upon coordinate reference systems.

- **SP2.4** *Geographical Spatial Software should be compliant with version 6 or larger of* [`PROJ`](https://proj.org/), *and with* `WKT2` *representations. The primary implication, described in detail in the articles linked to above, is that:*
  - **SP2.4a** *Software should not permit coordinate reference systems to be represented merely by so-called “PROJ4-strings”, but should use at least WKT2.*

**General Input Structures**

New spatial software may nevertheless eschew these prior packages and classes in favour of implementing new classes. Whether or not prior classes are used or expected, geographic software should accord as much as possible with the principles of these prior systems by according with the following standards:

- **SP2.5** *Class systems for input data must contain meta data on associated coordinate reference systems.*
  - **SP2.5a** *Software which implements new classes to input spatial data (or the spatial components of more general data) should provide an ability to convert such input objects into alternative spatial classes such as those listed above.*
- **SP2.6** *Spatial Software should explicitly document the types and classes of input data able to be passed to each function.*
- **SP2.7** *Spatial Software should implement validation routines to confirm that inputs are of acceptable classes (or represented in otherwise appropriate ways for software which does not use class systems).*
- **SP2.8** *Spatial Software should implement a single pre-processing routine to validate input data, and to appropriately transform it to a single uniform type to be passed to all subsequent data-processing functions.*
- **SP2.9** *The pre-processing function described above should maintain those metadata attributes of input data which are relevant or important to core algorithms or return values.*

### 6.6.3 Algorithms

The following standards will be conditionally applicable to some but not all spatial software. Procedures for standards deemed not applicable to a particular piece of software are described in the [`srr` package](https://github.com/ropensci-review-tools/srr).

- **SP3.0** *Spatial software which considers spatial neighbours should enable user control over neighbourhood forms and sizes. In particular:*
  - **SP3.0a** *Neighbours (able to be expressed) on regular grids should be able to be considered in both rectangular only, or rectangular and diagonal (respectively “rook” and “queen” by analogy to chess).*
  - **SP3.0b** *Neighbourhoods in irregular spaces should be minimally able to be controlled via an integer number of neighbours, an area (or equivalent distance defining an area) in which to include neighbours, or otherwise equivalent user-controlled value.*
- **SP3.1** *Spatial software which considers spatial neighbours should wherever possible enable neighbour contributions to be weighted by distance (or other continuous weighting variable), and not rely exclusively on a uniform-weight rectangular cut-off.*
- **SP3.2** *Spatial software which relies on sampling from input data (even if only of spatial coordinates) should enable sampling procedures to be based on local spatial densities of those input data.*

An example of software which would *not* adhere to **SP3.2** would be where input data were a simple matrix of spatial coordinates, and sampling were implemented using the [`sample()` function](https://stat.ethz.ch/R-manual/R-devel/library/base/html/sample.html) to randomly select elements of those input data (like `sample(nrow(xy), n)`). In the context of an example based on the [`sample()` function](https://stat.ethz.ch/R-manual/R-devel/library/base/html/sample.html), adhering to the standard would require including an additional `prob` vector where each point was weighted by the local density of surrounding points. Doing so would lead to higher probabilities of samples being taken from central clusters of higher densities than from outlying extreme points. Note that the standard merely suggests that software should *enable* such density-based samples to be taken, not that it must, or even necessarily should by default.

Algorithms for spatial software are often related to other categories of statistical software, and it is anticipated that spatial software will commonly also be subject to standards from these other categories. Nevertheless, because spatial analyses frequently face unique challenges, some of these category-specific standards also have extension standards when applied to spatial software. The following standards will be applicable for any spatial software which also fits any of the other listed categories of statistical software.

**Regression Software**

- **SP3.3** *Spatial regression software should explicitly quantify and distinguish autocovariant or autoregressive processes from those covariant or regressive processes not directly related to spatial structure alone.*

**Unsupervised Learning Software**

The following standard applies to any spatial unsupervised learning software which uses clustering algorithms.

- **SP3.4** *Where possible, spatial clustering software should avoid using standard non-spatial clustering algorithms in which spatial proximity is merely represented by an additional weighting factor in favour of explicitly spatial algorithms.*

**Machine Learning Software**

One common application in which machine learning algorithms are applied to spatial software is in analyses of raster images. The first of the following standards applies because the individual cells or pixels of these raster images represent fixed spatial coordinates. (This standard also renders **ML2.1** inapplicable).

- **SP3.5** *Spatial machine learning software should ensure that broadcasting procedures for reconciling inputs of different dimensions are **not** applied*.

A definition of broadcasting is given at the end of the introduction to corresponding [Machine Learning Standards](#ml-standards), just above *Input Data Specification*.

- **SP3.6** *Spatial machine learning software should document (and, where possible, test) the potential effects of different sampling procedures*

A simple example might be to provide examples or extended documentation which compares the effects of sampling both test and training data from the same spatial region versus sampling them from distinct regions. Although there are no comparable *General Standard* for [*Machine Learning Software*](#ml-standards), procedures for sampling spatial data may have particularly pronounced effects on results, and this standard attempts to foster a “best practice” of documenting how such effects may arise with a given piece of software.

A more concrete example may be to demonstrate a particular technique for generating distinct test and training data such as spatial partitioning ([Muenchow, n.d.](#ref-muenchow_chapter_nodate); [Brenning 2012](#ref-brenning_spatial_2012); [Schratz et al. 2019](#ref-schratz_hyperparameter_2019); [Valavi et al. 2019](#ref-valavi_blockcv_2019)). There may nevertheless be cases in which such sampling from a common spatial region is appropriate, for example for software intended to analyse or model temporally-structured spatial data for which a more appropriate distinction might be temporal rather than spatial. Adherence to this standard merely requires that the potential for any such confounding effects be explicitly documented (and possibly tested as well).

### 6.6.4 Return Results

For (functions within) Spatial Software which return spatial data:

- **SP4.0** *Return values should either:*
  - **SP4.0a** *Be in same class as input data, or*
  - **SP4.0b** *Be in a unique, preferably class-defined, format.*
- **SP4.1** *Any aspects of input data which are included in output data (either directly, or in some transformed form) and which contain units should ensure those same units are maintained in return values.*
- **SP4.2** *The type and class of all return values should be explicitly documented.*

### 6.6.5 Visualization

Spatial Software which returns objects in a custom class structure explicitly designed to represent or include spatial data should:

- **SP5.0** *Implement default `plot` methods for any implemented class system.*
- **SP5.1** *Implement appropriate placement of variables along x- and y-axes.*
- **SP5.2** *Ensure that axis labels include appropriate units.*

An example of **SP5.1** might be ensuring that longitude is placed on the x-axis, latitude on the y, although standard orientations may depend on coordinate reference systems and other aspects of data and software design. The preceding three standards will generally not apply to software which returns objects in a custom class structure yet which is not inherently spatial.

Spatial Software which returns objects with geographical coordinates should:

- **SP5.3** *Offer an ability to generate interactive (generally `html`-based) visualisations of results.*

### 6.6.6 Testing

The following standards apply to all Spatial Software which is intended or able to be applied to data represented in curvilinear systems, notably including all geographical data. The only Spatial Software to which the following standards do not (necessarily) apply would be software explicitly intended to be applied exclusively to Cartesian spatial data, and which ensured appropriate rejection of curvilinear data according to **SP2.0b**.

**Round-Trip Tests**

- **SP6.0** *Software which implements routines for transforming coordinates of input data should include tests which demonstrate ability to recover the original coordinates.*

This standard is applicable to any software which implements any routines for coordinate transformations, even if those routines are implemented via [`PROJ`](https://proj.org). Conversely, software which has no routines for coordinate transformations need not adhere to **SP6.0**, even if that software relies on `PROJ` for other purposes.

- **SP6.1** *All functions which can be applied to both Cartesian and curvilinear data should be tested through application to both.*
  - **SP6.1a** *Functions which may yield inaccurate results when applied to data in one or the other forms (such as the preceding examples of centroids and buffers from ellipsoidal data) should test that results from inappropriate application of those functions are indeed less accurate.*
  - **SP6.1b** *Functions which yield accurate results regardless of whether input data are rectilinear or curvilinear should demonstrate equivalent accuracy in both cases, and should also demonstrate how equivalent results may be obtained through first explicitly transforming input data.*

**Extreme Geographical Coordinates**

- **SP6.2** *Geographical Software should include tests with extreme geographical coordinates, minimally including extension to polar extremes of +/-90 degrees.*

While such tests should generally confirm that software generates reliable results to such extreme coordinates, software which is unable to generate reliable results to such inputs should nevertheless include tests to indicate both approximate bounds of reliability, and the expected characteristics of unreliable results.

The remaining standards for testing Spatial Software extend directly from the preceding Algorithmic Standards (**SP3**), with the same sub-section headings used here.

- **SP6.3** *Spatial Software which considers spatial neighbours should explicitly test all possible ways of defining them, and should explicitly compare quantitative effects of different ways of defining neighbours.*
- **SP6.4** *Spatial Software which considers spatial neighbours should explicitly test effects of different schemes to weight neighbours by spatial proximity.*

**Unsupervised Learning Software**

- **SP6.5** *Spatial Unsupervised Learning Software which uses clustering algorithms should implement tests which explicitly compare results with equivalent results obtained with a non-spatial clustering algorithm.*

**Machine Learning Software**

- **SP6.6** \*Spatial Machine Learning Software should implement tests which explicitly demonstrate the detrimental consequences of sampling test and training data from the same spatial region, rather than from spatially distinct regions.

------------------------------------------------------------------------

## 6.7 Time Series Software

The category of Time Series software is arguably easier to define than the preceding categories, and represents any software the primary input of which is intended to be temporally structured data. Importantly, while “*temporally structured*” may often imply temporally ordered, this need not necessarily be the case. The primary definition of temporally structured data is that they possess some kind of index which can be used to extract temporal relationships.

Time series software is presumed to perform one or more of the following steps:

1.  Accept and validate input data
2.  Apply data transformation and pre-processing steps
3.  Apply one or more analytic algorithms
4.  Return the result of that algorithmic application
5.  Offer additional functionality such as printing or summarising return results

This document details standards for each of these steps, each prefixed with “TS”.

### 6.7.1 Input data structures and validation

Input validation is an important software task, and an important part of our standards. While there are many ways to approach validation, the class systems of R offer a particularly convenient and effective means. For Time Series Software in particular, a range of class systems have been developed, for which we refer to the section “Time Series Classes” in the CRAN Task view on [Time Series Analysis”](https://cran.r-project.org/web/views/TimeSeries.html), and the class-conversion package [`tsbox`](https://www.tsbox.help/). Software which uses and relies on defined classes can often validate input through affirming appropriate class(es). Software which does not use or rely on class systems will generally need specific routines to validate input data structures. In particular, because of the long history of time series software in R, and the variety of class systems for representing time series data, new time series packages should accept as many different classes of input as possible by according with the following standards:

- **TS1.0** *Time Series Software should use and rely on explicit class systems developed for representing time series data, and should not permit generic, non-time-series input*

The core algorithms of time-series software are often ultimately applied to simple vector objects, and some time series software accepts simple vector inputs, assuming these to represent temporally sequential data. Permitting such generic inputs nevertheless prevents any such assumptions from being asserted or tested. Missing values pose particular problems in this regard. A simple [`na.omit()`](https://rdrr.io/r/stats/na.fail.html) call or similar will shorten the length of the vector by removing any `NA` values, and will change the explicit temporal relationship between elements. The use of explicit classes for time series generally ensures an ability to explicitly assert properties such as strict temporal regularity, and to control for any deviation from expected properties.

- **TS1.1** *Time Series Software should explicitly document the types and classes of input data able to be passed to each function.*

Such documentation should include a demonstration of how to input data in at least one commonly used class for time-series such as [`ts`](https://stat.ethz.ch/R-manual/R-devel/library/stats/html/ts.html).

- **TS1.2** *Time Series Software should implement validation routines to confirm that inputs are of acceptable classes (or represented in otherwise appropriate ways for software which does not use class systems).*
- **TS1.3** *Time Series Software should implement a single pre-processing routine to validate input data, and to appropriately transform it to a single uniform type to be passed to all subsequent data-processing functions (the [`tsbox` package](https://www.tsbox.help/) provides one convenient approach for this).*
- **TS1.4** *The pre-processing function described above should maintain all time- or date-based components or attributes of input data.*

For Time Series Software which relies on or implements custom classes or types for representing time-series data, the following standards should be adhered to:

- **TS1.5** *The software should ensure strict ordering of the time, frequency, or equivalent ordering index variable.*
- **TS1.6** *Any violations of ordering should be caught in the pre-processing stages of all functions.*

#### 6.7.1.1 Time Intervals and Relative Time

While most common packages and classes for time series data assume *absolute* temporal scales such as those represented in [`POSIX` classes](https://stat.ethz.ch/R-manual/R-devel/library/base/html/as.POSIXlt.html) for dates or times, time series may also be quantified on *relative* scales where the temporal index variable quantifies intervals rather than absolute times or dates. Many analytic routines which accept time series inputs in absolute form are also appropriately applied to analogous data in relative form, and thus many packages should accept time series inputs both in absolute and relative forms. Software which can or should accept times series inputs in relative form should:

- **TS1.7** *Accept inputs defined via the [`units` package](https://github.com/r-quantities/units/) for attributing SI units to R vectors.*
- **TS1.8** *Where time intervals or periods may be days or months, be explicit about the system used to represent such, particularly regarding whether a calendar system is used, or whether a year is presumed to have 365 days, 365.2422 days, or some other value.*

### 6.7.2 Pre-processing and Variable Transformation

#### 6.7.2.1 Missing Data

One critical pre-processing step for Time Series Software is the appropriate handling of missing data. It is convenient to distinguish between *implicit* and *explicit* missing data. For regular time series, explicit missing data may be represented by `NA` values, while for irregular time series, implicit missing data may be represented by missing rows. The difference is demonstrated in the following table.

|       |       |
|:------|:------|
| Time  | value |
| 08:43 | 0.71  |
| 08:44 | NA    |
| 08:45 | 0.28  |
| 08:47 | 0.34  |
| 08:48 | 0.07  |

Missing Values {.table}

The value for 08:46 is *implicitly missing*, while the value for 08:44 is *explicitly missing*. These two forms of missingness may connote different things, and may require different forms of pre-processing. With this in mind, and beyond the [*General Standards*](#general-standards) for missing data (**G2.13**–**G2.16**), the following standards apply:

- **TS2.0** *Time Series Software which presumes or requires regular data should only allow **explicit** missing values, and should issue appropriate diagnostic messages, potentially including errors, in response to any **implicit** missing values.*
- **TS2.1** *Where possible, all functions should provide options for users to specify how to handle missing data, with options minimally including:*
  - **TS2.1a** \*error on missing data; or.
  - **TS2.1b** *warn or ignore missing data, and proceed to analyse irregular data, ensuring that results from function calls with regular yet missing data return identical values to submitting equivalent irregular data with no missing values; or*
  - **TS2.1c** *replace missing data with appropriately imputed values.*

This latter standard is a modified version of *General Standard* **G2.14**, with additional requirements via **TS2.1b**.

#### 6.7.2.2 Stationarity

Time Series Software should explicitly document assumptions or requirements made with respect to the stationarity or otherwise of all input data. In particular, any (sub-)functions which assume or rely on stationarity should:

- **TS2.2** \*Consider stationarity of all relevant moments
  - typically first (mean) and second (variance) order, or otherwise document why such consideration may be restricted to lower orders only.\*
- **TS2.3** *Explicitly document all assumptions and/or requirements of stationarity*
- **TS2.4** *Implement appropriate checks for all relevant forms of stationarity, and either:*
  - **TS2.4a** *issue diagnostic messages or warnings; or*
  - **TS2.4b** *enable or advise on appropriate transformations to ensure stationarity.*

The two options in the last point (TS2.4b) respectively translate to *enabling* transformations to ensure stationarity by providing appropriate routines, generally triggered by some function parameter, or *advising* on appropriate transformations, for example by directing users to additional functions able to implement appropriate transformations.

#### 6.7.2.3 Auto-Covariance Matrices

Where auto-covariance matrices are constructed or otherwise used within or as input to functions, they should:

- **TS2.5** *Incorporate a system to ensure that both row and column orders follow the same ordering as the underlying time series data. This may, for example, be done by including the `index` attribute of the time series data as an attribute of the auto-covariance matrix.*
- **TS2.6** *Where applicable, auto-covariance matrices should also include specification of appropriate units.*

*General Standard* **G3.1** also applies to all Time Series Software which constructs or uses auto-covariance matrices.

### 6.7.3 Analytic Algorithms

Analytic algorithms are considered here to reflect the core analytic components of Time Series Software. These may be many and varied, and we explicitly consider only a small subset here.

#### 6.7.3.1 Forecasting

Statistical software which implements forecasting routines should:

- **TS3.0** *Provide tests to demonstrate at least one case in which errors widen appropriately with forecast horizon.*
- **TS3.1** *If possible, provide at least one test which violates TS3.0*
- **TS3.2** *Document the general drivers of forecast errors or horizons, as demonstrated via the particular cases of TS3.0 and TS3.1*
- **TS3.3** *Either:*
  - **TS3.3a** *Document, preferable via an example, how to trim forecast values based on a specified error margin or equivalent; or*
  - **TS3.3b** *Provide an explicit mechanism to trim forecast values to a specified error margin, either via an explicit post-processing function, or via an input parameter to a primary analytic function.*

### 6.7.4 Return Results

For (functions within) Time Series Software which return time series data:

- **TS4.0** *Return values should either:*
  - **TS4.0a** *Be in same class as input data, for example by using the [`tsbox` package](https://www.tsbox.help/) to re-convert from standard internal format (see 1.4, above); or*
  - **TS4.0b** *Be in a unique, preferably class-defined, format.*
- **TS4.1** *Any units included as attributes of input data should also be included within return values.*
- **TS4.2** *The type and class of all return values should be explicitly documented.*

For (functions within) Time Series Software which return data other than direct series:

- **TS4.3** *Return values should explicitly include all appropriate units and/or time scales*

#### 6.7.4.1 Data Transformation

Time Series Software which internally implements routines for transforming data to achieve stationarity and which returns forecast values should:

- **TS4.4** *Document the effect of any such transformations on forecast data, including potential effects on both first- and second-order estimates.*
- **TS4.5** *In decreasing order of preference, either:*
  - **TS4.5a** *Provide explicit routines or options to back-transform data commensurate with original, non-stationary input data*
  - **TS4.5b** *Demonstrate how data may be back-transformed to a form commensurate with original, non-stationary input data.*
  - **TS4.5c** *Document associated limitations on forecast values*

#### 6.7.4.2 Forecasting

Where Time Series Software implements or otherwise enables forecasting abilities, it should return one of the following three kinds of information. These are presented in decreasing order of preference, such that software should strive to return the first kind of object, failing that the second, and only the third as a last resort.

- **TS4.6** *Time Series Software which implements or otherwise enables forecasting should return either:*
  - **TS4.6a** *A distribution object, for example via one of the many packages described in the CRAN Task View on [Probability Distributions](https://cran.r-project.org/web/views/Distributions.html) (or the new [`distributional` package](https://pkg.mitchelloharawild.com/distributional/) as used in the [`fable` package](https://fable.tidyverts.org) for time-series forecasting).*
  - **TS4.6b** *For each variable to be forecast, predicted values equivalent to first- and second-order moments (for example, mean and standard error values).*
  - **TS4.6c** *Some more general indication of error associated with forecast estimates.*

Beyond these particular standards for return objects, Time Series Software which implements or otherwise enables forecasting should:

- **TS4.7** *Ensure that forecast (modelled) values are clearly distinguished from observed (model or input) values, either (in this case in no order of preference) by*
  - **TS4.7a** *Returning forecast values alone*
  - **TS4.7b** *Returning distinct list items for model and forecast values*
  - **TS4.7c** *Combining model and forecast values into a single return object with an appropriate additional column clearly distinguishing the two kinds of data.*

### 6.7.5 Visualization

Time Series Software should:

- **TS5.0** *Implement default `plot` methods for any implemented class system.*
- **TS5.1** *When representing results in temporal domain(s), ensure that one axis is clearly labelled “time” (or equivalent), with continuous units.*
- **TS5.2** *Default to placing the “time” (or equivalent) variable on the horizontal axis.*
- **TS5.3** *Ensure that units of the time, frequency, or index variable are printed by default on the axis.*
- **TS5.4** *For frequency visualization, abscissa spanning \\\[-\pi, \pi\]\\ should be avoided in favour of positive units of \\\[0, 2\pi\]\\ or \\\[0, 0.5\]\\, in all cases with appropriate additional explanation of units.*
- **TS5.5** *Provide options to determine whether plots of data with missing values should generate continuous or broken lines.*

For the results of forecast operations, Time Series Software should

- **TS5.6** *By default indicate distributional limits of forecast on plot*
- **TS5.7** *By default include model (input) values in plot, as well as forecast (output) values*
- **TS5.8** *By default provide clear visual distinction between model (input) values and forecast (output) values.*

------------------------------------------------------------------------

## 6.8 Dimensionality Reduction, Clustering, and Unsupervised Learning

This sub-section details standards for Dimensionality Reduction, Clustering, and Unsupervised Learning Software – referred to from here on for simplicity as “Unsupervised Learning Software”. Software in this category is distinguished from Regression Software though the latter aiming to construct or analyse one or more mappings between two defined data sets (for example, a set of “independent” data, \\X\\, and a set of “dependent” data, “Y”), whereas Unsupervised Learning Software aims to construct or analyse one or more mappings between a defined set of input or independent data, and a second set of “output” data which are not necessarily known or given prior to the analysis. A key distinction in Unsupervised Learning Software and Algorithms is between that for which output data represent (generally numerical) transformations of the input data set, and that for which output data are discrete labels applied to the input data. Examples of the former type include dimensionality reduction and ordination software and algorithms, and examples of the latter include clustering and discrete partitioning software and algorithms.

Some examples of *Dimensionality Reduction, Clustering, and Unsupervised Learning* software include:

1.  [`ivis`](https://joss.theoj.org/papers/10.21105/joss.01596) implements a dimensionality reduction technique using a “Siamese Neural Network architecture.
2.  [`tsfeaturex`](https://joss.theoj.org/papers/10.21105/joss.01279) is a package to automate “time series feature extraction,” which also provides an example of a package for which both input and output data are generally incomparable with most other packages in this category.
3.  [`iRF`](https://joss.theoj.org/papers/10.21105/joss.01077) is another example of a generally incomparable package within this category, here one for which the features extracted are the most distinct predictive features extracted from repeated iterations of random forest algorithms.
4.  [`compboost`](https://joss.theoj.org/papers/10.21105/joss.00967) is a package for component-wise gradient boosting which may be sufficient general to potentially allow general application to problems addressed by several packages in this category.
5.  The [`iml`](https://joss.theoj.org/papers/10.21105/joss.00786) package may offer usable functionality for devising general assessments of software within this category, through offering a “toolbox for making machine learning models interpretable” in a “model agnostic” way.

Click on the following link to view a demonstration [Application of Dimensionality Reduction, Clustering, and Unsupervised Learning Standards](https://hackmd.io/iOZD_oCpT86zoY5z4memaQ).

### 6.8.1 Input Data Structures and Validation

- **UL1.0** *Unsupervised Learning Software should explicitly document expected format (types or classes) for input data, including descriptions of types or classes which are not accepted; for example, specification that software accepts only numeric inputs in `vector` or `matrix` form, or that all inputs must be in `data.frame` form with both column and row names.*
- **UL1.1** *Unsupervised Learning Software should provide distinct sub-routines to assert that all input data is of the expected form, and issue informative error messages when incompatible data are submitted.*

The following code demonstrates an example of a routine from the base `stats` package which fails to meet this standard.

    #> Error in `if (is.na(n) || n > 65536L) ...`:
    #> ! missing value where TRUE/FALSE needed

The latter fails, yet issues an uninformative error message that clearly indicates a failure to provide sufficient checks on the class of input data.

- **UL1.2** *Unsupervised learning which uses row or column names to label output objects should assert that input data have non-default row or column names, and issue an informative message when these are not provided.*

Such messages need not necessarily be provided by default, but should at least be optionally available.

Click here for examples of checks for whether row and column names have generic default values.

The `data.frame` function inserts default row and column names where these are not explicitly specified.

    #>   X1 X2
    #> 1  1  6
    #> 2  2  7
    #> 3  3  8
    #> 4  4  9
    #> 5  5 10

Generic row names are almost always simple integer sequences, which the following condition confirms.

    #> [1] TRUE

Generic column names may come in a variety of formats. The following code uses a `grep` expression to match any number of characters plus an optional leading zero followed by a generic sequence of column numbers, appropriate for matching column names produced by generic construction of `data.frame` objects.

    #> [1] TRUE

Messages should be issued in both of these cases.

\

The following code illustrates that the `hclust` function does not implement any such checks or assertions, rather it silently returns an object with default labels.

    #> [1] "1" "2" "3" "4" "5" "6"

- **UL1.3** *Unsupervised Learning Software should transfer all relevant aspects of input data, notably including row and column names, and potentially information from other [`attributes()`](https://rdrr.io/r/base/attributes.html), to corresponding aspects of return objects.*
  - **UL1.3a** *Where otherwise relevant information is not transferred, this should be explicitly documented.*

An example of a function according with UL1.3 is [`stats::cutree()`](https://stat.ethz.ch/R-manual/R-patched/library/stats/html/cutree.html)

    #>    Alabama     Alaska    Arizona   Arkansas California   Colorado 
    #>          1          2          3          4          5          4

The row names of `USArrests` are transferred to the output object. In contrast, some routines from the [`cluster` package](https://cran.r-project.org/package=cluster) do not comply with this standard:

    #> [1] 1 2 3 4 3 4

The case labels are not appropriately carried through to the object returned by [`agnes()`](https://stat.ethz.ch/R-manual/R-devel/library/cluster/html/agnes.html) to enable them to be transferred within [`cutree()`](https://stat.ethz.ch/R-manual/R-patched/library/stats/html/cutree.html). (The labels are transferred to the object returned by `agnes`, just not in a way that enables `cutree` to inherit them.)

- **UL1.4** *Unsupervised Learning Software should document any assumptions made with regard to input data; for example assumptions about distributional forms or locations (such as that data are centred or on approximately equivalent distributional scales). Implications of violations of these assumptions should be both documented and tested, in particular:*
  - **UL1.4a** *Software which responds qualitatively differently to input data which has components on markedly different scales should explicitly document such differences, and implications of submitting such data.*
  - **UL1.4b** *Examples or other documentation should not use [`scale()`](https://rdrr.io/r/base/scale.html) or equivalent transformations without explaining why scale is applied, and explicitly illustrating and contrasting the consequences of not applying such transformations.*

### 6.8.2 Pre-processing and Variable Transformation

- **UL2.0** *Routines likely to give unreliable or irreproducible results in response to violations of assumptions regarding input data (see UL1.4) should implement pre-processing steps to diagnose potential violations, and issue appropriately informative messages, and/or include parameters to enable suitable transformations to be applied.*

Example of compliance with this standard are the documentation entries for the `center` and `scale.` parameters of the [`stats::prcomp()`](https://stat.ethz.ch/R-manual/R-patched/library/stats/html/prcomp.html) function.

- **UL2.1** *Unsupervised Learning Software should document any transformations applied to input data, for example conversion of label-values to `factor`, and should provide ways to explicitly avoid any default transformations (with error or warning conditions where appropriate).*
- **UL2.2** *Unsupervised Learning Software which accepts missing values in input data should implement explicit parameters controlling the processing of missing values, ideally distinguishing `NA` or `NaN` values from `Inf` values.*

This standard applies beyond *General Standards* **G2.13**–**G2.16**, through the additional requirement of implementing explicit parameters.

- **UL2.3** *Unsupervised Learning Software should implement pre-processing routines to identify whether aspects of input data are perfectly collinear.*

### 6.8.3 Algorithms

#### 6.8.3.1 Labelling

- **UL3.0** *Algorithms which apply sequential labels to input data (such as clustering or partitioning algorithms) should ensure that the sequence follows decreasing group sizes (so labels of “1”, “a”, or “A” describe the largest group, “2”, “b”, or “B” the second largest, and so on.)*

Note that the [`stats::cutree()` function](https://stat.ethz.ch/R-manual/R-patched/library/stats/html/cutree.html) does not accord with this standard:

    #> 
    #>  1  2  3  4  5  6  7  8  9 10 
    #>  3  3  3  6  5 10  2  5  5  8

The [`cutree()` function](https://stat.ethz.ch/R-manual/R-patched/library/stats/html/cutree.html) applies arbitrary integer labels to the groups, yet the order of labels is not related to the order of group sizes.

- **UL3.1** *Dimensionality reduction or equivalent algorithms which label dimensions should ensure that that sequences of labels follows decreasing “importance” (for example, eigenvalues or variance contributions).*

The [`stats::prcomp`](https://stat.ethz.ch/R-manual/R-patched/library/stats/html/prcomp.html) function accords with this standard:

    #> Importance of first k=5 (out of 21) components:
    #>                              PC1       PC2       PC3       PC4       PC5
    #> Standard deviation     2529.6298 2157.3434 1459.4839 551.68183 369.10901
    #> Proportion of Variance    0.4591    0.3339    0.1528   0.02184   0.00977
    #> Cumulative Proportion     0.4591    0.7930    0.9458   0.96764   0.97741

The proportion of variance explained by each component decreasing with increasing numeric labelling of the components.

- **UL3.2** *Unsupervised Learning Software for which input data does not generally include labels (such as `array`-like data with no row names) should provide an additional parameter to enable cases to be labelled.*

#### 6.8.3.2 Prediction

- **UL3.3** *Where applicable, Unsupervised Learning Software should implement routines to predict the properties (such as numerical ordinates, or cluster memberships) of additional new data without re-running the entire algorithm.*

While many algorithms such as Hierarchical clustering can not (readily) be used to predict memberships of new data, other algorithms can nevertheless be applied to perform this task. The following demonstrates how the output of [`stats::hclust`](https://stat.ethz.ch/R-manual/R-devel/library/stats/html/hclust.html) can be used to predict membership of new data using the [`class:knn()` function](https://stat.ethz.ch/R-manual/R-devel/library/class/html/knn.html). (This is intended to illustrate only one of many possible approaches.)

    #> [1] 2 2 1 1 2
    #> Levels: 1 2 3

The [`stats::prcomp()` function](https://stat.ethz.ch/R-manual/R-devel/library/stats/html/prcomp.html) implements its own [`predict()`](https://rdrr.io/r/stats/predict.html) method which conforms to this standard:

    #>                      PC1        PC2        PC3       PC4
    #> North Carolina 165.17494 -30.693263 -11.682811  1.304563
    #> Maryland       129.44401  -4.132644  -2.161693  1.258237
    #> Ohio           -49.51994  12.748248   2.104966 -2.777463
    #> Colorado        35.78896  14.023774  12.869816  1.233391
    #> Georgia         41.28054  -7.203986   3.987152 -7.818416

#### 6.8.3.3 Group Distributions and Associated Statistics

Many unsupervised learning algorithms serve to label, categorise, or partition data. Software which performs any of these tasks will commonly output some kind of labelling or grouping schemes. The above example of principal components illustrates that the return object records the standard deviations associated with each component:

    #> Standard deviations (1, .., p=4):
    #> [1] 83.732400 14.212402  6.489426  2.482790
    #> 
    #> Rotation (n x k) = (4 x 4):
    #>                 PC1         PC2         PC3         PC4
    #> Murder   0.04170432 -0.04482166  0.07989066 -0.99492173
    #> Assault  0.99522128 -0.05876003 -0.06756974  0.03893830
    #> UrbanPop 0.04633575  0.97685748 -0.20054629 -0.05816914
    #> Rape     0.07515550  0.20071807  0.97408059  0.07232502
    #> Importance of components:
    #>                            PC1      PC2    PC3     PC4
    #> Standard deviation     83.7324 14.21240 6.4894 2.48279
    #> Proportion of Variance  0.9655  0.02782 0.0058 0.00085
    #> Cumulative Proportion   0.9655  0.99335 0.9991 1.00000

Such output accords with the following standard:

- **UL3.4** *Objects returned from Unsupervised Learning Software which labels, categorise, or partitions data into discrete groups should include, or provide immediate access to, quantitative information on intra-group variances or equivalent, as well as on inter-group relationships where applicable.*

The above example of principal components is one where there are no inter-group relationships, and so that standard is fulfilled by providing information on intra-group variances alone. Discrete clustering algorithms, in contrast, yield results for which inter-group relationships are meaningful, and such relationships can generally be meaningfully provided. The [`hclust()` routine](https://stat.ethz.ch/R-manual/R-devel/library/stats/html/hclust.html), like many clustering routines, simply returns a *scheme* for devising an arbitrary number of clusters, and so can not meaningfully provide variances or relationships between such. The [`cutree()` function](https://stat.ethz.ch/R-manual/R-devel/library/stats/html/cutree.html), however, does yield defined numbers of clusters, yet devoid of any quantitative information on variances or equivalent.

    #>  Named int [1:50] 1 1 1 2 1 2 3 1 4 2 ...
    #>  - attr(*, "names")= chr [1:50] "Alabama" "Alaska" "Arizona" "Arkansas" ...

Compare that with the output of a largely equivalent routine, the [`clara()` function](https://stat.ethz.ch/R-manual/R-devel/library/cluster/html/clara.html) from the [`cluster` package](https://cran.r-project.org/package=cluster).

    #>       size  max_diss   av_diss isolation
    #>  [1,]    4 24.708298 14.284874 1.4837745
    #>  [2,]    6 28.857755 16.759943 1.7329563
    #>  [3,]    6 44.640565 23.718040 0.9677229
    #>  [4,]    6 28.005892 17.382196 0.8442061
    #>  [5,]    6 15.901258  9.363471 1.1037219
    #>  [6,]    7 29.407822 14.817031 0.9080598
    #>  [7,]    4 11.764353  6.781659 0.8165753
    #>  [8,]    3  8.766984  5.768183 0.3547323
    #>  [9,]    3 18.848077 10.101505 0.7176276
    #> [10,]    5 16.477257  8.468541 0.6273603

That object contains information on dissimilarities between each observation and cluster medoids, which in the context of UL3.4 is “information on intra-group variances or equivalent”. Moreover, inter-group information is also available as the [“silhouette”](https://stat.ethz.ch/R-manual/R-devel/library/cluster/html/silhouette.html) of the clustering scheme.

### 6.8.4 Return Results

- **UL4.0** *Unsupervised Learning Software should return some form of “model” object, generally through using or modifying existing class structures for model objects, or creating a new class of model objects.*
- **UL4.1** *Unsupervised Learning Software may enable an ability to generate a model object without actually fitting values. This may be useful for controlling batch processing of computationally intensive fitting algorithms.*
- **UL4.2** *The return object from Unsupervised Learning Software should include, or otherwise enable immediate extraction of, all parameters used to control the algorithm used.*

#### 6.8.4.1 Reporting Return Results

- **UL4.3** *Model objects returned by Unsupervised Learning Software should implement or appropriately extend a default `print` method which provides an on-screen summary of model (input) parameters and methods used to generate results. The `print` method may also summarise statistical aspects of the output data or results.*
  - **UL4.3a** *The default `print` method should always ensure only a restricted number of rows of any result matrices or equivalent are printed to the screen.*

The [`prcomp` objects](https://stat.ethz.ch/R-manual/R-patched/library/stats/html/prcomp.html) returned from the function of the same name include potential large matrices of component coordinates which are by default printed in their entirety to the screen. This is because the default print behaviour for most tabular objects in R (`matrix`, `data.frame`, and objects from the `Matrix` package, for example) is to print objects in their entirety (limited only by such options as `getOption("max.print")`, which determines maximal numbers of printed objects, such as lines of `data.frame` objects). Such default behaviour ought be avoided, particularly in Unsupervised Learning Software which commonly returns objects containing large numbers of numeric entries.

- **UL4.4** *Unsupervised Learning Software should also implement `summary` methods for model objects which should summarise the primary statistics used in generating the model (such as numbers of observations, parameters of methods applied). The `summary` method may also provide summary statistics from the resultant model.*

### 6.8.5 Documentation

### 6.8.6 Visualization

- **UL6.0** *Objects returned by Unsupervised Learning Software should have default `plot` methods, either through explicit implementation, extension of methods for existing model objects, through ensuring default methods work appropriately, or through explicit reference to helper packages such as [`factoextra`](https://github.com/kassambara/factoextra) and associated functions.*
- **UL6.1** *Where the default `plot` method is **NOT** a generic `plot` method dispatched on the class of return objects (that is, through an S3-type `plot.<myclass>` function or equivalent), that method dispatch (or equivalent) should nevertheless exist in order to explicitly direct users to the appropriate function.*
- **UL6.2** *Where default plot methods include labelling components of return objects (such as cluster labels), routines should ensure that labels are automatically placed to ensure readability, and/or that appropriate diagnostic messages are issued where readability is likely to be compromised (for example, through attempting to place too many labels).*

### 6.8.7 Testing

Unsupervised Learning Software should test the following properties and behaviours:

- **UL7.0** *Inappropriate types of input data are rejected with expected error messages.*

#### 6.8.7.1 Input Scaling

The following tests should be implement for Unsupervised Learning Software for which inputs are presumed or required to be scaled in any particular ways (such as having mean values of zero).

- **UL7.1** *Tests should demonstrate that violations of assumed input properties yield unreliable or invalid outputs, and should clarify how such unreliability or invalidity is manifest through the properties of returned objects.*

#### 6.8.7.2 Output Labelling

With regard to labelling of output data, tests for Unsupervised Learning Software should:

- **UL7.2** *Demonstrate that labels placed on output data follow decreasing group sizes (**UL3.0**)*
- **UL7.3** \*Demonstrate that labels on input data are propagated to, or may be recovered from, output data.

#### 6.8.7.3 Prediction

With regard to prediction, tests for Unsupervised Learning Software should:

- **UL7.4** *Demonstrate that submission of new data to a previously fitted model can generate results more efficiently than initial model fitting.*

#### 6.8.7.4 Batch Processing

For Unsupervised Learning Software which implements batch processing routines:

- **UL7.5** *Batch processing routines should be explicitly tested, commonly via extended tests (see **G4.10**–**G4.12**).*
  - **UL7.5a** *Tests of batch processing routines should demonstrate that equivalent results are obtained from direct (non-batch) processing.*

------------------------------------------------------------------------

## 6.9 Probability Distributions

This sub-section details standards for Software which represents, transforms, or otherwise processes probability distributions. Unlike most other categories of standards, packages which fit in this category will also generally be expected to fit into at least one other category of statistical software. Reflecting that expectation, standards for probability distributions will be expected to only pertain to some (potentially small) portion of code in any package.

Packages which utilise distributional functions to extract uni- or multi-variate estimates as a final algorithmic step, for example to provide numeric probability estimates, are not considered probability distributions software, and are not required to comply with these standards.

These standards apply to any package which performs operations on probability distributions. Operations include, but are not limited to, transformation, representation, convolution, integration, inversion, fitting, or re-scaling. The definition of probability distributions software ultimately depends on the notion of an “operation,” and it is ultimately up to package authors, in conversation with reviewers, to decide whether or not these *Probability Distribution Standards* might apply. If in doubt, the same principle applies here as to all other categories of standards: If at least half of the following standards apply, or could conceivably be applied, to a package, then it should be considered a probability distributions package.

### 6.9.1 Documentation

- **PD1.0** *Software should provide references justifying choice and usage of particular probability distributions.*

This standard applies, for example, to all cases where results of some algorithm are assumed to comply with some “known” statistical distribution, and are accordingly transformed or summarised. Software should then provide references demonstrating that such distributional properties may indeed be assumed to apply. This standard will not apply to any routines for general processing of probability distributions.

### 6.9.2 Packages for Representing Distributions

These standards encourage the use of packages for general representation of probability distributions, especially as this allows distributional assumptions to be readily tested, refined, and updated, rather than remaining hard-coded and effectively fixed. The [CRAN Task View on Probability Distributions](https://cran.r-project.org/web/views/Distributions.html) has a sub-section under [the “Miscellaneous” heading](https://cran.r-project.org/web/views/Distributions.html#Misc) on *Unified interface to handle distributions*. Packages mentioned in that sub-section include:

- The core [`stats`](https://cran.r-project.org/web/packages/STAT/index.html) package distributed wtih base `R`;
- The [`distr` family of packages](https://distr.r-forge.r-project.org/), which offer an extremely powerful and flexibility range of S4-class objects for representing and manipulating probability distributions;
- The [`distributions3`](https://github.com/alexpghayes/distributions3) and [`distributional`](https://github.com/mitchelloharawild/distributional) packages for representing and manipulating probability distributions as S3 objects; and
- The [`distr6` package](https://github.com/alan-turing-institute/distr6/) for distributions as [`R6`](https://r6.r-lib.org) objects.

The follow standard should be adhered to where possible:

- **PD2.0** *Where possible, software should represent probability distributions using a package for general representation.*

Any one package will generally only be able to fulfil either this or the preceding standard (**PD1.0**): it will either use a particular distribution, and thus need to adhere to **PD1.0**, or it will treat distributions more generally, and thus need to adhere to **PD2.0**.

### 6.9.3 Algorithms

- **PD3.0** *Manipulation of probability distributions should very generally be analytic, with numeric manipulations only implemented with clear justification (ideally including references).*

An exemplary discussion of conditions under which numeric manipulations may be considered is provided in the [*Analytical and Numerical Methods* vignette](https://alan-turing-institute.github.io/distr6/articles/webs/analytic_and_numeric_methods.html) of the [`distr6` package](https://alan-turing-institute.github.io/distr6/).

- **PD3.1** *Operations on probability distributions should generally be contained within separate functions which themselves accept the names of the distributions as one input parameter.*

This standard enables assumptions on distributions to be readily tested and updated, and applies even to packages which use only one single and specific distribution in accordance with [**PD1.0**](#PD1_0). The names of distributions are generally best passed as single character values, processed via calls like `do.call(get(dist_name), list(args))` (although many other approaches are also possible). This standard is also important for the testing standards which follow.

#### 6.9.3.1 Optimisation algorithms

The following standard applies to operations on probability distributions which require calls to optimisation algorithms such as [`optimize()`](https://stat.ethz.ch/R-manual/R-devel/library/stats/html/optimize.html), [`optim()`](https://stat.ethz.ch/R-manual/R-devel/library/stats/html/optim.html), or any equivalent numerical optimisation routines from `stats` or other packages.

- **PD3.2** *Use of optimisation routines to estimate parameters from probability distributions should explicitly specify and explain values of all parameters, including all uses of default parameters.*
- **PD3.3** *Return objects which include values generated from optimisation algorithms should include information on optimisation algorithm and performance, minimally including the name of the algorithm used, the convergence tolerance, and the number of iterations.*

See below for additional [testing standards](#PD_testing) which also apply to probability distribution packages which use optimisation algorithms.

#### 6.9.3.2 Integration algorithms

- **PD3.4** *Use of routines to integrate probability distributions should explicitly document conditions under which integrals are expected to remain stable, and ideally include pre-processing checks for potentially unstable behaviour.*
- **PD3.5** *Integration routines should only rely on discrete summation where such use can be justified (for example, through providing a literature reference), in which case the following applies:*
  - **PD3.5a** *Use of discrete summation to approximate integrals must demonstrate that the Reimann sum has a finite limit (or, equivalently, must explicitly describe the conditions under which the sum may be expected to be finite).*

See below for additional [testing standards](#PD_testing) which also apply to probability distribution packages which use integration algorithms.

### 6.9.4 Fitting Distributions

Fitting distributions is an important component of many statistical analyses, yet R currently has only two packages for general distributional fitting: [`fitdistrplus`](https://github.com/aursiber/fitdistrplus) and [`fitteR`](https://cran.r-project.org/web/packages/fitteR/index.html). The field of distributional fitting is currently in very active development, and there are no notably “stable” approaches nor widely-used algorithms. This is reflected in the almost complete lack of mention of distributional fitting in the [*CRAN Task View on Probability Distributions*](https://cran.r-project.org/web/views/Distributions.html). The very last point in the current version of that *Task View* describes “*Parameter Estimation*”, and links to both of these packages.

Given this dynamically evolving nature of code and algorithms for distributional fitting, this book currently provides no standards for this aspect. We nevertheless encourage any authors using or implementing distributional fitting procedures to help develop standards, for which we recommend use of the [GitHub discussions channel for these standards](https://github.com/ropensci/statistical-software-review-book/discussions/58).

### 6.9.5 Testing

The following standards refer and apply to *functions which process probability distributions*, meaning functions defined in accordance with **PD2.1**, above. Such functions are referred to in the following standards as *probability distribution functions*.

- **PD4.0** *The numeric outputs of probability distribution functions should be tested, not just output structures. These tests should generally be tests for numeric equality.*

Numeric equality should always be tested within a defined tolerance (see [*General Standard* **G3.0**](#G3_0)).

- **PD4.1** *Tests for numeric equality should compare the output of of probability distribution functions with the output of code which explicitly demonstrates how such values are derived (generally defined in the same location in test files).*

A test fulfilling this standard will thus serve the dual purpose of testing the numeric results of a probability distribution function, and enabling anybody reading the test file to understand how those numeric results are derived.

- **PD4.2** *All functions constructed in accordance with **PD2.1** - that is, which use a fixed distribution, and which name that distribution as an input parameter - should be tested using at least two different distributions.*

A package may justifiably rely on one single kind of probability distribution. Adherence to this standard would then require that the function notionally accept one other distribution as well, with a test then reflecting an expectation that results generated with this alternative distribution will differ somehow.

#### 6.9.5.1 Testing Optimisation and Integration Algorithms

The following standards only apply to packages which use either optimisation or integration algorithms (or both), and so comply with [**PD3.2**](#PD3_2) and [**PD3_3**](#PD3_3) for optimisation, or with [**PD3.4**](#PD3_4) and [**PD3_5**](#PD3_5) for integration.

- **PD4.3** *Tests of optimisation or integration algorithms should compare default results with results generated with alternative values for every parameter, including all parameters for the chosen algorithm (whether exposed as function inputs or not).*

The following applies to any procedures other than simple one-dimensional optimisation or integration via routines such as [`stats::optimize()`](https://stat.ethz.ch/R-manual/R-devel/library/stats/html/optimize.html) or [`stats::integrate()`](https://stat.ethz.ch/R-manual/R-devel/library/stats/html/integrate.html).

- **PD4.4** *Tests of optimisation or integration algorithms should compare equivalent results generated with at least one alternative algorithm.*

Use of [the `stats::optim()` function](https://stat.ethz.ch/R-manual/R-devel/library/stats/html/optim.html), for example, would already meet this standard through complying with the previous **PD4.3**, because [`optim()`](https://rdrr.io/r/stats/optim.html) includes a `method` parameter naming one of several available optimisation methods. Many optimisation and integration routines nevertheless implement a single method, in which case adherence to this standard would require testing results against equivalent results generated via at least one alternative method.

Brenning, A. 2012. “Spatial Cross-Validation and Bootstrap for the Assessment of Prediction Rules in Remote Sensing: The R Package Sperrorest.” *2012 IEEE International Geoscience and Remote Sensing Symposium*, July, 5372–75. <https://doi.org/10.1109/IGARSS.2012.6352393>.

Muenchow, Jannes, Jakub Nowosad. n.d. *Chapter 11 Statistical Learning Geocomputation with R*. Accessed March 10, 2021. <https://geocompr.robinlovelace.net/>.

Schratz, Patrick, Jannes Muenchow, Eugenia Iturritxa, Jakob Richter, and Alexander Brenning. 2019. “Hyperparameter Tuning and Performance Assessment of Statistical and Machine-Learning Algorithms Using Spatial Data.” *Ecological Modelling* 406 (August): 109–20. <https://doi.org/10.1016/j.ecolmodel.2019.06.002>.

Valavi, Roozbeh, Jane Elith, José J. Lahoz‐Monfort, and Gurutzeta Guillera‐Arroita. 2019. “blockCV: An r Package for Generating Spatially or Environmentally Separated Folds for k-Fold Cross-Validation of Species Distribution Models.” *Methods in Ecology and Evolution* 10 (2): 225–32. https://doi.org/<https://doi.org/10.1111/2041-210X.13107>.
