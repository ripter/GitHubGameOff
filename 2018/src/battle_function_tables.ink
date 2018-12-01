

== function power_cost(weapon, level)
{
- weapon == Laser:
  ~ return 4
- weapon == Missile:
  ~ return 2
- weapon == Evasive_Maneuvers:
  ~ return 2 * level
- weapon == Move_Forward:
  ~ return 5 * level
- weapon == Move_Back:
  ~ return 5 * level
- weapon == Punch:
  ~ return 5 * level
}

== function heat_cost(weapon, level)
{
- weapon == Laser:
  ~ return 1
- else:
  ~ return 0
}



== function heat_damage(weapon, base)
~ temp bonus = 0
~ temp damage = 0
{
- weapon == Laser:
  ~ return 4
- weapon == Missile:
  ~ damage = 1
- weapon == Punch:
  ~ damage = 1
}
~ return damage



== function heatsink_damage(weapon, base)
{
- weapon == Punch:
  ~ return 2
 - weapon == Missile:
   ~ return 1
}
~ return 0
