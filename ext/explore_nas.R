library(janitor)
library(here)
library(naniar)

# First, run code in model.Rmd to load datasets into the environment

gg_miss_case(total_sus)

gg_miss_var(total_sus)

gg_miss_var(total_sus, facet = reporting_category)

gg_miss_var(total_sus, facet = charter_yn)

total_sus %>% 
  filter(is.na(cumulative_enrollment)) %>% 
  View()

total_sus %>% 
  filter(is.na(cumulative_enrollment)) %>% 
  count(school_code)

# Verify that the 265 rows with missing data in the total_sus were missing in
# raw_sus

# Read everything as char so it keeps the *
raw_sus_2 <- read_tsv(here::here("data", "susp1819.txt"), 
                      col_types = cols(.default = "c")) %>% 
  clean_names()
  

# Clean the dataset
raw_sus_2 %>% 
  filter(reporting_category == "TA", 
         aggregate_level == "S", 
         charter_yn == "All") %>% # Total counts across all subgroups
  select(aggregate_level, cumulative_enrollment) %>% 
  summarise(ast = sum(cumulative_enrollment == "*"))
