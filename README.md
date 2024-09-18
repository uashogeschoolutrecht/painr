[![DOI](https://zenodo.org/badge/855633465.svg)](https://zenodo.org/doi/10.5281/zenodo.13744555)

# painr; An R data and analysis package, studying chronicity of neck pain in human patients

## This work is publshed as

Verwoerd MJ, Wittink H, Maissan F, et al
Development and internal validation of a multivariable prognostic model to predict chronic pain after a new episode of non-specific idiopathic, non-traumatic neck pain in physiotherapy primary care practice
BMJ Open 2024;14:e086683. doi: 10.1136/bmjopen-2024-086683


## Scope and introduction

**Objective** To develop and internally validate a prognostic model to predict chronic pain after a new episode of acute or subacute non-specific idiopathic, non-traumatic neck pain in patients presenting to physiotherapy primary care, emphasising modifiable biomedical, psychological and social factors.
**Design** A prospective cohort study with a 6-month follow-up between January 2020 and March 2023.
Setting 30 physiotherapy primary care practices.
**Participants** Patients with a new presentation of non-specific idiopathic, non-traumatic neck pain, with a duration lasting no longer than 12 weeks from onset.
**Baseline measures** Candidate prognostic variables collected from participants included age and sex, neck pain symptoms, work-related factors, general factors, psychological and behavioural factors and the remaining factors: therapeutic relation and healthcare provider attitude.
**Outcome measures** Pain intensity at 6 weeks, 3 months and 6 months on a Numeric Pain Rating Scale (NPRS) after inclusion. An NPRS score of ≥3 at each time point was used to define chronic neck pain.
**Results** 62 (10%) of the 603 participants developed chronic neck pain. The prognostic factors in the final model were sex, pain intensity, reported pain in different body regions, headache since and before the neck pain, posture during work, employment status, illness beliefs about pain identity and recovery, treatment beliefs, distress and self-efficacy. The model demonstrated an optimism-corrected area under the curve of 0.83 and a corrected R2 of 0.24. Calibration was deemed acceptable to good, as indicated by the calibration curve. The Hosmer–Lemeshow test yielded a p-value of 0.7167, indicating a good model fit.
**Conclusion** This model has the potential to obtain a valid prognosis for developing chronic pain after a new episode of acute and subacute non-specific idiopathic, non-traumatic neck pain. It includes mostly potentially modifiable factors for physiotherapy practice. External validation of this model is recommended.

## Installation
This github repo contains an R-package called `{painr}` that includes all the data, the exploratory data analyses and the inferential statistical analysis of data collected from a study with patients presenting themselfselves at a collection of physiotherapy practices. Their clinical pain score was measured of the course of six months at three time points. Furthermore, scores for a psychosocial and fysical capabilities questionnaire were included in the study. Modifiable factors were indentified and anlysed for their contribution to the outcome: chronic or non-chronic neck pain.

To install the R package:

### Method 1
```
install.packages("remotes")
remotes::install_github("uashogeschoolutrecht/painr")
```

### Method 2
or run a terminal:
```
git clone https://github.com/uashogeschoolutrecht/painr
```

and run in R
```
install.packages("devtools")
devtools::install()
```

## Bookdown
The folder "./bookdown" in this repo contains extensive documentation on the data, the exploratory data analysis, missing value imputation and how the prognostic model was build and evaluated.

To build and view the bookdown website, clone the repo to your local session and  install `{painr}` according installation method 2. Then run in R:

```
bookdown::render_book("")
```

## Shiny app
The `{painr}` package has build in data that can be explored with a Shiny application that is shipped with the package code. After installation, run in R:
```
library(painr)
launch_shiny_app()
```

## Licence
This work is distrubted under a CC-BY NC licence. Please pay attribution to this work and te original publication associated with it. For citation info, see the 'cite this repo' information. 

## Contributions and issues
We appreciate reuse, adaptation and extension of this work. Reach out to us via a Github Issue if you find something is not working or if you have a feature request. We recommend following the Github workflow for active contributions (fork -> edit/add -> pull request)   
