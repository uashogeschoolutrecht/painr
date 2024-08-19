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

General intro to the project and the data

Download the source code [<svg viewBox="0 0 496 512" style="height:1em;position:relative;display:inline-block;top:.1em;" xmlns="http://www.w3.org/2000/svg">  <path d="M165.9 397.4c0 2-2.3 3.6-5.2 3.6-3.3.3-5.6-1.3-5.6-3.6 0-2 2.3-3.6 5.2-3.6 3-.3 5.6 1.3 5.6 3.6zm-31.1-4.5c-.7 2 1.3 4.3 4.3 4.9 2.6 1 5.6 0 6.2-2s-1.3-4.3-4.3-5.2c-2.6-.7-5.5.3-6.2 2.3zm44.2-1.7c-2.9.7-4.9 2.6-4.6 4.9.3 2 2.9 3.3 5.9 2.6 2.9-.7 4.9-2.6 4.6-4.6-.3-1.9-3-3.2-5.9-2.9zM244.8 8C106.1 8 0 113.3 0 252c0 110.9 69.8 205.8 169.5 239.2 12.8 2.3 17.3-5.6 17.3-12.1 0-6.2-.3-40.4-.3-61.4 0 0-70 15-84.7-29.8 0 0-11.4-29.1-27.8-36.6 0 0-22.9-15.7 1.6-15.4 0 0 24.9 2 38.6 25.8 21.9 38.6 58.6 27.5 72.9 20.9 2.3-16 8.8-27.1 16-33.7-55.9-6.2-112.3-14.3-112.3-110.5 0-27.5 7.6-41.3 23.6-58.9-2.6-6.5-11.1-33.3 2.6-67.9 20.9-6.5 69 27 69 27 20-5.6 41.5-8.5 62.8-8.5s42.8 2.9 62.8 8.5c0 0 48.1-33.6 69-27 13.7 34.7 5.2 61.4 2.6 67.9 16 17.7 25.8 31.5 25.8 58.9 0 96.5-58.9 104.2-114.8 110.5 9.2 7.9 17 22.9 17 46.4 0 33.7-.3 75.4-.3 83.6 0 6.5 4.6 14.4 17.3 12.1C428.2 457.8 496 362.9 496 252 496 113.3 383.5 8 244.8 8zM97.2 352.9c-1.3 1-1 3.3.7 5.2 1.6 1.6 3.9 2.3 5.2 1 1.3-1 1-3.3-.7-5.2-1.6-1.6-3.9-2.3-5.2-1zm-10.8-8.1c-.7 1.3.3 2.9 2.3 3.9 1.6 1 3.6.7 4.3-.7.7-1.3-.3-2.9-2.3-3.9-2-.6-3.6-.3-4.3.7zm32.4 35.6c-1.6 1.3-1 4.3 1.3 6.2 2.3 2.3 5.2 2.6 6.5 1 1.3-1.3.7-4.3-1.3-6.2-2.2-2.3-5.2-2.6-6.5-1zm-11.4-14.7c-1.6 1-1.6 3.6 0 5.9 1.6 2.3 4.3 3.3 5.6 2.3 1.6-1.3 1.6-3.9 0-6.2-1.4-2.3-4-3.3-5.6-2z"></path></svg>](https://github.com/uashogeschoolutrecht/painr)

**Martine -> please write a general introduction on the project here: --->
...

## Data Flow
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
<div class="DiagrammeR html-widget html-fill-item" id="htmlwidget-b81ab1d2edbe7b71d751" style="width:672px;height:480px;"></div>
<script type="application/json" data-for="htmlwidget-b81ab1d2edbe7b71d751">{"x":{"diagram":"\n   graph LR\n\n    subgraph data-raw\n        A((\"D010/SPSS basis File results.sav\"))\n    end\n\n    subgraph Rmd\n        B{\"01_eda_Rmd\"}\n        E{\"02_imputation.Rmd\"}\n        H{\"03_exploratory_statistics.Rmd\"}\n    end\n\n    subgraph data\n        C[\"df_non_imp_select.rds\"]\n        D[\"labelling_and_coding_vars.csv\"]\n        F[\"data-list.rds\"]\n        G[\"df_imputed.rds\"]\n    end\n\n\n     A((\"D010/SPSS basis File results.sav\")) --> B{\"01_eda_Rmd\"}\n     B{\"01_eda_Rmd\"} --> C[\"df_non_imp_select.rds\"]\n     B{\"01_eda_Rmd\"} --> D[\"labelling_and_coding_vars.csv\"]\n     C[\"df_non_imp_select.rds\"] --> E{\"02_imputation.Rmd\"}\n     A((\"SPSS basis File results.sav\")) --> E{\"02_imputation.Rmd\"}\n     E{\"02_imputation.Rmd\"} --> F[\"data-list.rds\"]\n     E{\"02_imputation.Rmd\"} --> G[\"...date...df_imputed.rds\"]\n     G[\"...date...df_imputed.rds\"] --> H{\"03_exploratory_statistics.Rmd\"}\n     F[\"data-list.rds\"] --> H{\"03_exploratory_statistics.Rmd\"}\n\n"},"evals":[],"jsHooks":[]}</script>
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

