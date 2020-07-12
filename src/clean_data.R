# Clean 2018-2019 CDE suspension data


# Read data ---------------------------------------------------------------

source(here::here("src", "load_data.R"))


# Uniqueness --------------------------------------------------------------

raw_sus %>% distinct(
  CountyCode, DistrictCode, SchoolCode, 
  AggregateLevel, ReportingCategory, CharterYN
)


# Clean so each row is a unique district and school record 

school_sus <- raw_sus %>% 
  filter(AggregateLevel == "S", 
         CharterYN == "All") # All schools regardless of charter status

school_sus %>% 
  distinct(DistrictCode, SchoolCode, ReportingCategory)