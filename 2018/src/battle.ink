INCLUDE battle_function_base.ink
INCLUDE battle_function_utils.ink
INCLUDE battle_mech_base.ink

-> gameoff_battle_draft_two -> END

== gameoff_battle_draft_two
VAR battle_state = PLAYING
VAR mech_attacker = Catapult
VAR mech_defender = Axman

This is a mech battle between you piloting the {mech_attacker} vs an {mech_defender}.

Do you know how to play?
  * [How do I play?]
    -> arena.how_to_play ->
  * [About the mechs]
    -> arena.about_the_mechs ->
  * [I know how to play]

-
// Setup the mechs for battle
<- mech_base.start(mech_attacker)
<- mech_base.start(mech_defender)
// Setup the arena for battle
~ set_value (mech_attacker, RANGE, Long)


VAR turn_count = 0
VAR volley_count = 0
- (main_loop)
{battle_state == PLAYING:
  ~ turn_count += 1

  // Run the start of turn actions
  -> arena.turn_start (turn_count) ->

  // Each Mech takes turns Moving/Firing until they both run out of POWER or PASS
  // This is the "real time" combat, they alternate performing actions to simulate if they were both performing those actions in real time.
  -> arena.turn_volley ->


  {turn_count >= 30:
    The battle is a Tie! No one was able to win within 30 turns.
    ~ battle_state = GAMEOVER
  }

  // Check if we should loop again.
  {battle_state == PLAYING:
    // Pause for the player. Give them time to read everything that has happened so far.
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
  #title: Round
  
  Round {count}
  // Tell each fighter to perform start of turn functions.
  // ex: recharge POWER and dissipate HEAT
  <- mech_base.turn_start (mech_attacker)
  <- mech_base.turn_start (mech_defender)

  ~ volley_count = 0
  -
  -> next_section ->
  ->->

= turn_volley
  #title: Volley
  ~ volley_count += 1
  // In a Volley, Each fighter can perform 1 action, or pass until the next turn.
  // Volleys repeat until both fighters pass
  ~ temp firstMech = mech_attacker
  ~ temp secondMech = mech_defender

  {get_fastest() == secondMech:
    ~ firstMech = mech_defender
    ~ secondMech = mech_attacker
  }
  
  Volley {volley_count}
  {firstMech} gets first action, then {secondMech}
  
  <- mech_base.status_volley (firstMech)
  <- mech_base.status_volley (secondMech)

 
 // Check if both fighters passed
  {did_pass (mech_attacker) and did_pass (mech_defender):
    // Both sides have passed or run out of energy.
    ->->
  }


  -
  -> next_section ->

  // Fastest mech gets to perform an action first in the Volley
  {firstMech == mech_attacker:
    {is_in_volley (mech_attacker):
      -> player_turn ->
    }
    {is_in_volley (mech_defender):
      -> ai_turn ->
    }
  - else:
    {is_in_volley (mech_defender):
      -> ai_turn ->
    }
    {is_in_volley (mech_attacker):
      -> player_turn ->
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

= how_to_play
  #title: How to play
  The goal is to overheat your opponent. Actions like firing weapons and moving cost power. Energy weapons deal heat to your opponent, while physical weapons destroy heatsinks (which are how you dissipate heat each round).

  The battle is made up of Rounds and Actions. At the start of each round, both mechs generate POWER and dissipate HEAT. Then, during the round, you and your opponent take turns performing actions.

  Once you both either run out of power or pass the round ends. Both mechs will generate power and dissipate heat, then you can take turns performing actions again.

  * [About the mechs]
    -> about_the_mechs ->
  * [Ready to Play!]
  -
  ->->
= about_the_mechs
  #title: Mech Info
  Your opponent is an Axman. A bipedal 9 meter tall mech with an Ax as one hand, and a laser as the other hand. His basic stratagy is to get in Melee range and attack with the Ax.
  You are a Catapult. An armless bipedal 8.5 meter tall mech with Missile racks for shoulders and a laser on the nose. Missiles are an inexpensive way to deal physical damage from a distance, but can not be used in Melee range. 
  
  * [How do I play?]
    -> arena.how_to_play ->
  * [Ready to Play!]
  -
  ->->

= player_turn
  #title: Catapult (You)
  {is_in_volley (mech_attacker):
    -> mech_base.player_volley (mech_attacker, mech_defender) ->
  - else:
    {get_value (mech_attacker, POWER) <= 0:
      You are out of power. Wait until the next Round to generate {get_value (mech_attacker, REGEN)} POWER and dissipate {get_value (mech_attacker, HEATSINKS)} HEAT.
    - else:
      You are waiting for the next Round.
    }
  }

  -
  -> next_section ->
  ->->

= ai_turn
  #title: Axman (Opponent)

  {is_in_volley (mech_defender):
    -> mech_base.ai_simple (mech_defender, mech_attacker) ->
  - else:
    {mech_defender} is waiting until the next Round.
  }

  -
  -> next_section ->
  ->->

== next_section
  + [Continue]
  -
  ->->
