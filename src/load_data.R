
# Packages ----------------------------------------------------------------

library(tidyverse)


# Read suspension data ----------------------------------------------------

raw_sus <- read_tsv(here::here("data", "susp1819.txt"), 
                    # Need to specificy the column types
                    col_types = cols("c", "c", "c", "c", "c", "c", "c", "c", 
                                     "c", "c", "d", "d", "d", "d", "d", "d", 
                                     "d", "d", "d", "d", "d")) 


# Read district and school database ---------------------------------------

raw_schools <- read_tsv(here::here("data", "pubschls.txt"))