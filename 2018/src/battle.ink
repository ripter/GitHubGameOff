INCLUDE weapons.ink
INCLUDE function_weapons.ink
INCLUDE function_utils.ink
INCLUDE function_attributes.ink
INCLUDE function_core.ink



LIST MECHS = IronWolf, Axman
VAR battle_state = PLAYING
VAR mech_attacker = IronWolf
VAR mech_defender = Axman
VAR mech_overheat = 20

// Setup the mechs for battle
<- ironwolf.start
<- axman.start


VAR turn_count = 0
- (main_loop)
{battle_state == PLAYING:
  ~ turn_count += 1
  Loop Numner {turn_count}

  -> arena.turn_start ->

  -> arena.turn_volley ->

  {turn_count >= 5:
    ~ battle_state = GAMEOVER
  }

  // Check if we should loop again.
  {battle_state == PLAYING:
    -> main_loop
  }
}

-
Post Battle stuff goes here.





== arena
= turn_start
  // Recharge
  ~ mech_recharge (mech_attacker)
  ~ mech_recharge (mech_defender)
  // Reset turn mode
  // Turn State tells us if the players still want to perform actions or if they are done and ready for the next turn.
  ~ set_turn_state (mech_attacker, VOLLEY)
  ~ set_turn_state (mech_defender, VOLLEY)
  ->->
= turn_volley
  ~ temp stateAttacker = get_turn_state (mech_attacker)
  ~ temp stateDefender = get_turn_state (mech_defender)

  {get_fastest() == mech_attacker:

    {get_value (mech_attacker, TURN_STATE) == VOLLEY:
      -> ironwolf.pick_action ->
    }
    {get_value (mech_defender, TURN_STATE) == VOLLEY:
      -> axman.random_action ->
    }

  - else:
    {get_value (mech_defender, TURN_STATE) == VOLLEY:
      -> axman.random_action ->
    }
    {get_value (mech_attacker, TURN_STATE) == VOLLEY:
      -> ironwolf.pick_action ->
    }
  }

  // Check if the game ended, which should abort the rest of the volleys
  {is_gameover():
    ~ battle_state = GAMEOVER
    ->->
  }

  {get_turn_state (mech_defender) == PASS and get_turn_state (mech_attacker) == PASS:
    Both sides have passed or run out of energy.
    ->->
  }
  -> turn_volley


== ironwolf
= start
  ~ mech_attacker = IronWolf
  ~ set_heat(IronWolf, 0)
  ~ set_power(IronWolf, 0)
  ~ set_heatsinks(IronWolf, 0)
  ~ set_power_regen(IronWolf, 5)
  ~ set_dodge(IronWolf, 10)
  ~ set_speed(IronWolf, 0)
  -> DONE
= status
  {IronWolf} {get_power(IronWolf)} POWER
  <>; {get_heat(IronWolf)} HEAT
  <>; {get_heatsinks(IronWolf)} HEATSINKS
  <>; {get_speed(IronWolf)} Kilometer per POWER
  -> DONE

= pick_action
  ~ temp currentPower = get_power(IronWolf)
  <- status

  + {currentPower >= 4} [Fire Laser - {power_cost(Laser, 1)} POWER; {heat_cost(Laser, 1)} HEAT; 3-4 Damage]
    <- laser.fire(IronWolf, mech_defender)
  + [Wait]
    ~ set_turn_state (IronWolf, PASS)
  -
  ->->

= upkeep
  ~ temp speed = get_speed(IronWolf)
  { speed <= 0:
    ->->
  }

  Continue current speed of {speed}kpp?
  + [Yes, Keep up speed]
    ~ mech_upkeep_speed(IronWolf, 1)
  + [No, cut speed]
    ~ mech_clear_speed(IronWolf)
  -
  ->->




== axman
= start
  ~ mech_defender = Axman
  ~ set_heat(Axman, 0)
  ~ set_power(Axman, 0)
  ~ set_heatsinks(Axman, 0)
  ~ set_power_regen(Axman, 5)
  ~ set_dodge(Axman, 10)
  ~ set_speed(Axman, 0)
  -> DONE
= status
  {Axman} {get_power(Axman)} POWER
  <>; {get_heat(Axman)} HEAT
  <>; {get_heatsinks(Axman)} HEATSINKS
  <>; {get_speed(Axman)} Kilometer per POWER
  -> DONE
= fire_laser
  <- laser.fire(Axman, IronWolf)
  ->->
= random_action
  <- status
  <- laser.fire(Axman, IronWolf)
  ~ set_turn_state(Axman, PASS)
  ->->


== function is_gameover()
  ~ return get_heat(mech_defender) >= mech_overheat or get_heat(mech_attacker) >= mech_overheat

== function get_fastest()
  {
  - get_power(mech_defender) <= 0:
    ~ return mech_attacker
  - get_power(mech_attacker) <= 0:
    ~ return mech_defender
//   - get_speed(mech_attacker) <= 0:
//     ~ return mech_attacker
//   - get_speed(mech_defender) <= 0:
//     ~ return mech_defender
  - else:
    ~ temp toss = "{~head|tail}"
    // Random Toss {toss}
    {toss == "head":
      ~ return mech_attacker
    }
    ~ return mech_defender
  }

== function mech_recharge(who)
  ~ update_power(who, get_power_regen(who))
  ~ update_heat(who, -get_heatsinks(who))

== function mech_change_speed(who, delta, level)
  ~ update_speed(who, delta)
  // range counts down to move forward, so flip the sign on delta
  ~ update_range(-1 * delta)
  // use a positive delta for cost calculations.
  {delta < 0:
    ~ delta = -1 * delta
  }
  ~ update_power(who, -delta * power_cost(Move, level))
== function mech_upkeep_speed(who, level)
  ~ temp delta = get_speed(who)
  ~ update_power(who, -delta * power_cost(Move, level))
== function mech_clear_speed(who)
  ~ set_speed(who, 0)
