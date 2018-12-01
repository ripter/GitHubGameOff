INCLUDE battle_mech_catapult.ink
INCLUDE battle_mech_axman.ink

== mech_base
  -> DONE

= start (who)
  ~ set_value (who, POWER, 0)
  ~ set_value (who, REGEN, 5)
  ~ set_value (who, HEAT, 0)
  ~ set_value (who, HEATSINKS, 3)
  ~ set_value (who, OVERHEAT, 10)
  ~ set_value (who, DODGE, 0)
  ~ set_value (who, IS_USING_EVASIVE_MANEUVERS, false)

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
  HEAT: {get_value(who, HEAT)}; <>
  REGEN: {get_value(who, REGEN)}; <>
  HEATSINKS: {get_value(who, HEATSINKS)};
  Dodge: {get_value(who, DODGE)}%; <>
  RANGE: {get_value(who, RANGE)};
  -> DONE
= status_short (who)
  {get_value(who, POWER)} Power, {get_value(who, HEAT)} Heat, {get_value(who, DODGE)}% Dodge.
  -> DONE

= turn_start (who)
  // Reset end of turn actions
  ~ set_value (who, DODGE, 0)
  ~ set_value (who, IS_USING_EVASIVE_MANEUVERS, false)
  // Setup state to start with a volley
  ~ set_value (who, TURN_STATE, VOLLEY)
  // Recharge
  <- recharge (who)
  -> DONE

= recharge (who)
  ~ temp prevPower = get_value (who, POWER)
  ~ temp prevHeat = get_value (who, HEAT)
  // Recharge
  ~ update_value (who, POWER, get_value (who, REGEN))
  ~ update_value (who, HEAT, -get_value (who, HEATSINKS))
  // Get the delta
  ~ temp deltaPower = get_value (who, POWER) - prevPower
  ~ temp deltaHeat = prevHeat - get_value (who, HEAT)

  {who} recharged {deltaPower} POWER
  {deltaHeat > 0:
    <> and dissipated {deltaHeat} HEAT.
  - else:
    <>.
  }
  <> Total: <- status_short (who)

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
  #title: Catapult (You)
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
  ~ temp range = get_value (attacker, RANGE)
  ~ temp damage = heat_damage(Laser, level)
  ~ temp bonus = 0

  {attacker} {~fires|blasts|shoots} a laser at {defender}

  // Pay for the action
  {not able_to_activate (attacker, Laser, level):
    <> but {attacker} did not have enough power.
    -> DONE
  }

  // let the defender attempt a dodge.
  {did_dodge (defender):
    <> but {defender} was too {~quick|fast|nimble} and dodged the attack.
    -> DONE
  }

  ~ deal_energy_damage (defender, damage)
  <> dealing {damage} HEAT to {defender}, for a total of {get_value (defender, HEAT)} HEAT.


  // Apply modifiers
  {
  - range == Melee:
    {coin_flip():
      ~ bonus = 1
      The close proximity of the {~laser|blast|energy beam} also heats {attacker} for {bonus} HEAT, for a total of {get_value (attacker, HEAT)} HEAT.
    }

    ~ bonus = 0
  }


  -> DONE



= fire_missile (attacker, defender)
  ~ temp level = 1
  ~ temp damage = heatsink_damage(Missile, level)
  ~ temp bonus = 0

  {attacker} launches a barrage of missiles.

  // Pay for the action
  {not able_to_activate (attacker, Missile, level):
    <> did not have enough power.
    -> DONE
  }

  <> The missiles attempted to lock on {defender}

  // Next, let the defender attempt a dodge.
  {did_dodge (defender):
    <> but was unable to get a lock. The Missiles land harmlessly around the battle field.
    -> DONE
  }

  <> and they rained down

  {get_value (defender, HEATSINKS) == 0:
    {coin_flip():
      bonus = 2
    - else:
      bonus = 4
    }
    <> caysing {damage} heat, with a {bonus} bonus because {defender} no longer has heatsinks.
  - else :
    <> destroying {damage} heatsinks.
  }

  // Attack hits
  ~ deal_physical_damage (defender, damage)
  -> DONE

= punch (attacker, defender)
  ~ temp level = 1
  ~ temp damage = heatsink_damage (Punch, level)

  {attacker} slices at {defender} with a hatchet

  // Pay for the action
  {not able_to_activate (attacker, Punch, level):
    <> did not have enough power.
    -> DONE
  }


  // Next, let the defender attempt a dodge.
  {did_dodge(defender):
    <> but {defender} {~barely|} manages to dodge the attack.
    -> DONE
  }

  <> destroying {damage} heatsinks.
  // Attack hits
  ~ deal_physical_damage (defender, damage)
  -> DONE



//
//
// Movement
//

= charge_forward (who)
  ~ temp level = 1
  {not able_to_activate (who, Move_Forward, level):
    {who} attempted to run, but did not have enough POWER.
    -> DONE
  }

  // apply effects
  ~ update_value (who, DODGE, level * 10)
  ~ update_value (who, RANGE, -level)

  {who} charges forward decreasing the distance between the mechs. {who} is now in {get_value (who, RANGE)} range.
  -> DONE

= charge_backwards (who)
  ~ temp level = 1
  {not able_to_activate (who, Move_Back, level):
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
  {not able_to_activate (who, Evasive_Maneuvers, level):
    {who} attempted to perform evasive maneuvers, but did not have enough POWER.
    -> DONE
  }

  // apply effects
  ~ update_value (who, DODGE, level * 25)
  ~ set_value (who, IS_USING_EVASIVE_MANEUVERS, true)

  {who} randomly zip zags around. Increasing Dodge to {get_value (who, DODGE)}%
  -> DONE
