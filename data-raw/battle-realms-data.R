library(here)
library(data.table)

br_abilities_path <-
  here("data-raw", "BattleRealmsData", "Data_Abilities.txt")

br_abilities <- fread(
  br_abilities_path,
  # Remove first and last columns because these are empty
  drop = c(1, 181)
)

br_battle_gears_path <-
  here("data-raw", "BattleRealmsData", "Data_BattleGear.txt")

br_battle_gears <- fread(
  br_battle_gears_path,
  # Remove first and last columns because these are empty
  drop = c(1, 11)
)

br_buildings_path <-
  here("data-raw", "BattleRealmsData", "Data_Buildings.txt")

br_buildings <- fread(
  br_buildings_path,
  # Remove first and last columns because these are empty
  drop = c(1, 107)
)

br_team_colors_path <-
  here("data-raw", "BattleRealmsData", "Data_TeamColors.txt")

br_team_colors <- fread(
  br_team_colors_path,
  # Remove first and last columns because these are empty
  drop = c(1, 6:9)
)

br_team_colors[
  ,
  HexColor := rgb(R, G, B),
  TeamColor
]

br_team_colors[
  ,
  ColorName := fcase(
    TeamColor == 0, "Blue",
    TeamColor == 1, "Green",
    TeamColor == 2, "Orange",
    TeamColor == 3, "Purple",
    TeamColor == 4, "Red",
    TeamColor == 5, "Pink",
    TeamColor == 6, "Turquoise",
    TeamColor == 7, "Yellow"
  )
]

br_techniques_path <-
  here("data-raw", "BattleRealmsData", "Data_Techniques.txt")

br_techniques <- fread(
  br_techniques_path,
  # Remove first and last columns because these are empty
  drop = c(1, 27)
)

br_units_path <-
  here("data-raw", "BattleRealmsData", "Data_Units.txt")

br_units <- fread(
  br_units_path,
  # Remove first and last columns because these are empty
  drop = c(1, 106)
)

br_upgrades_path <-
  here("data-raw", "BattleRealmsData", "Data_Upgrades.txt")

br_upgrades <- fread(
  br_upgrades_path,
  # Remove first and last columns because these are empty
  drop = c(1, 17)
)

br_weapons_path <-
  here("data-raw", "BattleRealmsData", "Data_Weapons.txt")

br_weapons <- fread(
  br_weapons_path,
  # Remove first and last columns because these are empty
  drop = c(1, 34)
)

usethis::use_data(
  br_abilities,
  br_battle_gears,
  br_buildings,
  br_team_colors,
  br_techniques,
  br_units,
  br_weapons,
  overwrite = TRUE
)
