LIST TYPES = POWER, HEAT, HEATSINKS

== function get_value(who, type)
  {
  - type == POWER:
    ~ return get_power (who)
  - type == HEAT:
    ~ return get_heat (who)
  - type == HEATSINKS:
    ~ return get_heatsinks (who)
  }
  ~ return 0
  
== function set_value(who, type, value)
  {
  - type == POWER:
    ~ return set_power (who, value)
  - type == HEAT:
    ~ return set_heat (who, value)
  - type == HEATSINKS:
    ~ return set_heatsinks (who, value)
  }
  ~ return false
  
== function update_value(who, type, delta)
  {
  - type == POWER:
    ~ return update_power (who, delta)
  - type == HEAT:
    ~ return update_heat (who, delta)
  - type == HEATSINKS:
    ~ return update_heatsinks (who, delta)
  }
  ~ return false
  