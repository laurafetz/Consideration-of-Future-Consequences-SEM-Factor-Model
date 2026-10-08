# Consideration of Future Consequences: Factor Structure and Invariance

A coursework analysis of the 12-item Consideration of Future Consequences scale using confirmatory factor analysis and multiple-group measurement invariance tests. The report describes 5,525 respondents aged 13–19 from the Open-Source Psychometrics Project data collected in 2011–2012.

## Findings in the original report

| Model | CFI | RMSEA | AIC |
| --- | ---: | ---: | ---: |
| One factor | 0.912 | 0.077 | 196,367 |
| Two correlated factors | 0.951 | 0.058 | 195,576 |

The two-factor specification distinguishes prospective and immediate consequences. The report describes scalar invariance across gender groups and latent mean comparisons. Its smallest gender subgroup had 77 respondents, so subgroup estimates and absence of significant differences warrant careful interpretation. These are observational results.

The table is taken from [the original report](docs/original_report.docx). The participant data used in that report are not included in this repository, so the table is a record of the original analysis rather than a new model rerun.

## Source and data requirements

`analysis.R` contains the original model specifications with a configurable input path. It expects a tab-delimited CFCS questionnaire file with `Q1`–`Q12`, `age`, `gender`, `country`, and `accuracy`; the original missing-value code is `0`. The analysis reverse-codes seven items, centres item responses, fits the one- and two-factor models with FIML, and tests configural, metric, and scalar invariance.

The source data catalogue is [Open-Source Psychometrics](https://openpsychometrics.org/_rawdata/). The precise course subset and its preprocessing must be recovered before treating a run as a reproduction of the report.

With the matching data available:

```r
install.packages(c("lavaan", "tidyverse", "countrycode", "psych", "semPlot"))
```

```bash
Rscript analysis.R /path/to/CFCS.tsv
```

This repository provides source code and a report; it is not a self-contained empirical reproduction.

## Files

```text
Consideration-of-Future-Consequences-SEM-Factor-Model/
├── analysis.R
├── docs/original_report.docx
├── .gitignore
└── README.md
```

Laura M. Fetz
