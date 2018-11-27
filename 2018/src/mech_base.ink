INCLUDE mech_catapult.ink
INCLUDE mech_axman.ink

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
  {
  - who == Catapult:
    <- mech_catapult.start
  - who == Axman:
    <- mech_axman.start
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
  // Recharge
  ~ update_value (who, POWER, get_value (who, REGEN))
  ~ update_value (who, HEAT, -get_value (who, HEATSINKS))

  // Setup state to start with a volley
  ~ set_turn_state (mech_attacker, VOLLEY)
  -> DONE

= player_volley (who)
  // Apply custom per mech overrides
  {who == Catapult:
    <- mech_catapult.player_volley
  }
  -> DONE

= ai_simple (who, target)
  {who == Axman:
    -> mech_axman.ai_simple (target) ->
  }
  ->->


= fire_laser (attacker, defender)
  ~ temp level = 1
  // First, make sure we can afford this shot.
  ~ temp power = get_power(attacker)
  {power_cost(Laser, level) > power:
    <> but could not {~muster|find|gather} the required power.
    -> DONE
  }
  // Then charge the attacker for the shot.
  ~ update_power(attacker, -power_cost(Laser, level))
  ~ update_heat(attacker, heat_cost(Laser, level))

  // Next, let the defender attempt a dodge.
  {did_dodge(get_dodge(defender)):
    <> but {defender} was too {~quick|fast|nimble} and dodged the attack.
    -> DONE
  }

  // Finally, deal damage to defender based on range
  ~ temp damage = heat_damage(Laser, level)
  {
  - get_range() == Long:
    <> The {~laser|blast|energy beam} degraded significantly over the long distance.
    ~ damage = damage / 4
  - get_range() == Medium:
    <> Over the medium distance, the {~laser|blast|energy beam}'s power degraded.
    ~ damage = damage / 2
  - else:
    <> The full power of the {~blast|discharge|beam|laser} hits {defender}.
  }

  {damage == 0:
    <> There was not enough power in the {~laser|blast|energy beam} to affect {defender}.
  - else:
  <> {damage} HEAT was dealt to {defender}.
  }
  ~ update_heat(defender, damage)
  -> DONE
