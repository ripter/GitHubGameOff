INCLUDE weapons.ink
INCLUDE mech_base.ink
INCLUDE function_weapons.ink
INCLUDE function_utils.ink
INCLUDE function_attributes.ink
INCLUDE function_core.ink

-> gameoff_battle_draft_two

== gameoff_battle_draft_two
VAR battle_state = PLAYING
VAR mech_attacker = Catapult
VAR mech_defender = Axman

// Setup the mechs for battle
<- mech_base.start(mech_attacker)
<- mech_base.start(mech_defender)
// <- ironwolf.start
// <- axman.start

// Two giant war machines piloted by humans, also known as Mechs are battling against each other. The challenger {mech_attacker} is controlled by you, while your opponent {mech_defender} is controlled by a dumb AI.

// Each turn, the Mechs recharge POWER and dissipate HEAT. The first Mech to reach {get_value (mech_defender, OVERHEAT)} HEAT loses the game.
// Each turn is made up of two steps, a recharge of your POWER, and a volley of attacks. You and your opponent take turns moving or firing weapons at each other during the volley.
// You can attack or move

VAR turn_count = 0
- (main_loop)
{battle_state == PLAYING:
  ~ turn_count += 1

  // Start the turn
  <- arena.turn_start(turn_count)
//   Turn {turn_count}

  // Recharge, Upkeep, Dissipate Heat
//   -> arena.turn_start ->

//   As the round begins. {mech_attacker} and {mech_defender} are within {get_value (NULL, RANGE)} range.

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

  // Reset turn mode
  // Turn State tells us if the players still want to perform actions or if they are done and ready for the next turn.
  ~ set_turn_state (mech_attacker, VOLLEY)
  ~ set_turn_state (mech_defender, VOLLEY)
  -> DONE
= turn_start_draft_one
  // Let each mech perform optional upkeep
  -> ironwolf.upkeep ->
  -> axman.upkeep ->
  ->->

= turn_volley
  ~ temp stateAttacker = get_turn_state (mech_attacker)
  ~ temp stateDefender = get_turn_state (mech_defender)
  ~ temp player_action = -> ironwolf.pick_action
  ~ temp ai_action = -> axman.random_action

  {get_fastest() == mech_attacker:

    {get_value (mech_attacker, TURN_STATE) == VOLLEY:
      {mech_attacker} is the first to act.
        -> player_action ->
//      -> ironwolf.pick_action ->
    }
    {get_value (mech_defender, TURN_STATE) == VOLLEY:
//      -> axman.random_action ->
      -> ai_action ->
    - else:
      {mech_defender} takes no action.
    }

  - else:
    {get_value (mech_defender, TURN_STATE) == VOLLEY:
      {mech_defender} is the first to act.
//      -> axman.random_action ->
      -> ai_action ->
    }
    {get_value (mech_attacker, TURN_STATE) == VOLLEY:
//      -> ironwolf.pick_action ->
      -> player_action ->
    - else:
      {mech_attacker} is unable to respond.
    }
  }

  // Check if the game ended, which should abort the rest of the volleys
  {is_gameover():
    ~ battle_state = GAMEOVER
    ->->
  }

  {get_turn_state (mech_defender) == PASS and get_turn_state (mech_attacker) == PASS:
    // Both sides have passed or run out of energy.
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
  ~ set_dodge(IronWolf, 0)
  ~ set_speed(IronWolf, 0)
  -> DONE
= status
  # render: playerStatus
  POWER: {get_value(IronWolf, POWER)}; <>
  REGEN: {get_value(IronWolf, REGEN)}; <>
  HEAT: {get_value(IronWolf, HEAT)}; <>
  HEATSINKS: {get_value(IronWolf, HEATSINKS)}; <>
  SPEED: {get_value(IronWolf, SPEED)}; <>
  EVASIVE_MANEUVERS: {get_value(IronWolf, EVASIVE_MANEUVERS)}; <>
  DODGE: {get_value(IronWolf, DODGE)}; <>
  RANGE: {get_value(IronWolf, RANGE)}; <>
  STATE: {get_value(IronWolf, TURN_STATE)};
  -> DONE

= pick_action
  ~ temp currentPower = get_power(IronWolf)

  Your opponent has {get_value (mech_defender, POWER)} POWER and {get_value (mech_defender, HEAT)} HEAT
  You have {currentPower} POWER and {get_value (IronWolf, HEAT)} HEAT.
  You are in {get_value (NULL, RANGE)} range.
  + [Pick Action]
    Your current status:
    <- status
  + [Pass until next turn]
    <- pass_turn
    ->->
  -

  + {currentPower >= 4} [Fire Laser - {power_cost(Laser, 1)} POWER; {heat_cost(Laser, 1)} HEAT; 3-4 Damage]
    <- laser.fire (IronWolf, mech_defender)
  + {currentPower >= 1} [Increase Speed - {power_cost (Move, 1)} POWER]
    <- reactor.move_forward (IronWolf)
  + {currentPower >= 5} [Sharp speed increase. {power_cost (Move, 5)} POWER]
    <- reactor.move_run (IronWolf)
  + [Wait until next turn to generate more POWER]
    <- pass_turn
  -
  ->->

= upkeep
  ~ temp speed = get_speed(IronWolf)
  { speed <= 0:
    ->->
  }

  Continue current speed of {speed}kpp? It will cost {power_cost (Move, speed)} POWER.
  + [Yes, Keep up speed]
    <- reactor.upkeep_speed (IronWolf)
  + [No, cut speed]
    <- reactor.reset_speed (IronWolf)
  -
  ->->

== pass_turn
  ~ set_turn_state (IronWolf, PASS)
  -> DONE



== axman
= start
  ~ mech_defender = Axman
  ~ set_heat(Axman, 0)
  ~ set_power(Axman, 0)
  ~ set_heatsinks(Axman, 0)
  ~ set_power_regen(Axman, 5)
  ~ set_dodge(Axman, 0)
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
  <- laser.fire(Axman, IronWolf)
  ~ set_turn_state(Axman, PASS)
  ->->
= upkeep
  ->->


== function is_gameover()
  ~ return get_heat(mech_defender) >= get_value (mech_defender, OVERHEAT) or get_heat(mech_attacker) >= get_value (mech_defender, OVERHEAT)

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
