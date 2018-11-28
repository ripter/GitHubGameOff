INCLUDE battle_function_core.ink
INCLUDE battle_function_tables.ink
INCLUDE battle_function_utils.ink
INCLUDE battle_mech_base.ink

-> gameoff_battle_draft_two -> END

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

  // Run the start of turn actions
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
// Print the battle results
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
  Turn {count}
  // Tell each fighter to perform start of turn functions.
  // ex: recharge POWER and dissipate HEAT
  <- mech_base.turn_start (mech_attacker)
  <- mech_base.turn_start (mech_defender)
  -> DONE

= turn_volley
  // In a Volley, Each fighter can perform 1 action, or pass until the next turn.
  // Volleys repeat until both fighters pass
  ~ temp stateAttacker = get_value (mech_attacker, TURN_STATE)
  ~ temp stateDefender = get_value (mech_attacker, TURN_STATE)

  {get_fastest() == mech_attacker:
    {is_in_volley (mech_attacker):
      {mech_attacker} is the first to act.
        -> mech_base.player_volley (mech_attacker, mech_defender) ->
    }
    {is_in_volley (mech_defender):
      -> mech_base.ai_simple (mech_defender, mech_attacker) ->
    - else:
      {mech_defender} takes no action.
    }
  - else:
    {is_in_volley (mech_defender):
      {mech_defender} is the first to act.
      -> mech_base.ai_simple (mech_defender, mech_attacker) ->
    }
    {is_in_volley (mech_attacker):
        -> mech_base.player_volley (mech_attacker, mech_defender) ->
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
  // Check if both fighters passed
  {did_pass (mech_attacker) and did_pass (mech_defender):
    // Both sides have passed or run out of energy.
    ->->
  }
  // Loop for the next Volley, someone wants to perform more actions.
  -> turn_volley
