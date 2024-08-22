---
title: "Chronic neck pain - Data Analysis"
author: "Marc A.T. Teunis & Martine Verwoerd"
site: bookdown::bookdown_site
output: 
    bookdown::gitbook:
        css: style.css
        number_sections: true
        anchor_sections: false
        split_by: chapter
        config:
            sharing:
                 github: yes
                 facebook: no
                 twitter: no
                 all: no
            toc:
                collapse: section
                scroll_highlight: yes
                before: <li class="toc-logo"><a href="./"></a> <h4 class=".paddingtitel ">painr</h2></li>
header-includes:
  - \usepackage{fontawesome5}
---





# Introduction {-}

## Abstract {-}
Objective: To develop and internally validate a prognostic model to predict chronic pain after a new episode of acute- or subacute nonspecific idiopathic, non-traumatic neck pain in patients presenting to physiotherapy primary care, emphasizing modifiable biomedical, psychological, and social factors. 
Design: A prospective cohort study with a 6-month follow-up between January 2020 and March 2023. 
Setting: 30 physiotherapy primary care practices.
Participants: Patients with a new presentation of nonspecific idiopathic, non-traumatic neck pain, with a duration lasting no longer than 12 weeks from onset. 
Baseline measures: Candidate prognostic variables collected from participants included age and sex, neck pain symptoms, work-related factors, general factors, psychological and behavioural factors, and the remaining factors: therapeutic relation and healthcare provider attitude.
Outcome measures: Pain intensity at 6 weeks, 3 months, and 6 months on a Numeric Pain Rating Scale (NPRS) after inclusion. A NPRS score of ≥3 at each time point was used to define chronic neck pain.  
Results: Sixty-two (10%) of the 603 participants developed chronic neck pain. The prognostic factors in the final model were sex, pain intensity, reported pain in different body regions, headache since and before the neck pain, posture during work, employment status, illness beliefs about pain identity and recovery, treatment beliefs, distress, and self-efficacy. The model demonstrated an optimism-corrected Area Under the Curve (AUC) of 0.83 and a corrected R2 of 0.24. Calibration was deemed acceptable to good, as indicated by the calibration curve. The Hosmer-Lemeshow test yielded a p-value of 0.7167, indicating a good model fit. 
Conclusion: This model has the potential to obtain a valid prognosis for developing chronic pain after a new episode of acute—and subacute nonspecific idiopathic, non-traumatic neck pain. It includes mostly potentially modifiable factors for physiotherapy practice. External validation of this model is recommended. 
Key words: neck pain, prognostic model, modifiable factors, chronic pain.


## Data Flow {-}
The following diagram discribes how data files and Rmd scripts are connected. Raw data input file lives in `./data-raw`, data output files are written to `./data` and the `.Rmd` files live in ./Rmd.


```{.r .Rchunk}
source(
  here::here(
    "inst",
    "data_flow.R"
  )
)
data_flow
```

```{=html}
<div class="DiagrammeR html-widget html-fill-item" id="htmlwidget-f8372137b18b09d98aec" style="width:672px;height:480px;"></div>
<script type="application/json" data-for="htmlwidget-f8372137b18b09d98aec">{"x":{"diagram":"\n   graph LR\n\n    subgraph data-raw\n        A((\"D010/SPSS basis File results.sav\"))\n    end\n\n    subgraph Rmd\n        B{\"01_eda_Rmd\"}\n        E{\"02_imputation.Rmd\"}\n        H{\"03_exploratory_statistics.Rmd\"}\n    end\n\n    subgraph data\n        C[\"df_non_imp_select.rds\"]\n        D[\"labelling_and_coding_vars.csv\"]\n        F[\"data-list.rds\"]\n        G[\"df_imputed.rds\"]\n    end\n\n\n     A((\"D010/SPSS basis File results.sav\")) --> B{\"01_eda_Rmd\"}\n     B{\"01_eda_Rmd\"} --> C[\"df_non_imp_select.rds\"]\n     B{\"01_eda_Rmd\"} --> D[\"labelling_and_coding_vars.csv\"]\n     C[\"df_non_imp_select.rds\"] --> E{\"02_imputation.Rmd\"}\n     A((\"SPSS basis File results.sav\")) --> E{\"02_imputation.Rmd\"}\n     E{\"02_imputation.Rmd\"} --> F[\"data-list.rds\"]\n     E{\"02_imputation.Rmd\"} --> G[\"...date...df_imputed.rds\"]\n     G[\"...date...df_imputed.rds\"] --> H{\"03_exploratory_statistics.Rmd\"}\n     F[\"data-list.rds\"] --> H{\"03_exploratory_statistics.Rmd\"}\n\n"},"evals":[],"jsHooks":[]}</script>
```

Please also provide attribution to R itself

```{.r .Rchunk}
citation()
```

```{.Rout}
## To cite R in publications use:
## 
##   R Core Team (2023). _R: A Language and Environment for Statistical
##   Computing_. R Foundation for Statistical Computing, Vienna, Austria.
##   <https://www.R-project.org/>.
## 
## A BibTeX entry for LaTeX users is
## 
##   @Manual{,
##     title = {R: A Language and Environment for Statistical Computing},
##     author = {{R Core Team}},
##     organization = {R Foundation for Statistical Computing},
##     address = {Vienna, Austria},
##     year = {2023},
##     url = {https://www.R-project.org/},
##   }
## 
## We have invested a lot of time and effort in creating R, please cite it
## when using it for data analysis. See also 'citation("pkgname")' for
## citing R packages.
```

The `{tidyvese}`

```{.r .Rchunk}
citation(package = "tidyverse")
```

```{.Rout}
## To cite package 'tidyverse' in publications use:
## 
##   Wickham H, Averick M, Bryan J, Chang W, McGowan LD, François R,
##   Grolemund G, Hayes A, Henry L, Hester J, Kuhn M, Pedersen TL, Miller
##   E, Bache SM, Müller K, Ooms J, Robinson D, Seidel DP, Spinu V,
##   Takahashi K, Vaughan D, Wilke C, Woo K, Yutani H (2019). "Welcome to
##   the tidyverse." _Journal of Open Source Software_, *4*(43), 1686.
##   doi:10.21105/joss.01686 <https://doi.org/10.21105/joss.01686>.
## 
## A BibTeX entry for LaTeX users is
## 
##   @Article{,
##     title = {Welcome to the {tidyverse}},
##     author = {Hadley Wickham and Mara Averick and Jennifer Bryan and Winston Chang and Lucy D'Agostino McGowan and Romain François and Garrett Grolemund and Alex Hayes and Lionel Henry and Jim Hester and Max Kuhn and Thomas Lin Pedersen and Evan Miller and Stephan Milton Bache and Kirill Müller and Jeroen Ooms and David Robinson and Dana Paige Seidel and Vitalie Spinu and Kohske Takahashi and Davis Vaughan and Claus Wilke and Kara Woo and Hiroaki Yutani},
##     year = {2019},
##     journal = {Journal of Open Source Software},
##     volume = {4},
##     number = {43},
##     pages = {1686},
##     doi = {10.21105/joss.01686},
##   }
```

`{tidymodels}`

```{.r .Rchunk}
citation(package = "tidymodels")
```

```{.Rout}
## To cite package 'tidymodels' in publications use:
## 
##   Kuhn et al., (2020). Tidymodels: a collection of packages for
##   modeling and machine learning using tidyverse principles.
##   https://www.tidymodels.org
## 
## A BibTeX entry for LaTeX users is
## 
##   @Manual{,
##     title = {Tidymodels: a collection of packages for modeling and machine learning using tidyverse principles.},
##     author = {Max Kuhn and Hadley Wickham},
##     url = {https://www.tidymodels.org},
##     year = {2020},
##   }
```

