## Package Review

*Please check off boxes as applicable, and elaborate in comments below.  Your review is not limited to these topics, as described in the reviewer guide*

- Briefly describe any working relationship you may have (had) with the package authors (or otherwise remove this statement)

- [ ] As the reviewer I confirm that there are no [conflicts of interest](https://devguide.ropensci.org/policies.html#coi) for me to review this work (If you are unsure whether you are in conflict, please speak to your editor _before_ starting your review).

---

### Compliance with Standards

- [ ] This package complies with a sufficient number of standards for a (bronze/silver/gold) badge
- [ ] This grade of badge is the same as what the authors wanted to achieve

The following standards currently deemed non-applicable (through tags of `@srrstatsNA`) could potentially be applied to future versions of this software: (Please specify)

Please also comment on any standards which you consider either particularly well, or insufficiently, documented.

For packages aiming for silver or gold badges:

- [ ] This package extends beyond minimal compliance with standards in the following ways: (please describe)

---

### General Review

#### Documentation

The package includes all the following forms of documentation:

- [ ] **A statement of need** clearly stating problems the software is designed to solve and its target audience in README
- [ ] **Installation instructions:** for the development version of package and any non-standard dependencies in README
- [ ] **Community guidelines** including contribution guidelines in the README or CONTRIBUTING
- [ ] The documentation is sufficient to enable general use of the package beyond one specific use case

The following sections of this template include questions intended to be used as guides to provide general, descriptive responses. Please remove this, and any subsequent lines that are not relevant or necessary for your final review.

#### Algorithms

- How well are algorithms encoded?
- Is the choice of computer language appropriate for that algorithm, and/or envisioned use of package?
- Are aspects of algorithmic scaling sufficiently documented and tested?
- Are there any aspects of algorithmic implementation which could be improved?

#### Testing

- Regardless of actual coverage of tests, are there any fundamental software operations which are not sufficiently expressed in tests? 
- Is there a need for extended tests, or if extended tests exists, have they been implemented in an appropriate way, and are they appropriately documented?

#### Visualisation (where appropriate)

- Do visualisations aid the primary purposes of statistical interpretation of results?
- Are there any aspects of visualisations which could risk statistical misinterpretation?

#### Package Design

- Is the package well designed for its intended purpose?
- In relation to **External Design:** Do exported functions and the relationships between them enable general usage of the package? 
- In relation to **External Design:** Do exported functions best serve inter-operability with other packages?
- In relation to **Internal Design:** Are algorithms implemented appropriately in terms of aspects such as efficiency, flexibility, generality, and accuracy? 
- In relation to **Internal Design:** Could ranges of admissible input structures, or form(s) of output structures, be expanded to enhance inter-operability with other packages?

---

- [ ] **Packaging guidelines**: The package conforms to the rOpenSci packaging guidelines

Estimated hours spent reviewing:

- [ ] Should the author(s) deem it appropriate, I agree to be acknowledged as a package reviewer ("rev" role) in the package DESCRIPTION file.
