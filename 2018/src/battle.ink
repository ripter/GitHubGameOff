INCLUDE weapons.ink
INCLUDE function_weapons.ink
INCLUDE function_utils.ink
INCLUDE function_attributes.ink


LIST turn_states = ATTACKING, END_TURN
VAR mech_attacker = IronWolf
VAR mech_attacker_turn_state = ATTACKING
VAR mech_defender = Axman
VAR mech_defender_turn_state = ATTACKING

// Setup the mechs for battle
<- ironwolf.start
<- axman.start

-> arena.how_battle_works ->

-> arena.battle_hub ->
-
Post game stuff I think.





== arena
= battle_hub
//   {~Challenger|} {mech_attacker}
//   {mech_attacker} faces off against {mech_defender} at {get_range()} range.

  ~ mech_recharge(mech_attacker)
  ~ mech_recharge(mech_defender)
  <- axman.status
  <- ironwolf.status

  // Player and AI pick moves until they run out of power or end the turn.
  {
  - get_turn_state(mech_attacker) == ATTACKING && get_turn_state(mech_defender) == ATTACKING:
    Next Turn! Random order
  - get_turn_state(mech_attacker) == ATTACKING && get_turn_state(mech_defender) != ATTACKING:
    Just Attacker Turn!
  - get_turn_state(mech_attacker) != ATTACKING && get_turn_state(mech_defender) == ATTACKING:
    Just Defender Turn!
  }

  // {get_power(IronWolf) > 0: 
  //   -> ironwolf.pick_action ->
  // }
  //
  // -> axman.fire_laser ->
  //

  // Check for losing condition
  {
  - get_heat(mech_defender) >= 20:
    Defender loses!
    ->->
  - get_heat(mech_attacker) >= 20:
    Attacker Loses!
    ->->
  - else:
    -> battle_hub
  }
  ->->
= how_battle_works
  This is a one on one arena match between challender {mech_attacker} and the defending {mech_defender}.
  <> Each mech is powered by a reactor that genrates POWER each turn; and HEATSINKS that reduce HEAT each turn.
  <> The first mech to reach 20 HEAT loses the battle.
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
  IronWolf: {get_heat(IronWolf)} HEAT, {get_power(IronWolf)} POWER
  -> DONE
= pick_action
//   Pick an action.
//   You have {get_power(IronWolf)} POWER left.
  ~ temp currentPower = get_power(IronWolf)
  ~ temp currentHeat = get_heat(IronWolf)
  ~ temp currentHeatsinks = get_heatsinks(IronWolf)
  ~ temp currentSpeed = get_speed(IronWolf)

  POWER: {currentPower}
  HEAT: {currentHeat}
  HEATSINKS: {currentHeatsinks}
  Speed: {currentSpeed} KPP

  + {currentPower >= 4} [Fire Laser!]
    <- laser.fire(IronWolf, Axman)
    // -> pick_action
  + {currentPower >= 1} [Move]
    -> menu_move ->
    // -> pick_action
  + [End Turn]
    ->->
  -
  // If we have enough power for more actions.
  {currentPower > 0:
    -> pick_action
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


//
// defunt code that can be deleted after NaNoWriMo
// I am going to pick some random numbers to see if my function works. {random_numner()}, {random_numner()}, oh and {random_numner()} we should never forget {random_numner()}.
// But what we want to know the most, is if we can compare with a number: {random_numner() > 10: Grater than 10! Oh my!}
// Because the random numbers did not work, now I am going back to the string method I tested in battle_test_one.
// At 10% {did_dodge(10, 1)}, 20% {did_dodge(20, 1)}, 30% {did_dodge(30, 1)}, 40% {did_dodge(40, 1)}, 50% {did_dodge(50, 1)}, 60% {did_dodge(60, 1)}, 70% {did_dodge(70, 1)}, 80% {did_dodge(80, 1)}, 90% {did_dodge(90, 1)}, 100% {did_dodge(100, 1)}
//   {who} had {get_power(who)} POWER, and regenerated {get_power_regen(who)} POWER.
//   <> {who} now has {get_power(who)} POWER.
//   ~ update_power(Axman, -4)
//   ~ update_heat(Axman, 2)
//   ~ update_heat(IronWolf, 4)
//   + {currentPower >= 1} [Fire Missile!]
//     You fired some missiles! Whoosh Boom!
//     -> pick_action
//   + {currentPower >= 2} [Dodge!]
//     That was a close one, but you managed to doge!
//     -> pick_action
//   + {currentPower >= 5} [Move Closer!]
//     You run ahead, trying to get in range.
//     -> pick_action
//   + {currentPower >= 5} [Move Away!]
//     You back up, trying to put some distance between the two of you.
//     -> pick_action
// ~ update_power(IronWolf, -4)
// ~ update_heat(IronWolf, 2)
// You fired a laser! Pew Pew!
// Now {mech_defender} gets a chance to attack.
// // -> battle_test_three.pick_action ->
// Wow, such action. maybe you could pick another?
// // -> battle_test_three.pick_action ->
// And again to show that the menu keep continuing.
// ~ update_speed(IronWolf, -1)
// ~ update_power(IronWolf, -1)
// ~ update_speed(IronWolf, 1)
// ~ update_power(IronWolf, -1)
