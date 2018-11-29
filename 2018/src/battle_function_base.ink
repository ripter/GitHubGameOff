INCLUDE battle_function_getset.ink
INCLUDE battle_function_tables.ink

LIST TYPES = DODGE, IS_USING_EVASIVE_MANEUVERS, HEAT, HEATSINKS, OVERHEAT, POWER, RANGE, REGEN, TURN_STATE, WEAPONS
LIST ACTIONS = Laser, Missile, Punch, Move_Back, Move_Forward, Evasive_Maneuvers
LIST STATES = GAMEOVER, NULL, PASS, PLAYING, VOLLEY
LIST BATTLE_RANGE = Melee, Medium, (Long)
LIST MECHS = Axman, Catapult

//
// Core API
// These are the core functions for getting/setting/updating state in the game.
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
  - type == DODGE:
    ~ return get_dodge (who)
  - type == RANGE:
    ~ return get_range()
  - type == IS_USING_EVASIVE_MANEUVERS:
    ~ return get_evasive_maneuvers (who)
  - type == WEAPONS:
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
  - type == DODGE:
    ~ return set_dodge (who, value)
  - type == RANGE:
    ~ return set_range (value)
  - type == IS_USING_EVASIVE_MANEUVERS:
    ~ return set_evasive_maneuvers (who, value)
  - type == WEAPONS:
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
  - type == DODGE:
    ~ return update_dodge (who, delta)
  - type == RANGE:
    ~ return update_range (delta)
  - type == IS_USING_EVASIVE_MANEUVERS:
    ~ return update_evasive_maneuvers (who, delta)
  - type == WEAPONS:
    ~ return update_weapon (who, delta)
  }
  ~ return false
