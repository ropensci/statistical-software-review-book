# rOpenSci Statistical Software Peer Review

Documentation of rOpenSci’s project on expanding software peer review to include statistical software.

Author

Mark Padgham and Noam Ross

# 1 Welcome

Welcome to [rOpenSci](https://ropensci.org)’s system for peer-review of statistical software in R packages and beyond. This system extends our existing system for [software peer review](https://ropensci.org/software-review/), through [expanding the scope](https://ropensci.org/blog/2019/07/15/expanding-software-review/) to include explicitly statistical software. As such, it is a direct extension of [rOpenSci Packages: Development, Maintenance, and Peer Review](https://devguide.ropensci.org/). This book provides guidelines for authors on how to develop statistical software, and for editors and reviewers on our processes for peer review of statistical software.

You are invited to contribute to this project by participating in our [GitHub Discussions](https://github.com/ropensci/statistical-software-review-book/discussions), or filing suggestions as [issues in the book’s GitHub repository](https://github.com/ropensci/statistical-software-review-book/issues). Feedback on standards is particularly welcome, for which [the Discussions](https://github.com/ropensci/statistical-software-review-book/discussions) have dedicated pages for each category of standards.

Submissions of statistical software for our peer-review system are currently handled by the following team of expert editors:

- [Adam Sparks](https://adamhsparks.netlify.app/), Department of Primary Industries and Regional Development, Western Australia.
- [Emi Tanaka](https://emitanaka.org/), Biological Data Science Institute, Australian National University
- [Jouni Helske](https://jounihelske.netlify.app/), University of Jyväskylä, Finland.
- [Rebecca Killick](http://www.lancs.ac.uk/~killick/), Lancaster University, UK
- [Toby Hocking](http://tdhock.github.io/), Northern Arizona University, USA

This project has developed to its current state largely through the support of a great advisory and editorial committee. We are grateful to all of the following former members:

- [Ben Bolker](https://ms.mcmaster.ca/~bolker/) ([@bolkerb](https://twitter.com/bolkerb)) McMaster University, Canada
- [Leonardo Collado-Torres](http://lcolladotor.github.io/) ([@lcolladotor](https://twitter.com/lcolladotor)), Lieber Institute for Brain Development, USA
- [Max Kuhn](http://appliedpredictivemodeling.com/) ([@topepos](https://twitter.com/topepos)), RStudio
- [Martin Morgan](https://www.roswellpark.org/martin-morgan) ([@mt_morgan](https://twitter.com/mt_morgan)), Roswell Park Comprehensive Cancer Center
- [Stephanie Hicks](https://www.stephaniehicks.com/) ([@stephaniehicks](https://twitter.com/stephaniehicks)), Johns Hopkins University, USA
- [Paula Moraga](http://www.paulamoraga.com/), King Abdullah University of Science and Technology, Saudi Arabia

This work was largely [supported by the Sloan Foundation](https://ropensci.org/blog/2019/07/15/expanding-software-review/) and organized under an [R Consortium Working Group](https://www.r-consortium.org/projects/isc-working-groups).

## 1.1 Citation

You can cite this book by its [its Zenodo DOI](https://doi.org/10.5281/zenodo.5556755), or by copying the following BibTeX entry:

``` bibtex
@software{mark_padgham_2021_5556756,
  author       = {mark padgham and
                  Maëlle Salmon and
                  Noam Ross and
                  Jakub Nowosad and
                  Rich FitzJohn and
                  yilong zhang and
                  Christoph Sax and
                  Francisco Rodriguez-Sanchez and
                  François Briatte and
                  Leonardo Collado-Torres},
  title        = {ropensci/statistical-software-review-book:
                   Official first standards versions
                  },
  month        = oct,
  year         = 2021,
  publisher    = {Zenodo},
  version      = {v0.1.0},
  doi          = {10.5281/zenodo.5556756},
  url          = {https://doi.org/10.5281/zenodo.5556756},
}
```

## 1.2 Contributors

All contributions to this project are gratefully acknowledged using the [`allcontributors` package](https://github.com/ropensci/allcontributors) following the [allcontributors](https://allcontributors.org) specification. Contributions of any kind are welcome!

### 1.2.1 Content

[TABLE]

### 1.2.2 Issue Authors

[TABLE]
