LIST TYPES = POWER, REGEN, HEAT, HEATSINKS, OVERHEAT, SPEED, DODGE, EVASIVE_MANEUVERS, TURN_STATE, RANGE, WEAPON
LIST STATES = VOLLEY, PASS, GAMEOVER, PLAYING, NULL
LIST ZONE_RANGES = Long, Medium, Melee
LIST WEAPONS = Laser, Missile, Dodge, Move
LIST MECHS = IronWolf, Axman, Catapult

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
