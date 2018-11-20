INCLUDE weapons.ink
INCLUDE function_weapons.ink
INCLUDE function_utils.ink
INCLUDE function_attributes.ink


LIST MECHS = IronWolf, Axman, Catapult, Atlas
VAR mech_attacker = IronWolf
VAR mech_defender = Axman

// Setup the mechs for battle
<- ironwolf.start
<- axman.start

-> arena.battle_hub ->
-
Post game stuff I think.





== arena
= battle_hub
  {mech_attacker} faces off against {mech_defender} at {get_range()} range.
  
  ~ mech_recharge(mech_attacker)
  ~ mech_recharge(mech_defender)
  <- axman.status
  <- ironwolf.status

  // Player and AI pick moves until they run out of power or end the turn.
  {get_power(IronWolf) > 0: 
    -> ironwolf.pick_action ->
  }

  -> axman.fire_laser ->


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


== ironwolf
= start
  ~ mech_attacker = IronWolf
  ~ set_heat(IronWolf, 0)
  ~ set_power(IronWolf, 0)
  ~ set_heatsinks(IronWolf, 10)
  ~ set_power_regen(IronWolf, 5)
  ~ set_dodge(IronWolf, 10)
  ~ set_speed(IronWolf, 0)
  -> DONE
= status
  IronWolf: {get_heat(IronWolf)} HEAT, {get_power(IronWolf)} POWER
  -> DONE
= pick_action
  Pick an action.
  You have {get_power(IronWolf)} POWER left.
  ~ temp currentPower = get_power(IronWolf)
  + {currentPower >= 4} [Fire Laser!]
    <- laser.fire(IronWolf, Axman)
    -> pick_action
  + [Move]
    -> menu_move ->
    -> pick_action
  + [End Turn]
    ->->
  -> DONE
= menu_move
  {IronWolf} is moving at {get_speed(IronWolf)} POWER/Kilometer PPK Power per Kilometer, Power over Range
  + Evasive Maneuvers
    ->->
  + Increase Speed
    ~ update_speed(IronWolf, 1)
    ~ update_power(IronWolf, -1)
    ->->
  + Decrease Speed
    ~ update_speed(IronWolf, -1)
    ~ update_power(IronWolf, -1)
    ->->
  -> DONE


== axman
= start
  ~ mech_defender = Axman
  ~ set_heat(Axman, 0)
  ~ set_power(Axman, 0)
  ~ set_heatsinks(Axman, 10)
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



== function mech_recharge(who)
  ~ update_power(who, get_power_regen(who))
  ~ update_heat(who, -get_heatsinks(who))





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