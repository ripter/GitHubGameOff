INCLUDE battle_mech_catapult.ink
INCLUDE battle_mech_axman.ink

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
  RANGE: {get_value(who, RANGE)};
  -> DONE


= turn_start (who)
  // Recharge
  ~ update_value (who, POWER, get_value (who, REGEN))
  ~ update_value (who, HEAT, -get_value (who, HEATSINKS))

  // Setup state to start with a volley
  ~ set_value (who, TURN_STATE, VOLLEY)
  -> DONE


//
//
// Volley
//
= player_volley (who, target)
  // Apply custom per mech overrides
  {who == Catapult:
    -> mech_catapult.player_volley (target) ->
  - else:
    No player controls found for {who} 😢
  }
  ->->

= ai_simple (who, target)
  {who == Axman:
    -> mech_axman.ai_simple (target) ->
  - else:
    No ai_simple controls found for {who} 😢
  }
  ->->



//
//
// Weapons
//
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

= fire_missile (attacker, defender)
  ~ temp level = 1
  {not able_to_activate (attacker, Missile, level):
    {attacker} did not have enough power.
  }
  TODO: Add real missile fire here.
  -> DONE

= punch (attacker, defender)
  ~ temp level = 1
  {not can_afford (attacker, Punch, level):
    {attacker} attempted to slice {defender} with a hatchet, but the mech was out of power.
    <> ({attacker} has {get_value (attacker, POWER)} POWER, and needs {power_cost(Punch, level)} POWER)
    -> DONE
  }
  ~ update_value (attacker, POWER, -power_cost(Punch, level))

  // Next, let the defender attempt a dodge.
  {did_dodge(get_dodge(defender)):
    <> but {defender} was too {~quick|fast|nimble} and dodged the attack.
    -> DONE
  }

  // Deal damage from the attack.
  ~ temp dmg_heatsink = heatsink_damage (Punch, level)
  ~ temp dmg_heat = heat_damage(Punch, level)
  ~ update_value (defender, HEATSINKS, -dmg_heatsink)
  ~ update_value (defender, HEAT, dmg_heat)

  {attacker} sliced into {defender} destroying {dmg_heatsink} HEATSINKS and {dmg_heat} HEAT.
  -> DONE



//
//
// Movement
//

= charge_forward (who)
  ~ temp level = 1
  {not able_to_activate (who, CHARGE_FORWARD, level):
    {who} attempted to run, but did not have enough POWER.
    -> DONE
  }

  // apply effects
  ~ update_value (who, DODGE, level * 10)
  ~ update_value (who, RANGE, -level)

  {who} charges forward in a burst of speed. Increasing Dodge to {get_value (who, DODGE)}% and changing the range to {get_value (who, RANGE)}
  -> DONE

= charge_backwards (who)
  ~ temp level = 1
  {not able_to_activate (who, CHARGE_BACKWARD, level):
    {who} attempted to run, but did not have enough POWER.
    -> DONE
  }

  // apply effects
  ~ update_value (who, DODGE, level * 10)
  ~ update_value (who, RANGE, level)

  {who} retreats quickly. Increasing Dodge to {get_value (who, DODGE)}% and changing the range to {get_value (who, RANGE)}
  -> DONE

= evasive_maneuvers (who)
  ~ temp level = 1
  {not able_to_activate (who, EVASIVE_MANEUVERS, level):
    {who} attempted to perform evasive maneuvers, but did not have enough POWER.
    -> DONE
  }

  // apply effects
  ~ update_value (who, DODGE, level * 25)

  {who} randomly zip zags around. Increasing Dodge to {get_value (who, DODGE)}%
  -> DONE
