## Data flow

data_flow <- DiagrammeR::DiagrammeR(
'
   graph LR

    subgraph data-raw
        A(("D010/SPSS basis File results.sav"))
    end

    subgraph Rmd
        B{"01_eda_Rmd"}
        E{"02_imputation.Rmd"}
        H{"03_exploratory_statistics.Rmd"}
    end

    subgraph data
        C["df_non_imp_select.rds"]
        D["labelling_and_coding_vars.csv"]
        F["data-list.rds"]
        G["df_imputed.rds"]
    end


     A(("D010/SPSS basis File results.sav")) --> B{"01_eda_Rmd"}
     B{"01_eda_Rmd"} --> C["df_non_imp_select.rds"]
     B{"01_eda_Rmd"} --> D["labelling_and_coding_vars.csv"]
     C["df_non_imp_select.rds"] --> E{"02_imputation.Rmd"}
     A(("SPSS basis File results.sav")) --> E{"02_imputation.Rmd"}
     E{"02_imputation.Rmd"} --> F["data-list.rds"]
     E{"02_imputation.Rmd"} --> G["...date...df_imputed.rds"]
     G["...date...df_imputed.rds"] --> H{"03_exploratory_statistics.Rmd"}
     F["data-list.rds"] --> H{"03_exploratory_statistics.Rmd"}

'
)

data_flow
