## risk probability

## TERM 1
sex <- filtered_data |>
  dplyr::filter(time_days_relevel == 0) |>
  pluck("sex") |>
  as.numeric()

term_1_sex <- function(x){
  if (x == 1) return(0)
  if (x == 2) return(0.468)
}

term_1_sex_all <- map_dbl(
  sex,
  term_1_sex
)

## LaTeX translation
# setup Rmd
# TODO

function_1 <- mathml(call("<-", quote(term_1_sex(x)), term_1_sex))
paste("\n## Term Sex\n", function_1, "\n") |> write_lines(
  file = here::here("inst", "terms.Rmd"),
  append = TRUE
)

#########

## TERM 2
term_2_pain_intensity_all <- filtered_data |>
  dplyr::filter(time_days_relevel == 0) |>
  pluck("pain_intensity") |>
  as.numeric() * 0.227

## LaTeX translation
#function_2 <- mathml(term_pain_intensity)
#paste("\n## Term Pain Intensity\n", function_2, "\n") |>
#  write_lines(
#    file = here::here("inst", "terms.Rmd"),
#    append = TRUE,
#  )

###########

## TERM 3
pidbr <- filtered_data |>
  dplyr::filter(time_days_relevel == 0) |>
  pluck("wide_spread_pain") |>
  as.numeric()

term_3_pidbr <- function(x){
  if (x == 1) return(0)
  if (x == 2) return(0.734)
}

term_3_pidbr_all <- map_dbl(
  pidbr,
  term_3_pidbr
)

## mthml conversion
function_3 <- mathml(call("<-", quote(term_3_pidbr(x)), term_3_pidbr))
paste("\n## Term PIDBR\n", function_3, "\n") |> write_lines(
  file = here::here("inst", "terms.Rmd"),
  append = TRUE
)


#############

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

term_4_headache_all <- map_dbl(
  headache,
  term_4_headache
)

## MathML translation
function_4 <- mathml(call("<-", quote(term_4_headache(x)), term_4_headache))
paste("\n## Term Headache\n", function_4, "\n") |> write_lines(
  file = here::here("inst", "terms.Rmd"),
  append = TRUE
)

##################

## TERM 5
posture_work <- filtered_data |>
  dplyr::filter(time_days_relevel == 0) |>
  pluck("posture_work") |>
  as.numeric()

term_5_posture_work <- function(x){
  if (x == 1) return(1 * 0.384)
  if (x == 2) return(1 * -0.384)
  if (x == 3) return(1 * 1.311)
}

term_5_posture_work_all <- map_dbl(
  posture_work,
  term_5_posture_work
)

## MathML translation
function_5 <- mathml(call("<-", quote(term_5_posture_work(x)), term_5_posture_work))
paste("\n## Term Posture work\n", function_5, "\n") |> write_lines(
  file = here::here("inst", "terms.Rmd"),
  append = TRUE
)

#################

## TERM 6
work_status <- filtered_data |>
  dplyr::filter(time_days_relevel == 0) |>
  pluck("work") |>
  as.numeric()

term_6_work_status <- function(x){
  if (x == 1) return(0)
  if (x == 2) return(1.311)
}

term_6_work_status_all <- map_dbl(
  work_status,
  term_6_work_status
)

## MathML translation
function_6 <- mathml(call("<-", quote(term_6_work_status(x)), term_6_work_status))
paste("\n## Term work status\n", function_6, "\n") |> write_lines(
  file = here::here("inst", "terms.Rmd"),
  append = TRUE
)

#########################

## TERM 7
term_7_duration_beliefs_all <- filtered_data |>
  dplyr::filter(time_days_relevel == 0) |>
  pluck("duration_beliefs") |>
  as.numeric() * 0.184
##########################

## TERM 8
term_8_concerns_all <- filtered_data |>
  dplyr::filter(time_days_relevel == 0) |>
  pluck("concerns") |>
  as.numeric() * 0.108
#########################

## TERM 9
term_9_treatment_beliefs_all <- filtered_data |>
  dplyr::filter(time_days_relevel == 0) |>
  pluck("treatment_beliefs") |>
  as.numeric() * 0.204
##########################

## TERM 10
term_10_distress_all <- filtered_data |>
  dplyr::filter(time_days_relevel == 0) |>
  pluck("distress") |>
  as.numeric() * 0.083
############################

## TERM 11
term_11_identity_beliefs_all <- filtered_data |>
  dplyr::filter(time_days_relevel == 0) |>
  pluck("identity_beliefs") |>
  as.numeric() * -0.142
############################

## TERM 12
term_12_self_efficacy_all <- filtered_data |>
  dplyr::filter(time_days_relevel == 0) |>
  pluck("self_efficacy") |>
  as.numeric() * 0.109

lp <- -5.782 +
  term_1_sex_all +
  term_2_pain_intensity_all+
  term_3_pidbr_all +
  term_4_headache_all +
  term_5_posture_work_all +
  term_6_work_status_all +
  term_7_duration_beliefs_all +
  term_8_concerns_all +
  term_9_treatment_beliefs_all +
  term_10_distress_all +
  term_11_identity_beliefs_all +
  term_12_self_efficacy_all

# Omzetten van de Lineaire Voorspeller (LP) naar een percentage
probabilities = (1 / (1 + exp(-lp)))

# Omzetten van waarschijnlijkheid naar een percentage
percentages =  probabilities * 100

risk_tbl <- tibble(
  patient = input$patientInput,
  percentage = percentages

)

risk_tbl
