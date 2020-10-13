library(here)
library(data.table)

br_units_path <- here("data-raw", "BattleRealmsData", "Data_Units.txt")

br_units <- fread(
  br_units_path,
  # Remove first and last columns because these are empty
  drop = c(1, 106)
)

br_weapons_path <- here("data-raw", "BattleRealmsData", "Data_Weapons.txt")

br_weapons <- fread(
  br_weapons_path,
  # Remove first and last columns because these are empty
  drop = c(1, 34)
)


usethis::use_data(br_units, br_weapons, overwrite = TRUE)
