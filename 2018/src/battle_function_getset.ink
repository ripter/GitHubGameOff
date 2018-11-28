//
// Getters and Setters for each TYPE
// These get/store/update the actual data that the core API uses.
//

//
// Range Functions
== function get_range()
  ~ return BATTLE_RANGE
== function set_range(value)
  ~ BATTLE_RANGE = value
== function update_range(delta)
  ~ BATTLE_RANGE += delta
  ~ return BATTLE_RANGE

//
//
// Heat Functions
VAR heat_attacker = 0
VAR heat_defender = 0
VAR heatsinks_attacker = 0
VAR heatsinks_defender = 0
VAR overheat_attacker = 10
VAR overheat_defender = 10
== function get_heat(who)
{
  - who == mech_attacker:
    ~ return heat_attacker
  - who == mech_defender:
    ~ return heat_defender
}
== function set_heat(who, value)
{
  - who == mech_attacker:
    ~ heat_attacker = value
    ~ return heat_attacker
  - who == mech_defender:
    ~ heat_defender = value
    ~ return heat_defender
}
== function update_heat(who, delta)
  ~ return set_heat(who, min_zero(delta + get_heat(who)))

== function get_heatsinks(who)
{
  - who == mech_attacker:
    ~ return heatsinks_attacker
  - who == mech_defender:
    ~ return heatsinks_defender
}
== function set_heatsinks(who, value)
{
  - who == mech_attacker:
    ~ heatsinks_attacker = value
    ~ return heatsinks_attacker
  - who == mech_defender:
    ~ heatsinks_defender = value
    ~ return heatsinks_defender
}
== function update_heatsinks(who, delta)
  ~ return set_heatsinks(who, min_zero(delta + get_heatsinks(who)))

== function get_overheat(who)
  {
    - who == mech_attacker:
      ~ return overheat_attacker
    - who == mech_defender:
      ~ return overheat_defender
  }
  == function set_overheat(who, value)
  {
    - who == mech_attacker:
      ~ overheat_attacker = value
      ~ return overheat_attacker
    - who == mech_defender:
      ~ overheat_defender = value
      ~ return overheat_defender
  }
  == function update_overheat(who, delta)
    ~ return set_overheat(who, min_zero(delta + get_overheat(who)))

//
//
// Power Functions
VAR power_attacker = 0
VAR power_defender = 0
VAR power_regen_attacker = 0
VAR power_regen_defender = 0
== function get_power(who)
{
  - who == mech_attacker:
    ~ return power_attacker
  - who == mech_defender:
    ~ return power_defender
}
== function set_power(who, value)
{
  - who == mech_attacker:
    ~ power_attacker = value
    ~ return power_attacker
  - who == mech_defender:
    ~ power_defender = value
    ~ return power_defender
}
== function update_power(who, delta)
  ~ return set_power(who, delta + get_power(who))

== function get_power_regen(who)
{
  - who == mech_attacker:
    ~ return power_regen_attacker
  - who == mech_defender:
    ~ return power_regen_defender
}
== function set_power_regen(who, value)
{
  - who == mech_attacker:
    ~ power_regen_attacker = value
    ~ return power_regen_attacker
  - who == mech_defender:
    ~ power_regen_defender = value
    ~ return power_regen_defender
}
== function update_power_regen(who, delta)
  ~ return set_power_regen(who, delta + get_power_regen(who))


//
//
// Dodge Functions
VAR dodge_attacker = 0
VAR dodge_defender = 0
== function get_dodge(who)
  {
    - who == mech_attacker:
      ~ return dodge_attacker
    - who == mech_defender:
      ~ return dodge_defender
  }
== function set_dodge(who, value)
  {
    - who == mech_attacker:
      ~ dodge_attacker = value
      ~ return dodge_attacker
    - who == mech_defender:
      ~ dodge_defender = value
      ~ return dodge_defender
  }
== function update_dodge(who, delta)
  ~ return set_dodge(who, delta + get_dodge(who))




//
// Turn State Functions
VAR mech_attacker_turn_state = VOLLEY
VAR mech_defender_turn_state = VOLLEY
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
== function update_turn_state(who, delta)
  ~ return set_turn_state (who, delta + get_turn_state (who))


//
// Evasive Maneuvers
VAR evasive_maneuvers_attacker = false
VAR evasive_maneuvers_defender = false
== function get_evasive_maneuvers(who)
{
  - who == mech_attacker:
    ~ return evasive_maneuvers_attacker
  - who == mech_defender:
    ~ return evasive_maneuvers_defender
}
== function set_evasive_maneuvers(who, value)
{
  - who == mech_attacker:
    ~ evasive_maneuvers_attacker = value
    ~ return evasive_maneuvers_attacker
  - who == mech_defender:
    ~ evasive_maneuvers_defender = value
    ~ return evasive_maneuvers_defender
}
== function update_evasive_maneuvers(who, delta)
  ~ return set_evasive_maneuvers(who, delta + get_evasive_maneuvers(who))

//
//
// Weapons Functions
VAR weapon_attacker = 0
VAR weapon_defender = 0
== function get_weapon(who)
  {
    - who == mech_attacker:
      ~ return weapon_attacker
    - who == mech_defender:
      ~ return weapon_defender
  }
== function set_weapon(who, value)
  {
    - who == mech_attacker:
      ~ weapon_attacker = value
      ~ return weapon_attacker
    - who == mech_defender:
      ~ weapon_defender = value
      ~ return weapon_defender
  }
== function update_weapon(who, delta)
  ~ return set_weapon(who, delta + get_weapon(who))
