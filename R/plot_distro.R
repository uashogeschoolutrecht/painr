#' Plotting a distribution of a numeric variable
#' @export

plot_distro <- function(x, title){
x |>
  enframe() |>
  ggplot(aes(x = value)) +
  geom_histogram() +
  ggtitle(title)

}
