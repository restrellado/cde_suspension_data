# Clean 2017-2018 CDE suspension data


# Load packages -----------------------------------------------------------

library(janitor)


# Read data ---------------------------------------------------------------

source(here::here("src", "2017_2018_load_data.R"))


# SUSPENSION DATA ---------------------------------------------------------

# Aggregate level ---------------------------------------------------------

# Clean so each row is a unique district and school record 
# Drops 197,670 rows
school_sus1718 <- raw_sus1718 %>% 
  filter(AggregateLevel == "S", 
         CharterYN == "All") # All schools regardless of charter status

school_sus1718 %>% 
  distinct(DistrictCode, SchoolCode, ReportingCategory)
  

# Change codes to names ---------------------------------------------------

school_sus1718 <- school_sus1718 %>% 
  mutate(ReportingCategory = case_when(
    ReportingCategory == "RB" ~ "African American", 
    ReportingCategory == "RI" ~ "American Indian or Alaska Native", 
    ReportingCategory == "RA" ~ "Asian", 
    ReportingCategory == "RF" ~ "Filipino", 
    ReportingCategory == "RH" ~ "Hispanic or Latino", 
    ReportingCategory == "RD" ~ "Not Reported", 
    ReportingCategory == "RP" ~ "Pacific Islander", 
    ReportingCategory == "RT" ~ "Two or More Races", 
    ReportingCategory == "RW" ~ "White", 
    ReportingCategory == "GM" ~ "Male", 
    ReportingCategory == "GF" ~ "Female", 
    ReportingCategory == "SE" ~ "English Learners", 
    ReportingCategory == "SD" ~ "Students With Disabilities", 
    ReportingCategory == "SS" ~ "Socioeconomically Disadvantaged", 
    ReportingCategory == "SM" ~ "Migrant", 
    ReportingCategory == "SF" ~ "Foster", 
    ReportingCategory == "SH" ~ "Homeless", 
    ReportingCategory == "TA" ~ "Total", 
    TRUE ~ "Other"
  ))


# Clean column names ------------------------------------------------------

school_sus1718 <- school_sus1718 %>% 
  clean_names()


# SCHOOL DATABASE ---------------------------------------------------------

# Remove one duplicate row
# Drops one record
raw_schools1617 <- raw_schools1617 %>% 
  filter(!duplicated(CDSCode))

# Clean var names
raw_schools1617 <- raw_schools1617 %>% 
  clean_names() 

raw_schools1617$school_code <- str_sub(raw_schools1617$cds_code, 8)
