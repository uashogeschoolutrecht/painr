[![DOI](https://zenodo.org/badge/855633465.svg)](https://zenodo.org/doi/10.5281/zenodo.13744555)

# painr; An R data and analysis package, studying chronicity of neck pain in human patients

## Scope and introduction



This work is currently submitted as: ......

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
