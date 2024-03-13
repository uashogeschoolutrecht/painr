library(shiny)
library(ggplot2)
library(dplyr)
library(here)
library(tibble)
library(purrr)
library(tidyr)
library(readr)
#library(mathml)

# Assuming df_imp_long is already loaded in your environment
# If not, you'd need to load or define it here
df_imp_long <- readr::read_rds(
  file = "df_imp_long.rds"
  )


patient_codes <- df_imp_long$patient_code |> unique()


# UI definition
ui <- fluidPage(
  titlePanel("ShinyPainR; An interactive viz tool for patients with neck pain"),
  sidebarLayout(
    sidebarPanel(
      selectInput("patientInput",
                  "Select patient(s) (max 8):",
                  choices = as.character(patient_codes), # Assuming patient codes are numeric
                  selected = c(110, 112, 156),
                  multiple = TRUE)
    ),
    mainPanel(
      plotOutput("painPlot"),
      plotOutput("featurePlot"),
      tableOutput("risk"),
      tableOutput("patientFeatures")

    )
  )
)

# Server logic
server <- function(input, output) {

  filtered_data = df_imp_long %>%
  filter(patient_code %in% patient_codes)

    output$risk <- renderTable({

     filtered_data <- df_imp_long %>%
       filter(patient_code %in% as.numeric(c(input$patientInput)))

     patient_codes <- input$patientInput

     ## TERM 1
     sex <- filtered_data |>
       dplyr::filter(time_days_relevel == 0) |>
       pluck("sex") |>
       as.numeric()

     term_1_sex <- function(x){
       if (x == 1) return(0)
       if (x == 2) return(0.468)
     }

     term_1_sex_tbl <- map_dbl(
       sex,
       term_1_sex
     ) |>
       enframe() |>
       mutate(
         patient_code = patient_codes,
         name = "sex"
       )

     ## TERM 2
     term_2_pain_intensity_tbl <- filtered_data |>
       dplyr::filter(time_days_relevel == 0) |>
       pluck("painint_score") |>
       enframe() |>
       mutate(
         value = 0.227 * value,
         patient_code = patient_codes,
         name = "painint_score"
         )


     ## TERM 3
     pidbr <- filtered_data |>
       dplyr::filter(time_days_relevel == 0) |>
       pluck("wide_spread_pain") |>
       as.numeric()

     term_3_pidbr <- function(x){
       if (x == 1) return(0)
       if (x == 2) return(0.734)
     }

     term_3_pidbr_tbl <- map_dbl(
       pidbr,
       term_3_pidbr
     ) |>
       enframe() |>
       mutate(
         patient_code = patient_codes,
         name = "pidbr"
       )

     ## TERM 4
     headache <- filtered_data |>
       dplyr::filter(time_days_relevel == 0) |>
       pluck("headache") |>
       as.numeric()

     term_4_headache <- function(x){
       if (x == 1) return(0)
       if (x == 2) return(0.726)
       if (x == 3) return(-0.07)
     }

     term_4_headache_tbl <- map_dbl(
       headache,
       term_4_headache
     ) |>
       enframe() |>
       mutate(
         patient_code = patient_codes,
         name = "headache"
       )

     ## TERM 5
     posture_work <- filtered_data |>
       dplyr::filter(time_days_relevel == 0) |>
       pluck("posture_work") |>
       as.numeric()

     term_5_posture_work <- function(x){
       if (x == 1) return(0)
       if (x == 2) return(0.384)
       if (x == 3) return(1.311)
     }

     term_5_posture_work_tbl <- map_dbl(
       posture_work,
       term_5_posture_work
     ) |>
       enframe() |>
       mutate(
         patient_code = patient_codes,
         name = "posture_work"
       )

     ## TERM 6
     term_6_duration_beliefs_tbl <- filtered_data |>
       dplyr::filter(time_days_relevel == 0) |>
       pluck("duration_beliefs") |>
       enframe() |>
       mutate(
         value = 0.184 * value,
         patient_code = patient_codes,
         name = "duration_beliefs"
       )

     ## TERM 7
     term_7_concerns_tbl <- filtered_data |>
       dplyr::filter(time_days_relevel == 0) |>
       pluck("concerns") |>
       enframe() |>
       mutate(
         value = 0.108 * value,
         patient_code = patient_codes,
         name = "concerns"
       )

     ## TERM 8
     term_8_treatment_beliefs_tbl <- filtered_data |>
       dplyr::filter(time_days_relevel == 0) |>
       pluck("treatment_beliefs") |>
       enframe() |>
       mutate(
         value = -0.204 * value,
         patient_code = patient_codes,
         name = "treatment_beliefs"
       )

     ## TERM 9
     term_9_distress_tbl <- filtered_data |>
       dplyr::filter(time_days_relevel == 0) |>
       pluck("distress") |>
       enframe() |>
       mutate(
         value = 0.083 * value,
         patient_code = patient_codes,
         name = "distress"
       )

     ## TERM 10
     term_10_identity_beliefs_tbl <- filtered_data |>
       dplyr::filter(time_days_relevel == 0) |>
       pluck("identity_beliefs") |>
       enframe() |>
       mutate(
         value = -0.142 * value,
         patient_code = patient_codes,
         name = "identity_beliefs"
       )

     ## TERM 11
     term_11_self_efficacy_tbl <- filtered_data |>
       dplyr::filter(time_days_relevel == 0) |>
       pluck("self_efficacy") |>
       enframe() |>
       mutate(
         value = 0.109 * value,
         patient_code = patient_codes,
         name = "self_efficacy"
       )

     ## bring together
     lp_tbl <- dplyr::bind_rows(
       term_1_sex_tbl,
       term_2_pain_intensity_tbl,
       term_3_pidbr_tbl,
       term_4_headache_tbl,
       term_5_posture_work_tbl,
       term_6_duration_beliefs_tbl,
       term_7_concerns_tbl,
       term_8_treatment_beliefs_tbl,
       term_9_distress_tbl,
       term_10_identity_beliefs_tbl,
       term_11_self_efficacy_tbl
     )

     lp_tbl_nested <- lp_tbl |>
       group_by(patient_code) |>
       nest()

     ## lp function
     calculate_lp <- function(df){

       x <- sum(df$value)
       lp <- -5.782 + x
       return(lp)
     }

     get_prob <- function(x){

       prob_healthy = (1 / (1 + exp(x)))
       prob_chronic = 1 - prob_healthy
       return(prob_chronic)
     }

     ## apply function
     lp_tbl_nested <- lp_tbl_nested |>
       mutate(
         lp = map_dbl(
           data,
           calculate_lp
         ),
         prob = map_dbl(
           lp,
           get_prob
         ),
         perc = (100 * prob) ##### TODO: Check if this is correct!
       )
    lp_tbl_nested |>
      dplyr::select(
        patient_code,
        lp,
        prob,
        perc
      )

  })

  output$featurePlot <- renderPlot({

    filtered_data <- df_imp_long %>%
      filter(patient_code %in% as.numeric(c(input$patientInput)))

    patient_codes <- input$patientInput


    ## TERM 1
    sex <- filtered_data |>
      dplyr::filter(time_days_relevel == 0) |>
      pluck("sex") |>
      as.numeric()

    term_1_sex <- function(x){
      if (x == 1) return(0)
      if (x == 2) return(0.468)
    }

    term_1_sex_tbl <- map_dbl(
      sex,
      term_1_sex
    ) |>
      enframe() |>
      mutate(
        patient_code = patient_codes,
        name = "sex"
      )

    ## TERM 2
    term_2_pain_intensity_tbl <- filtered_data |>
      dplyr::filter(time_days_relevel == 0) |>
      pluck("painint_score") |>
      enframe() |>
      mutate(
        value = 0.227 * value,
        patient_code = patient_codes,
        name = "painint_score"
      )


    ## TERM 3
    pidbr <- filtered_data |>
      dplyr::filter(time_days_relevel == 0) |>
      pluck("wide_spread_pain") |>
      as.numeric()

    term_3_pidbr <- function(x){
      if (x == 1) return(0)
      if (x == 2) return(0.734)
    }

    term_3_pidbr_tbl <- map_dbl(
      pidbr,
      term_3_pidbr
    ) |>
      enframe() |>
      mutate(
        patient_code = patient_codes,
        name = "pidbr"
      )

    ## TERM 4
    headache <- filtered_data |>
      dplyr::filter(time_days_relevel == 0) |>
      pluck("headache") |>
      as.numeric()

    term_4_headache <- function(x){
      if (x == 1) return(0)
      if (x == 2) return(0.726)
      if (x == 3) return(-0.07)
    }

    term_4_headache_tbl <- map_dbl(
      headache,
      term_4_headache
    ) |>
      enframe() |>
      mutate(
        patient_code = patient_codes,
        name = "headache"
      )


    ## TERM 5
    posture_work <- filtered_data |>
      dplyr::filter(time_days_relevel == 0) |>
      pluck("posture_work") |>
      as.numeric()

    term_5_posture_work <- function(x){
      if (x == 1) return(0)
      if (x == 2) return(1 * 0.384)
      if (x == 3) return(1 * 1.311)
    }

    term_5_posture_work_tbl <- map_dbl(
      posture_work,
      term_5_posture_work
    ) |>
      enframe() |>
      mutate(
        patient_code = patient_codes,
        name = "posture_work"
      )


    ## TERM 6
    term_6_duration_beliefs_tbl <- filtered_data |>
      dplyr::filter(time_days_relevel == 0) |>
      pluck("duration_beliefs") |>
      enframe() |>
      mutate(
        value = 0.184 * value,
        patient_code = patient_codes,
        name = "duration_beliefs"
      )

    ## TERM 7
    term_7_concerns_tbl <- filtered_data |>
      dplyr::filter(time_days_relevel == 0) |>
      pluck("concerns") |>
      enframe() |>
      mutate(
        value = 0.108 * value,
        patient_code = patient_codes,
        name = "concerns"
      )

    ## TERM 8
    term_8_treatment_beliefs_tbl <- filtered_data |>
      dplyr::filter(time_days_relevel == 0) |>
      pluck("treatment_beliefs") |>
      enframe() |>
      mutate(
        value = -0.204 * value,
        patient_code = patient_codes,
        name = "treatment_beliefs"
      )

    ## TERM 9
    term_9_distress_tbl <- filtered_data |>
      dplyr::filter(time_days_relevel == 0) |>
      pluck("distress") |>
      enframe() |>
      mutate(
        value = 0.083 * value,
        patient_code = patient_codes,
        name = "distress"
      )

    ## TERM 10
    term_10_identity_beliefs_tbl <- filtered_data |>
      dplyr::filter(time_days_relevel == 0) |>
      pluck("identity_beliefs") |>
      enframe() |>
      mutate(
        value = -0.142 * value,
        patient_code = patient_codes,
        name = "identity_beliefs"
      )

    ## TERM 11
    term_11_self_efficacy_tbl <- filtered_data |>
      dplyr::filter(time_days_relevel == 0) |>
      pluck("self_efficacy") |>
      enframe() |>
      mutate(
        value = 0.109 * value,
        patient_code = patient_codes,
        name = "self_efficacy"
      )

    ## bring together
    lp_tbl <- dplyr::bind_rows(
      term_1_sex_tbl,
      term_2_pain_intensity_tbl,
      term_3_pidbr_tbl,
      term_4_headache_tbl,
      term_5_posture_work_tbl,
      term_6_duration_beliefs_tbl,
      term_7_concerns_tbl,
      term_8_treatment_beliefs_tbl,
      term_9_distress_tbl,
      term_10_identity_beliefs_tbl,
      term_11_self_efficacy_tbl
    )


  #  lp_tbl |>
  #    pivot_wider(names_from = name, values_from = value) |>
  #    mutate(patient_code = as.integer(patient_code))

    lp_tbl |>
      ggplot(
        aes(x = name, y = value)) +
      geom_col(aes(fill = value)) +
      facet_wrap(~patient_code) +
      coord_flip() +
      theme_minimal() -> featurePlot


    featurePlot



  })


  output$patientFeatures <- renderTable({

    filtered_data <- df_imp_long %>%
      filter(patient_code %in% as.numeric(c(input$patientInput)))

    patient_codes <- input$patientInput


    ## TERM 1
    sex <- filtered_data |>
      dplyr::filter(time_days_relevel == 0) |>
      pluck("sex") |>
      as.numeric()

    term_1_sex <- function(x){
      if (x == 1) return(0)
      if (x == 2) return(0.468)
    }

    term_1_sex_tbl <- map_dbl(
      sex,
      term_1_sex
    ) |>
      enframe() |>
      mutate(
        patient_code = patient_codes,
        name = "sex"
      )

    ## TERM 2
    term_2_pain_intensity_tbl <- filtered_data |>
      dplyr::filter(time_days_relevel == 0) |>
      pluck("painint_score") |>
      enframe() |>
      mutate(
        value = 0.227 * value,
        patient_code = patient_codes,
        name = "painint_score"
      )


    ## TERM 3
    pidbr <- filtered_data |>
      dplyr::filter(time_days_relevel == 0) |>
      pluck("wide_spread_pain") |>
      as.numeric()

    term_3_pidbr <- function(x){
      if (x == 1) return(0)
      if (x == 2) return(0.734)
    }

    term_3_pidbr_tbl <- map_dbl(
      pidbr,
      term_3_pidbr
    ) |>
      enframe() |>
      mutate(
        patient_code = patient_codes,
        name = "pidbr"
      )

    ## TERM 4
    headache <- filtered_data |>
      dplyr::filter(time_days_relevel == 0) |>
      pluck("headache") |>
      as.numeric()

    term_4_headache <- function(x){
      if (x == 1) return(0)
      if (x == 2) return(0.726)
      if (x == 3) return(-0.07)
    }

    term_4_headache_tbl <- map_dbl(
      headache,
      term_4_headache
    ) |>
      enframe() |>
      mutate(
        patient_code = patient_codes,
        name = "headache"
      )


    ## TERM 5
    posture_work <- filtered_data |>
      dplyr::filter(time_days_relevel == 0) |>
      pluck("posture_work") |>
      as.numeric()

    term_5_posture_work <- function(x){
      if (x == 1) return(0)
      if (x == 2) return(1 * 0.384)
      if (x == 3) return(1 * 1.311)
    }

    term_5_posture_work_tbl <- map_dbl(
      posture_work,
      term_5_posture_work
    ) |>
      enframe() |>
      mutate(
        patient_code = patient_codes,
        name = "posture_work"
      )


    ## TERM 6
    term_6_duration_beliefs_tbl <- filtered_data |>
      dplyr::filter(time_days_relevel == 0) |>
      pluck("duration_beliefs") |>
      enframe() |>
      mutate(
        value = 0.184 * value,
        patient_code = patient_codes,
        name = "duration_beliefs"
      )

    ## TERM 7
    term_7_concerns_tbl <- filtered_data |>
      dplyr::filter(time_days_relevel == 0) |>
      pluck("concerns") |>
      enframe() |>
      mutate(
        value = 0.108 * value,
        patient_code = patient_codes,
        name = "concerns"
      )

    ## TERM 8
    term_8_treatment_beliefs_tbl <- filtered_data |>
      dplyr::filter(time_days_relevel == 0) |>
      pluck("treatment_beliefs") |>
      enframe() |>
      mutate(
        value = -0.204 * value,
        patient_code = patient_codes,
        name = "treatment_beliefs"
      )

    ## TERM 9
    term_9_distress_tbl <- filtered_data |>
      dplyr::filter(time_days_relevel == 0) |>
      pluck("distress") |>
      enframe() |>
      mutate(
        value = 0.083 * value,
        patient_code = patient_codes,
        name = "distress"
      )

    ## TERM 10
    term_10_identity_beliefs_tbl <- filtered_data |>
      dplyr::filter(time_days_relevel == 0) |>
      pluck("identity_beliefs") |>
      enframe() |>
      mutate(
        value = -0.142 * value,
        patient_code = patient_codes,
        name = "identity_beliefs"
      )

    ## TERM 11
    term_11_self_efficacy_tbl <- filtered_data |>
      dplyr::filter(time_days_relevel == 0) |>
      pluck("self_efficacy") |>
      enframe() |>
      mutate(
        value = 0.109 * value,
        patient_code = patient_codes,
        name = "self_efficacy"
      )

    ## bring together
    lp_tbl <- dplyr::bind_rows(
      term_1_sex_tbl,
      term_2_pain_intensity_tbl,
      term_3_pidbr_tbl,
      term_4_headache_tbl,
      term_5_posture_work_tbl,
      term_6_duration_beliefs_tbl,
      term_7_concerns_tbl,
      term_8_treatment_beliefs_tbl,
      term_9_distress_tbl,
      term_10_identity_beliefs_tbl,
      term_11_self_efficacy_tbl
    )


    lp_tbl |>
      pivot_wider(names_from = name, values_from = value) |>
      mutate(patient_code = as.integer(patient_code))
  })



  summary_data <- df_imp_long |>
    dplyr::select(
      patient_code,
      is_painint_chronic,
      time_days_relevel,
      painint_score) |>
    group_by(is_painint_chronic, time_days_relevel) |>
    summarise(mean_pain = mean(painint_score))

  output$painPlot <- renderPlot({
    filtered_data <- df_imp_long %>%
      filter(patient_code %in% as.numeric(input$patientInput)) # Ensure correct patient is selected


  #  if(filtered_data$is_painint_chronic |> unique() == "FALSE"){
  #    clr = "darkgreen"
  #  }

  #  if(filtered_data$is_painint_chronic |> unique() == "TRUE"){
  #    clr = "darkred"
  #  }

    ggplot(filtered_data, aes(x = time_days_relevel, y = painint_score)) +
      geom_point(aes(colour = is_painint_chronic),
                 show.legend = FALSE,
                 size = 3) +
      geom_line(aes(x = time_days_relevel,
                    y = painint_score,
                    group = is_painint_chronic,
                    colour = is_painint_chronic), # Group by is_painint_chronic to draw separate lines
                   # Map colour to is_painint_chronic for different line colors
                size = 1, show.legend = FALSE) + # Adjusted line thickness for clarity
      scale_colour_manual(values = c("TRUE" = "darkred", "FALSE" = "blue")) + # Manually set colors
      xlab("Time (days)") +
      ylab("Pain intensity score") +
      ylim(-1, 10) +
      theme_minimal() + # Assuming citrulliner::theme_individual() is replaced for simplicity
      labs(colour = "Average pain score (dashed lines)\nIs pain chronic FALSE/TRUE") + # Label the legend
      geom_line(data = summary_data, # add average trends
                aes(
                  x = time_days_relevel,
                  y = mean_pain,
                  group = is_painint_chronic,
                  colour = is_painint_chronic),
                show.legend = TRUE,
                linetype = "dashed",
                linewidth = 1) +
      ggtitle("Patient data (solid line)") +
      facet_wrap(~patient_code) +
     theme_minimal()
  })

  # output$featurePlot <- renderPlot({
  #
  #   filtered_data <- df_imp_long %>%
  #     filter(patient_code %in% as.numeric(input$patientInput))
  #
  #   filtered_data$bmi <- round(filtered_data$bmi, 1)
  #
  #   filtered_data <- map_df(
  #     filtered_data, as.character
  #   )
  #
  #   filtered_data |>
  #     as_tibble() |>
  #     dplyr::select(
  #       -c(
  #         is_chronic_missing,
  #         time_days,
  #         time_days_relevel,
  #         painint_high,
  #         painint_6weeks_high,
  #         painint_3months_high,
  #         painint_6months_high,
  #         painint_score,
  #         painint_total_score,
  #         time
  #       )
  #       ) |>
  #         pivot_longer(sex:attitude,
  #                      names_to = "feature",
  #                      values_to = "value") |>
  #     ggplot(
  #       aes(
  #         x = feature,
  #         y = value)
  #     ) + geom_tile(
  #       aes(fill = is_painint_chronic)
  #     ) +
  #     coord_flip() +
  #     theme_minimal() +
  #     facet_wrap(~patient_code) +
  #     ggtitle("Patient data questionnaire")
  #
  # })
}

# Run the app
shinyApp(ui = ui, server = server)
