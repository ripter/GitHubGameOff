INCLUDE battle_core.ink
INCLUDE battle_tables.ink
INCLUDE battle_utils.ink
INCLUDE battle_mech_base.ink

-> gameoff_battle_draft_two

== gameoff_battle_draft_two
VAR battle_state = PLAYING
VAR mech_attacker = Catapult
VAR mech_defender = Axman

// Setup the mechs for battle
<- mech_base.start(mech_attacker)
<- mech_base.start(mech_defender)
// Setup the arena for battle
~ set_value (mech_attacker, RANGE, Long)


VAR turn_count = 0
- (main_loop)
{battle_state == PLAYING:
  ~ turn_count += 1

  // Start the turn
  // Recharge, Upkeep, Dissipate Heat, etc
  <- arena.turn_start(turn_count)

  // Each Mech takes turns Moving/Firing until they both run out of POWER or PASS
  // This is the "real time" combat, they alternate performing actions to simulate if they were both performing those actions in real time.
  -> arena.turn_volley ->

  {turn_count >= 30:
    The battle is a Tie! No one was able to win within 30 turns.
    ~ battle_state = GAMEOVER
  }

  // Check if we should loop again.
  {battle_state == PLAYING:
    -> main_loop
  }
}

-
{
- get_value (mech_defender, HEAT) >= get_value (mech_defender, OVERHEAT):
  You win!
  {mech_defender} overheats and shuts down. {mech_attacker} is the winner!
- get_value (mech_attacker, HEAT) >= get_value (mech_defender, OVERHEAT):
  You Lost!
  {mech_attacker} overheated and was forced to shut down. {mech_defender} is the winner!
- else:
  Game Tied!
}
->->





== arena
= turn_start (count)
  // Recharge
  Turn {count}
  <- mech_base.turn_start (mech_attacker)
  <- mech_base.turn_start (mech_defender)
  // Turn State tells us if the players still want to perform actions or if they are done and ready for the next turn.
  ~ set_turn_state (mech_attacker, VOLLEY)
  ~ set_turn_state (mech_defender, VOLLEY)
  -> DONE

= turn_volley
  ~ temp stateAttacker = get_turn_state (mech_attacker)
  ~ temp stateDefender = get_turn_state (mech_defender)

  {get_fastest() == mech_attacker:

    {get_value (mech_attacker, TURN_STATE) == VOLLEY:
      {mech_attacker} is the first to act.
        -> mech_base.player_volley (mech_attacker) ->
    }
    {get_value (mech_defender, TURN_STATE) == VOLLEY:
    //   -> axman.random_action ->
      -> mech_base.ai_simple (mech_defender, mech_attacker) ->
    - else:
      {mech_defender} takes no action.
    }

  - else:
    {get_value (mech_defender, TURN_STATE) == VOLLEY:
      {mech_defender} is the first to act.
    //   -> axman.random_action ->
      -> mech_base.ai_simple (mech_defender, mech_attacker) ->
    }
    {get_value (mech_attacker, TURN_STATE) == VOLLEY:
        -> mech_base.player_volley (mech_attacker) ->
    - else:
      {mech_attacker} is unable to respond.
    }
  }

  // Check if the game ended, which should abort the rest of the volleys
  {
  - get_value (mech_defender, HEAT) >= get_value (mech_defender, OVERHEAT):
    ~ battle_state = GAMEOVER
    ->->
  - get_value (mech_attacker, HEAT) >= get_value (mech_attacker, OVERHEAT):
    ~ battle_state = GAMEOVER
    ->->
  }

  {get_turn_state (mech_defender) == PASS and get_turn_state (mech_attacker) == PASS:
    // Both sides have passed or run out of energy.
    ->->
  }
  -> turn_volley








== function get_fastest()
  {
  - get_power(mech_defender) <= 0:
    ~ return mech_attacker
  - get_power(mech_attacker) <= 0:
    ~ return mech_defender
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
