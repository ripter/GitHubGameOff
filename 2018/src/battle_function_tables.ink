
//
// Cost Functions
== function power_cost(weapon)
{
- weapon == Laser:
  ~ return 4
- weapon == Missile:
  ~ return 2
- weapon == Evasive_Maneuvers:
  ~ return 2
- weapon == Punch:
  ~ return 3
- weapon == Move_Forward:
  ~ return 4
- weapon == Move_Back:
  ~ return 4
- else:
  ~ return 5
}

== function heat_cost(weapon, level)
{
- weapon == Laser:
  ~ return 1
- else:
  ~ return 0
}



//
// Damage Functions
== function heat_damage(weapon, base)
{
- weapon == Laser:
  ~ return 4
- weapon == Missile:
  ~ return 1
- weapon == Punch:
  ~ return 1
}


== function heatsink_damage(weapon, base)
{
- weapon == Punch:
  ~ return 2
 - weapon == Missile:
   ~ return 1
}
~ return 0
