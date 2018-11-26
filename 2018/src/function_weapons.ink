
== function power_cost(weapon, level)
{
- weapon == Laser:
  ~ return 4 * level
- weapon == Missile:
  ~ return 1 * level
- weapon == Move:
  ~ return 1 * level
- weapon == Dodge:
  ~ return 2 * level
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
}
~ return damage


== function did_dodge(chance)
{
- chance <= 0:
  ~ return false
- chance <= 10:
  ~ return chance_10()
- chance <= 20:
  ~ return chance_20()
- chance <= 30:
  ~ return "{~miss|miss|miss|hit|hit}" == "miss"
- chance <= 40:
  ~ return "{~miss|miss|miss|miss|hit}" == "miss"
- chance <= 50:
  ~ return "{~miss|miss|miss|miss|miss|hit|hit|hit|hit|hit}" == "miss"
- chance <= 60:
  ~ return "{~miss|miss|miss|miss|miss|miss|hit|hit|hit|hit}" == "miss"
- chance <= 70:
  ~ return "{~miss|miss|miss|miss|miss|miss|miss|hit|hit|hit}" == "miss"
- chance <= 80:
  ~ return "{~miss|miss|miss|miss|miss|miss|miss|miss|hit|hit}" == "miss"
- chance <= 90:
  ~ return "{~miss|miss|miss|miss|miss|miss|miss|miss|miss|hit}" == "miss"
- else:
  ~ return "miss" == "miss"
}
