LIST WEAPONS = Laser, Missile

== function power_cost(weapon, level)
{
- weapon == Laser:
  ~ return 4 * level
- weapon == Missile:
  ~ return 1 * level
}

== function heat_cost(weapon, level)
{
- weapon == Laser:
  ~ return 1 * level
- weapon == Missile:
  ~ return 0
}

== function heat_damage(weapon, level)
{
- weapon == Laser:
  ~ return 3 * level
- weapon == Missile:
  ~ return 1 * level
}