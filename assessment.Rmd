
# Assessment {#assessment}

The preceding [*Standards* section](#standards) primarily served (in its
current form) to illustrate one possible approach to standards used to
prospectively guide software during development. In contrast, the present
section lists aspects of software, both general and specific to statistical
software, which may usefully assessed in order to give insight into structure,
function, and other aspects. The following list of assessments is ultimately
intended to inform our development of a stand-alone tool, and potentially also
a publicly available service, which can be used by any developers to assess
their own software.

We accordingly intend the following standards to be used both for retrospective
purposes of peer review, and for prospective use in developing software both in
general, and in preparation for peer-review. It is important to consider the
applicability of each metric to different categories of statistical software,
as well as the extent to which the following aspects may be more or less
applicable or relevant at different phases of a software life cycle, or how
expected values for, or results of applying, metrics may vary throughout
a software life cycle.

## General Software Metrics

The following is an incomplete list of the kinds of metrics commonly used to
evaluate software in general, and which might provide useful for assessing
statistical software in the present project.

-   Code structure
    -   Cyclomatic complexity
    -   Codebase size
    -   Function size / number
    -   Numbers of external calls within functions
    -   Numbers and proportions of Exported / non exported functions
    -   Code consistency
    -   Dynamic metrics derived from function call networks or similar
        -   Network-based metrics both for entire packages, for individual
            functions, and derived from analyses of test coverage
        -   Functional overlap with other packages

-   Documentation metrics:
    -   Numbers of documentation lines per function
    -   Proportion of documentation to code lines
    -   Presence of examples
    -   Vignettes

-   Data documentation metrics
    -   Intended and/or permitted kinds of input data
    -   Nature of output data
    -   Description of data used in tests

-   Meta structure
    -   Dependencies
    -   Reverse dependencies

-   Meta metrics
    -   License (type, availability, compatibility)
    -   Version control?
    -   Availability of website
    -   Availability of source code (beyond CRAN or similar)
    -   Community:
        -   Software downloads and usage statistics
        -   Numbers of active contributors
        -   Numbers or rates of issues reported
    -   Maintenance:
        -   Rate/Numbers of releases
        -   Rate of response to reported issues
        -   Last commit
        -   Commit rate
    -   stars (for github, gitlab, or equivalent for other platforms)
    -   forks

-   Extent of testing
    -   Code coverage
    -   Examples and their coverage
    -   Range of inputs tested

-   Nature of testing
    -   Testing beyond `R CMD check`?
    -   Testing beyond concrete testing?

## Metrics specific to statistical software

Metrics specific to statistical software will depend on, and vary in
applicability or relevance with, the system for categorizing statistical
software expected to emerge from the initial phase of this project. Details
of this sub-section will be largely deferred until we have a clearer view of
what categories might best be considered, which we are hopeful will emerge
following the first committee meeting, and in response to ensuing feedback. In
the meantime, metrics can be anticipated by referring to the preceding examples
for categories of statistical software (numerical standards, method validity,
software scope, and reference standards). We anticipate having a number of such
categories, along with a number of corresponding metrics for assessing software
in regard to each category. As mentioned at the outset, software will generally
be expected to fit within multiple categories, and specific metrics will need
to be developed to ensure validity for software encompassing any potential
combination of categories.

## Diagnostics and Reporting


While the preceding sub-sections considered *what* might be assessed in
relation to statistical software, the project will also need to explicitly
consider *how* any resultant assessment might best be presented and reported
upon. Indeed, a key output of the project is expected to be a suite of tools
which can be used both in this and other projects to construct, curate, and
report upon a suite of peer-reviewed software. Moreover, we will aim to develop
these tools partly to provide or enhance the *automation* of associated
processes, aiming both to enhance adaptability and transferability, and to
ensure the scalability of our own project.

It is useful in this context to distinguish between *collective* tools useful
for, of applicable to, collections of software, of individuals, or of processes
pertaining to either (here, primarily peer review), and *singular* tools of
direct applicability to individual pieces of software. We envision needing to
address the (likely relative) importance of some of the following kinds of
diagnostic and reporting tools which may be usefully developed.

**Collective Tools**

-   Qualitative tools useful in assessing or formalizing categories of software
-   Quantitative tools to retrospectively assess such aspects as:
    -   Collective "quality" of software
    -   Community engagement
    -   Effectiveness (or other metrics) of review

**Singular Tools**

-   Quantitative tools that can be prospectively used to
    -   Improve or assure software quality
    -   Document aspects of software quality
    -   Aid modularity or transferability either of software, or of the tools
        themselves
-   Tools to formalize structural aspects of software such as tests (for
    example, through implementing new frameworks or grammars)
-   Extensions of extant packages such as **lintr**, **covr**, **goodpractice**
-   Comparisons of package metrics to distributions for other packages or
    systems (such as the CRAN archive directories)
-   Diagnostic and report aggregation, design, or automatic creation at any
    stage before, during, or after peer review.

The one question of abiding importance is the extent to which any such tools,
and/or the automation of processes which they may enable, might enhance any of
the following aspects:

- Software development
- Peer review of software
- Wider communities of users or developers
- The adaptation of our system to other domains

## Proposals and Aims

1. We develop a system to automatically assess aspects of software detailed in
   the above list (and more).<br>**AIM:** *To assess software in as much detail
   as possible, while reducing the burden on developers of manual assessment.*
2. The development of this system extend from the
   [`riskmetric`](https://github.com/pharmar/riskmetric) package developed by
   the [PharmaR group](https://pharmar.org).<br>**AIM:** *To efficiently re-use
   work, prevent duplication, and develop our system as quickly as possible.*
3. We provide this assessment both as a stand-alone R package, and a publicly
   available service which receives text links to publicly available
   repositories (and does not enable upload of binary software).<br>**AIM:**
   *To extend engagement with the present project beyond just those directly
   interested in submitting software for review, and so to enhance broader
   community engagement with both this project, and rOpenSci in general.*
4. Considerable effort be devoted to developing a coherent and adaptable system
   to summarise and report on software assessment.<br>**AIM:** *To devise
   a reporting system which imposes a low cognitive burden on both developers
   and reviewers needing to assess packages.*
5. We simultaneously develop a system for assessing historical development of
   all available metrics, through applying our assessment system to all
   packages in the CRAN and bioconductor archives, and we use comparisons with
   these historical patterns to inform and guide our reporting
   system.<br>**AIM:** *To ensure standards and assessments reflect enacted
   practices, rather than just theoretical assumptions, and to ensure that
   standards and assessments keep apace with ongoing developments of
   practices.*

