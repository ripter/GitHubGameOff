LIST TYPES = POWER, REGEN, HEAT, HEATSINKS, OVERHEAT, SPEED, DODGE, EVASIVE_MANEUVERS, CHARGE_FORWARD, CHARGE_BACKWARD, TURN_STATE, RANGE, WEAPON
LIST STATES = VOLLEY, PASS, GAMEOVER, PLAYING, NULL
LIST BATTLE_RANGE = Melee, Medium, (Long)
LIST WEAPONS = Laser, Missile, Dodge, Move, Punch
LIST MECHS = IronWolf, Axman, Catapult

//
// High Level API
// These are the functions that should be used in all the knots.
// Make these external to store outside of INK
//
== function get_value(who, type)
  {
  - type == POWER:
    ~ return get_power (who)
  - type == REGEN:
    ~ return get_power_regen (who)
  - type == HEAT:
    ~ return get_heat (who)
  - type == HEATSINKS:
    ~ return get_heatsinks (who)
  - type == OVERHEAT:
    ~ return get_overheat (who)
  - type == TURN_STATE:
    ~ return get_turn_state (who)
  - type == SPEED:
    ~ return get_speed (who)
  - type == DODGE:
    ~ return get_dodge (who)
  - type == RANGE:
    ~ return get_range()
  - type == EVASIVE_MANEUVERS:
    ~ return get_evasive_maneuvers (who)
  - type == WEAPON:
    ~ return get_weapon (who)
  }
  ~ return 0

== function set_value(who, type, value)
  {
  - type == POWER:
    ~ return set_power (who, value)
  - type == REGEN:
    ~ return set_power_regen (who, value)
  - type == HEAT:
    ~ return set_heat (who, value)
  - type == HEATSINKS:
    ~ return set_heatsinks (who, value)
  - type == OVERHEAT:
    ~ return set_overheat (who, value)
  - type == TURN_STATE:
    ~ return set_turn_state (who, value)
  - type == SPEED:
    ~ return set_speed (who, value)
  - type == DODGE:
    ~ return set_dodge (who, value)
  - type == RANGE:
    ~ return set_range (value)
  - type == EVASIVE_MANEUVERS:
    ~ return set_evasive_maneuvers (who, value)
  - type == WEAPON:
    ~ return set_weapon (who, value)
  }
  ~ return false

== function update_value(who, type, delta)
  {
  - type == POWER:
    ~ return update_power (who, delta)
  - type == REGEN:
    ~ return update_power_regen (who, delta)
  - type == HEAT:
    ~ return update_heat (who, delta)
  - type == HEATSINKS:
    ~ return update_heatsinks (who, delta)
  - type == OVERHEAT:
    ~ return update_overheat (who, delta)
  - type == TURN_STATE:
    ~ return update_turn_state (who, delta)
  - type == SPEED:
    ~ return update_speed (who, delta)
  - type == DODGE:
    ~ return update_dodge (who, delta)
  - type == RANGE:
    ~ return update_range (delta)
  - type == EVASIVE_MANEUVERS:
    ~ return update_evasive_maneuvers (who, delta)
  - type == WEAPON:
    ~ return update_weapon (who, delta)
  }
  ~ return false



//
// Low Level API
// Getters and Setters for each TYPE
// And the underlying VARS that hold the information.
// This should not be accessed directly, except by the high level API.
// That way we can later change the high level API to external, and the game will still work.
// Gives us more options in the future, without sacrificing anything.
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
//
// Speed Functions
VAR speed_attacker = 0
VAR speed_defender = 0
== function get_speed(who)
{
  - who == mech_attacker:
    ~ return speed_attacker
  - who == mech_defender:
    ~ return speed_defender
}
== function set_speed(who, value)
{
  - who == mech_attacker:
    ~ speed_attacker = value
    ~ return speed_attacker
  - who == mech_defender:
    ~ speed_defender = value
    ~ return speed_defender
}
== function update_speed(who, delta)
  ~ return set_speed(who, delta + get_speed(who))


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
