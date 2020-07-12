
# Packages ----------------------------------------------------------------

library(tidyverse)


# Read data ---------------------------------------------------------------

raw_sus <- read_tsv(here::here("data", "susp1819.txt"), 
                    # Need to specificy the column types
                    col_types = cols("c", "c", "c", "c", "c", "c", "c", "c", 
                                     "c", "c", "d", "d", "d", "d", "d", "d", 
                                     "d", "d", "d", "d", "d")) 
