library(tidyverse)

tuesdata <- tidytuesdayR::tt_load('2022-01-25')

ratings <- tuesdata$ratings
details <- tuesdata$details

new_games <- ratings %>% 
  left_join(details, by = c("id", "name" = "primary")) %>% 
  select(-starts_with("num.")) %>% 
  filter(year > 2019)

ggplot(new_games,
         aes(x = playingtime, y = average)) +
  geom_hex() +
  geom_text(data = new_games %>% filter(playingtime >= 10000 | (average < 3 & playingtime > 10)),
            aes(x = playingtime, y = average + 0.35, 
                label = str_wrap(str_replace(name, pattern = ":.*", replacement = ""), width = 15))) +
  scale_x_log10() +
  labs(x = "log(playingtime)") 
