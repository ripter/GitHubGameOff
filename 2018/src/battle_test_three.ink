INCLUDE weapons.ink
INCLUDE functions.ink


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
  <- axman.status
  <- ironwolf.status
  {get_power(IronWolf) > 0: -> ironwolf.pick_action ->}
  
  -> axman.fire_laser ->
  
  {
  - get_power(IronWolf) > 0:
    ~ update_power(IronWolf, 5)
    -> battle_hub
  - else:
    ->->
  }
  ->->


== ironwolf
= start
  ~ mech_attacker = IronWolf
  ~ heat_attacker = 0
  ~ power_attacker = 5
  ~ power_regen_attacker = 5
  ~ heatsinks_attacker = 10
  -> DONE
= status
  IronWolf: {get_heat(IronWolf)} HEAT, {get_power(IronWolf)} POWER
  -> DONE
= pick_action
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
  ~ heat_defender = 0
  ~ power_defender = 5
  ~ heatsinks_defender = 10
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





LIST RANGE = Long, Medium, Short
LIST MECHS = IronWolf, Axman, Catapult, Atlas


VAR mech_attacker = IronWolf
VAR mech_defender = Axman

VAR power_attacker = 5
VAR power_defender = 5
== function update_power(who, delta)
{
  - who == mech_attacker:
    ~ power_attacker += delta
    ~ return power_attacker
  - who == mech_defender:
    ~ power_defender += delta
    ~ return power_defender
}
== function get_power(who)
{
  - who == mech_attacker:
    ~ return power_attacker
  - who == mech_defender:
    ~ return power_defender
}

VAR heat_attacker = 0
VAR heat_defender = 0
== function update_heat(who, delta)
{
  - who == mech_attacker:
    ~ heat_attacker += delta
    ~ return heat_attacker
  - who == mech_defender:
    ~ heat_defender += delta
    ~ return heat_defender
}
== function get_heat(who)
{
  - who == mech_attacker:
    ~ return heat_attacker
  - who == mech_defender:
    ~ return heat_defender
}

VAR heatsinks_attacker = 10
VAR heatsinks_defender = 10
== function heatsinks(who, delta)
{
  - who == mech_attacker:
    ~ heatsinks_attacker += delta
    ~ return heatsinks_attacker
  - who == mech_defender:
    ~ heatsinks_defender += delta
    ~ return heatsinks_defender
}
VAR power_regen_attacker = 0
VAR power_regen_defender = 0


