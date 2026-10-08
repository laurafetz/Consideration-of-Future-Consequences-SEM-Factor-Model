# Project-4-SEM-Factor-Model
# Consideration of Future Consequences: Factor Structure and Gender Invariance in R

This project investigates the dimensional structure of teenagers' **Consideration of Future Consequences (CFC)** and examines whether the construct is measured equivalently across gender identities.

The analysis was conducted in R using confirmatory factor analysis (CFA), multiple-group structural equation modelling (SEM), nested model comparisons, measurement invariance testing, and latent mean comparisons.

## Research Questions

1. Is CFC better represented by a single latent factor or by two correlated factors distinguishing **Prospective CFC (PCFC)** and **Immediate CFC (ICFC)**?
2. Does the measurement structure of CFC remain invariant across gender identity groups?
3. Are there differences in latent CFC means across gender identities?

## Data

The analysis uses a subset of the **Open-Source Psychometrics Project** data collected in 2011–2012, comprising **5,525 respondents aged 13–19 years** (mean age = 16.72 years, SD = 1.64) from **111 countries**.

CFC was measured using the **12-item Consideration of Future Consequences Scale** (Strathman et al., 1994), with responses on a five-point Likert scale.

| Variable | Description |
| --- | --- |
| `Q1`–`Q12` | Responses to the 12 CFC questionnaire items |
| `age` | Respondent age |
| `gender` | Self-reported gender identity grouping |
| `country` | Respondent country |
| `continent` | Derived geographical grouping |

Seven negatively worded items were reverse-coded, and scale items were mean-centred before model estimation. Missingness was explored, and full information maximum likelihood (FIML) was used to handle missing observations in model estimation.

## Analysis

The analysis consists of several steps:

1. **Data preparation and exploration:** Recode relevant CFC items, centre the items, inspect descriptive statistics and missingness, and derive geographical categories.
2. **One-factor CFA:** Estimate a model in which all 12 items load on one CFC factor.
3. **Two-factor CFA:** Estimate a model distinguishing PCFC (items Q1, Q2, Q6, Q7, Q8) from ICFC (items Q3, Q4, Q5, Q9, Q10, Q11, Q12).
4. **Model comparison:** Compare nested factor models using a chi-square difference test, Akaike Information Criterion (AIC), Comparative Fit Index (CFI), and Root Mean Square Error of Approximation (RMSEA).
5. **Measurement invariance:** Test configural, metric (equal factor loadings), and scalar (equal loadings and item intercepts) invariance across gender identity groups.
6. **Latent mean comparisons:** Examine group differences using the final scalar-invariance model.
7. **Power analysis and visualisation:** Assess sensitivity to close-fit hypotheses using the `power4SEM` Shiny app and visualise the factor models and data characteristics.

## Results

The **two-factor model** provided a better fit than the one-factor model.

| Model | CFI | RMSEA | AIC |
| --- | ---: | ---: | ---: |
| One-factor CFA | 0.912 | 0.077 | 196,367 |
| Two-factor CFA | 0.951 | 0.058 | 195,576 |

The report found evidence consistent with **scalar measurement invariance** across gender identity groups: constraining factor loadings and item intercepts did not significantly worsen model fit. No significant latent mean differences were reported between boys and girls. Respondents in the diverse-gender-identity group had lower estimated means on both CFC factors relative to boys.

**Interpretation note:** The diverse-gender-identity subgroup was small (reported *n* = 77), and the report identified limitations related to missing gender data and lower power for this subgroup. These comparisons therefore require caution. Results are observational and do not support causal interpretations.

## Methods & R Packages

The project demonstrates the use of:

- Confirmatory factor analysis (CFA)
- Structural equation modelling (SEM)
- Multiple-group modelling
- Configural, metric, and scalar measurement invariance
- Latent mean comparisons
- Full information maximum likelihood (FIML)
- Nested model comparison and chi-square difference testing
- Model fit assessment (CFI, RMSEA, AIC)
- Standardised factor loadings and parameter interpretation
- Missing-data exploration, power analysis, and statistical visualisation

### Packages

```r
library(lavaan)
library(semTools)
library(tidyverse)
library(dplyr)
library(psych)
library(haven)
library(countrycode)
library(semPlot)
library(ggplot2)
```

An additional RMSEA-based power analysis was carried out using the external **power4SEM Shiny app**.

## Repository Structure

```text
R-Project-4-SEM-Factor-Model/
│
├── Project 4 - SEM Factor Model.docx   # Written analysis and results
├── README.md                           # Project documentation
└── [R analysis script, if added]       # Source code for reproducing the analysis
```

## Running the Analysis

The uploaded report documents the analysis and its results, but **does not contain the complete R script or raw dataset**. Reproducing the models therefore requires the original questionnaire data and the analysis code.

Once the R script and data are added to this repository, this section can be updated with the exact file paths and instructions for running the project in R or RStudio.

## Skills Demonstrated

This project demonstrates applied psychometric modelling in R, including factor-model specification, multiple-group CFA, measurement invariance testing, comparison of nested models, latent mean estimation, missing-data handling, model-fit interpretation, statistical visualisation, and critical assessment of subgroup results.

## Author

Laura M. Fetz
