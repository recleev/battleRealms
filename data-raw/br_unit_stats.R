library(battleRealms)
library(data.table)
library(cdata)

units <- br_units[
  ,
  .(
    UnitID = Type,
    Name,
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

usethis::use_data(br_unit_stats, overwrite = TRUE)
