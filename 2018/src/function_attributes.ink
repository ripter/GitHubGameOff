//
// Range Functions
LIST RANGE = Long, Medium, Melee
VAR mech_range = 15
== function get_range()
{
- mech_range <= 5:
  ~ return Melee
- mech_range <= 10:
  ~ return Medium
- else:
  ~ return Long
}
== function set_range(value)
{
- value >= 15:
  ~ mech_range = 15
- value <= 0:
  ~ mech_range = 0
- else:
  ~ mech_range = value
}
== function update_range(delta)
  ~ mech_range += delta

//
// Heat Functions
VAR heat_attacker = 0
VAR heat_defender = 0
VAR heatsinks_attacker = 0
VAR heatsinks_defender = 0
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
    ~ return heat_attacker
  - who == mech_defender:
    ~ return heat_defender
}
== function set_heatsinks(who, value)
{
  - who == mech_attacker:
    ~ heat_attacker = value
    ~ return heat_attacker
  - who == mech_defender:
    ~ heat_defender = value
    ~ return heat_defender
}
== function update_heatsinks(who, delta)
  ~ return set_heatsinks(who, min_zero(delta + get_heatsinks(who)))


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
