library(battleRealms)
library(data.table)
library(cdata)

units <- br_units[
  ,
  .(
    UnitID = Type,
    Name,
    Clan,
    UnitClass,
    RiceTrainCost,
    WaterTrainCost,
    YinYangTrainCost,
    MaxHealth,
    HealthRecoveryRate,
    MaxHealthRecovery,
    MaxFatigue,
    FatigueRecovery,
    MeleeWeapon,
    MissileWeapon,
    MissileWeaponLaunchHeight,
    PrefersMelee,
    AMBlunt,
    AMCutting,
    AMExplosive,
    AMFire,
    AMMagical,
    AMPiercing,
    MaxUnitsAttacking,
    DeathYinYangAwarded,
    StaminaWhenRunning,
    Bracing,
    ImmuneToCharge,
    InnateAbility,
    BattleGear1,
    BattleGear2,
    BattleGear3
  )
]

weapons <- br_weapons[
  ,
  .(
    Type,
    BaseDamage,
    MinRange,
    MaxRange,
    MaxMountedRange,
    WatchtowerMinRange,
    WatchtowerMaxRange,
    Class,
    DamageClass,
    RiderPercentage,
    OpportunityFire,
    AreaOfEffect,
    Poison,
    PoisonTime,
    IsFireWeapon,
    FirePointDamage,
    YinPerHit,
    YangPerHit
  )
]

units <- pivot_to_blocks(
  units,
  nameForNewKeyColumn = "WeaponType",
  nameForNewValueColumn = "WeaponID",
  columnsToTakeFrom = c("MeleeWeapon", "MissileWeapon")
)

setDT(units)

br_unit_stats <- units[
  weapons,
  on = c("WeaponID" = "Type"),
  nomatch = 0,
  allow.cartesian = TRUE
]

armour_cols <- grep("^AM", names(br_unit_stats), value = TRUE)

br_unit_stats <-
  pivot_to_blocks(
    br_unit_stats,
    columnsToTakeFrom = armour_cols,
    nameForNewKeyColumn = "ArmorAgainst",
    nameForNewValueColumn = "DamageMultiplier"
  )

setDT(br_unit_stats)

br_unit_stats[
  ,
  DamageClass := fcase(
    DamageClass == 0, "Blunt",
    DamageClass == 1, "Cutting",
    DamageClass == 2, "Explosive",
    DamageClass == 3, "Fire",
    DamageClass == 4, "Magical",
    DamageClass == 5, "Piercing"
  )
]

br_unit_stats[
  ,
  ArmorAgainst := gsub("^AM", "", ArmorAgainst)
]

br_unit_stats[
  ,
  Clan := fcase(
    Clan == 0, "Dragon",
    Clan == 1, "Hero",
    Clan == 2, "Lotus",
    Clan == 3, "Serpent",
    Clan == 5, "Wolf"
  )
]

br_unit_stats[
  ,
  Name := gsub(
    paste0(
      "^",
      c("Hero", "Dragon", "Lotus", "Serpent", "Wolf"),
      " ",
      collapse = "|"
    ),
    "",
    Name
  )
]

usethis::use_data(br_unit_stats, overwrite = TRUE)
