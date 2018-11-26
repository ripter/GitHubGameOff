INCLUDE mech_catapult.ink

== mech_base
  -> DONE

= start (who)
  Booting up Mech {who}
  ~ set_value (who, POWER, 0)
  ~ set_value (who, REGEN, 5)
  ~ set_value (who, HEAT, 0)
  ~ set_value (who, HEATSINKS, 5)
  ~ set_value (who, OVERHEAT, 10)
  ~ set_value (who, SPEED, 0)
  ~ set_value (who, DODGE, 0)
  ~ set_value (who, EVASIVE_MANEUVERS, false)

  // Apply custom per mech overrides
  {who == Catapult:
    <- mech_catapult.start
  }
  -> DONE

= status (who)
  POWER: {get_value(who, POWER)}; <>
  REGEN: {get_value(who, REGEN)}; <>
  HEAT: {get_value(who, HEAT)}; <>
  HEATSINKS: {get_value(who, HEATSINKS)}; <>
  SPEED: {get_value(who, SPEED)}; <>
  EVASIVE_MANEUVERS: {get_value(who, EVASIVE_MANEUVERS)}; <>
  DODGE: {get_value(who, DODGE)}; <>
  RANGE: {get_value(who, RANGE)}; <>
  STATE: {get_value(who, TURN_STATE)};
  -> DONE

= turn_start (who)
  -> DONE
