INCLUDE weapons.ink
INCLUDE function_weapons.ink
INCLUDE function_utils.ink
INCLUDE function_attributes.ink


LIST MECHS = IronWolf, Axman
LIST turn_states = PLAY_TURN, END_TURN, GAMEOVER
VAR mech_attacker = IronWolf
VAR mech_attacker_turn_state = PLAY_TURN
VAR mech_defender = Axman
VAR mech_defender_turn_state = PLAY_TURN
VAR mech_overheat = 20

// Setup the mechs for battle
<- ironwolf.start
<- axman.start

-> arena.how_battle_works ->

-> arena.battle_hub ->
-
Post game stuff I think.





== arena
= battle_hub
  ~ set_turn_state(mech_attacker, PLAY_TURN)
  ~ set_turn_state(mech_defender, PLAY_TURN)

  // Turn Start, Recharge everyone
  ~ mech_recharge(mech_attacker)
  ~ mech_recharge(mech_defender)

  // Perform upkeep costs
  -> ironwolf.upkeep ->

  <- axman.status
  <- ironwolf.status

  // Player and AI pick moves until they run out of power or end the turn.
  - (turn_loop)
  ~ temp state_attacker = get_turn_state(mech_attacker)
  ~ temp state_defender = get_turn_state(mech_defender)
  Turn Loop: Player: {state_attacker}; AI: {state_defender}
  {
//  - state_attacker == PLAY_TURN && state_defender == PLAY_TURN:
 //   Alternate turns.
  - state_attacker == PLAY_TURN:
    // Player Attack!
    -> ironwolf.pick_action -> turn_loop
  - state_defender == PLAY_TURN:
    // Defender Attack!
    -> axman.random_action -> turn_loop
  - else:
    No one can attack
  }

  -
  // Check for losing condition
  {
  - get_heat(mech_defender) >= mech_overheat:
    Defender loses!
    ->->
  - get_heat(mech_attacker) >= mech_overheat:
    Attacker Loses!
    ->->
  - else:
    -> battle_hub
  }
  Post play turn loop
  ->->
= how_battle_works
  This is a one on one arena match between challender {mech_attacker} and the defending {mech_defender}.
  <> Each mech is powered by a reactor that genrates POWER each turn; and HEATSINKS that reduce HEAT each turn.
  <> The first mech to reach {mech_overheat} HEAT loses the battle.
  <> Firing weapons, moving, dodging, all cost POWER and generate some HEAT.
  ->->


== ironwolf
= start
  ~ mech_attacker = IronWolf
  ~ set_heat(IronWolf, 0)
  ~ set_power(IronWolf, 0)
  ~ set_heatsinks(IronWolf, 5)
  ~ set_power_regen(IronWolf, 5)
  ~ set_dodge(IronWolf, 10)
  ~ set_speed(IronWolf, 0)
  -> DONE
= status
//   IronWolf: {get_heat(IronWolf)} HEAT, {get_power(IronWolf)} POWER
  {IronWolf} {get_power(IronWolf)} POWER
  <>; {get_heat(IronWolf)} HEAT
  <>; {get_heatsinks(IronWolf)} HEATSINKS
  <>; {get_speed(IronWolf)} Kilometer per POWER
  -> DONE
= pick_action
//   Pick an action.
//   You have {get_power(IronWolf)} POWER left.
  ~ temp currentPower = get_power(IronWolf)
  ~ temp currentHeat = get_heat(IronWolf)
  ~ temp currentHeatsinks = get_heatsinks(IronWolf)
  ~ temp currentSpeed = get_speed(IronWolf)

//   POWER: {currentPower}
//   <>; HEAT: {currentHeat}
//   <>; HEATSINKS: {currentHeatsinks}
//   <>; Speed: {currentSpeed} KPP

  + {currentPower >= 4} [Fire Laser!]
    <- laser.fire(IronWolf, Axman)
    // -> pick_action
  + {currentPower >= 1} [Move]
    -> menu_move ->
    // -> pick_action
  + [End Turn]
    -> post_turn ->
    ->->
  -
  // If we have enough power for more actions.
  {currentPower > 0:
    -> pick_action
  - else:
    -> post_turn ->
  }
  -> DONE
= menu_move
  ~ temp currentRange = get_range()
  {IronWolf} is moving at {get_speed(IronWolf)} POWER/Kilometer PPK Power per Kilometer, Power over Range

  + Evasive Maneuvers
    # TODO add this feature
  + [Increase Speed]
    ~ mech_change_speed(IronWolf, 1, 1)
    {IronWolf} moves faster, increasing speed to {get_speed(IronWolf)} kpp.
  + Decrease Speed
    ~ mech_change_speed(IronWolf, -1, 1)
    {IronWolf} slows down, decreasing speed to {get_speed(IronWolf)} kpp.

  -
  {currentRange != get_range():
    Range changed to {get_range()}
  }
  ->->
= post_turn
  ~ set_turn_state(IronWolf, END_TURN)
//   Ending Player Turn {get_turn_state(IronWolf)}
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
  ~ set_heatsinks(Axman, 5)
  ~ set_power_regen(Axman, 5)
  ~ set_dodge(Axman, 10)
  ~ set_speed(Axman, 0)
  -> DONE
= status
  Axman: {get_heat(Axman)} HEAT, {get_power(Axman)} POWER
  -> DONE
= fire_laser
  <- laser.fire(Axman, IronWolf)
  ->->
= random_action
  <- laser.fire(Axman, IronWolf)
  -> post_turn ->
  ->->
= post_turn
  ~ set_turn_state(Axman, END_TURN)
  ->->


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

== function get_turn_state(who)
{
-  who == mech_attacker:
  ~ return mech_attacker_turn_state
- who == mech_defender:
  ~ return mech_defender_turn_state
}
== function set_turn_state(who, value)
{
-  who == mech_attacker:
  ~ mech_attacker_turn_state = value
  ~ return mech_attacker_turn_state
- who == mech_defender:
  ~ mech_defender_turn_state = value
  ~ return mech_defender_turn_state
}
