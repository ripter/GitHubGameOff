
<- axman.status
<- ironwolf.status
-> ironwolf.pick_action ->

Now {mech_defender} gets a chance to attack.
// -> battle_test_three.pick_action ->

Wow, such action. maybe you could pick another?

// -> battle_test_three.pick_action ->

And again to show that the menu keep continuing.


== ironwolf
= start
  ~ mech_attacker = IronWolf
  ~ heat_attacker = 0
  ~ power_attacker = 5
  ~ power_regen_attacker = 5
  ~ heatsinks_attacker = 10
  -> DONE
= status
  IronWolf: {heat(IronWolf, 0)} HEAT, {power(IronWolf, 0)} POWER
  -> DONE
= pick_action
  ~ temp currentPower = power(IronWolf, 0)
  + {currentPower >= 4} [Fire Laser!]
    You fired a laser! Pew Pew!
    -> pick_action
  + {currentPower >= 1} [Fire Missile!]
    You fired some missiles! Whoosh Boom!
    -> pick_action
  + {currentPower >= 2} [Dodge!]
    That was a close one, but you managed to doge!
    -> pick_action
  + {currentPower >= 5} [Move Closer!]
    You run ahead, trying to get in range.
    -> pick_action
  + {currentPower >= 5} [Move Away!]
    You back up, trying to put some distance between the two of you.
    -> pick_action
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
  Axman: {heat(Axman, 0)} HEAT, {power(Axman, 0)} POWER
  -> DONE





LIST RANGE = Long, Medium, Short
LIST MECHS = IronWolf, Axman, Catapult, Atlas


VAR mech_attacker = IronWolf
VAR mech_defender = Axman

VAR power_attacker = 5
VAR power_defender = 5
== function power(who, delta)
{
  - who == mech_attacker:
    ~ power_attacker += delta
    ~ return power_attacker
  - who == mech_defender:
    ~ power_defender += delta
    ~ return power_defender
}
VAR heat_attacker = 0
VAR heat_defender = 0
== function heat(who, delta)
{
  - who == mech_attacker:
    ~ heat_attacker += delta
    ~ return heat_attacker
  - who == mech_defender:
    ~ heat_defender += delta
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