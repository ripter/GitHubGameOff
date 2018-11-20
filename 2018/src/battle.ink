INCLUDE weapons.ink
INCLUDE function_weapons.ink
INCLUDE function_utils.ink
INCLUDE function_attributes.ink



LIST RANGE = Long, Medium, Short
LIST MECHS = IronWolf, Axman, Catapult, Atlas
VAR mech_attacker = IronWolf
VAR mech_defender = Axman

// Setup the mechs for battle
<- ironwolf.start
<- axman.start

-> arena.battle_hub ->
-
Post game stuff I think.


Now {mech_defender} gets a chance to attack.
// -> battle_test_three.pick_action ->

Wow, such action. maybe you could pick another?

// -> battle_test_three.pick_action ->

And again to show that the menu keep continuing.

== arena
= battle_hub
  ~ mech_recharge(mech_attacker)
  ~ mech_recharge(mech_defender)

  <- axman.status
  <- ironwolf.status

  {get_power(IronWolf) > 0: -> ironwolf.pick_action ->}

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
    ~ update_power(IronWolf, 5)
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
  -> DONE
= recharge
  ~ mech_recharge(IronWolf)
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
    // ~ update_power(IronWolf, -4)
    // ~ update_heat(IronWolf, 2)
    // You fired a laser! Pew Pew!
    -> pick_action
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
  + [End Turn]
    ->->
  -> DONE


== axman
= start
  ~ mech_defender = Axman
  ~ set_heat(Axman, 0)
  ~ set_power(Axman, 0)
  ~ set_heatsinks(Axman, 10)
  ~ set_power_regen(Axman, 5)
  -> DONE
= recharge
  ~ mech_recharge(Axman)
  -> DONE
= status
  Axman: {get_heat(Axman)} HEAT, {get_power(Axman)} POWER
  -> DONE
= fire_laser
  <- laser.fire(Axman, IronWolf)
//   ~ update_power(Axman, -4)
//   ~ update_heat(Axman, 2)
//   ~ update_heat(IronWolf, 4)
  ->->



== function mech_recharge(who)
  {who} had {get_power(who)} POWER, and regenerated {get_power_regen(who)} POWER.
  ~ update_power(who, get_power_regen(who))
  ~ update_heat(who, -get_heatsinks(who))
  <> {who} now has {get_power(who)} POWER.



