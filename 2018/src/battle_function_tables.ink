

== function power_cost(weapon, level)
{
- weapon == Laser:
  ~ return 4 * level
- weapon == Missile:
  ~ return 1 * level
- weapon == Dodge:
  ~ return 2 * level
- weapon == EVASIVE_MANEUVERS:
  ~ return 2 * level
- weapon == CHARGE_FORWARD:
  ~ return 5 * level
- weapon == CHARGE_BACKWARD:
  ~ return 5 * level
- weapon == Punch:
  ~ return 5 * level
}

== function heat_cost(weapon, level)
{
- weapon == Laser:
  ~ return 1 * level
- else:
  ~ return 0
}



== function heat_damage(weapon, base)
~ temp bonus = 0
~ temp damage = 0
{
- weapon == Laser:
  ~ bonus = bonus_small()
  ~ damage = (base * (power_cost (Laser, base) - heat_cost (Laser, base)))
- weapon == Missile:
  ~ damage = base * 1
- weapon == Punch:
  ~ damage = bonus_small()
}
~ return damage



== function heatsink_damage(weapon, base)
{weapon == Punch:
  ~ return 2 + bonus_small()
}
~ return 0
