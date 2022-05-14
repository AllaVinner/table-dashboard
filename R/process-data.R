library(tidyverse)

df <- read_delim('./data/pokemon.csv', delim =',')

# Take away 'abilities_'
processed_df <- df %>% select(! starts_with('against_')) %>% select(! c(classfication,
                                                                              japanese_name,
                                                                              abilities))

write_csv(processed_df, './data/pokemon_processed.csv')
