### Plot when ifplot = TRUE
### Factor, make a data frame and plot
# if (ifplot){
#   quality_plot <- quality %>% factor(., levels = seq(0, 5, 0.5)) %>% data.frame(Quality = .) %>%
#     ggplot(aes(x = Quality)) +
#     geom_bar() +
#     scale_x_discrete(drop=FALSE)
#   print(quality_plot)
#
#   difficulty_plot <- difficulty %>% factor(., levels = seq(0, 5, 0.5)) %>% data.frame(Difficulty = .) %>%
#     ggplot(aes(x = Difficulty)) +
#     geom_bar() +
#     scale_x_discrete(drop=FALSE)
#   print(difficulty_plot)
# }
