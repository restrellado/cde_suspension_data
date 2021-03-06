# Clean 2018-2019 CDE suspension data


# Load packages -----------------------------------------------------------

library(janitor)


# Read data ---------------------------------------------------------------

source(here::here("src", "2018_2019_load_data.R"))


# SUSPENSION DATA ---------------------------------------------------------

# Aggregate level ---------------------------------------------------------

# Clean so each row is a unique district and school record 
# Drops 197,670 rows
school_sus1819 <- raw_sus1718 %>% 
  filter(AggregateLevel == "S", 
         CharterYN == "All") # All schools regardless of charter status

school_sus1819 %>% 
  distinct(DistrictCode, SchoolCode, ReportingCategory)
  

# Change codes to names ---------------------------------------------------

school_sus1819 <- school_sus1819 %>% 
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

school_sus1819 <- school_sus1819 %>% 
  clean_names()


# SCHOOL DATABASE ---------------------------------------------------------

# Remove one duplicate row
# Drops one record
raw_schools1819 <- raw_schools1819 %>% 
  filter(!duplicated(CDSCode))

# Clean var names
raw_schools1819 <- raw_schools1819 %>% 
  clean_names() 

raw_schools1819$school_code <- str_sub(raw_schools1819$cds_code, 8)
