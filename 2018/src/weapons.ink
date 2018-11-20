== laser
= fire(attacker, defender)
  {attacker} attepts to  {~fires|blasts} a laser at {defender}.
  ~ temp level = 1
  // First, make sure we can afford this shot.
  ~ temp power = get_power(attacker)
  {power_cost(Laser, level) > power:
    <> but could not {~muster|find|gather} the required power.
    -> DONE
  }
  // Then charge the attacker for the shot.
  ~ update_power(attacker, -power_cost(Laser, level))
  ~ update_heat(attacker, heat_cost(Laser, level))
  
  // Next, let the defender attempt a dodge.
  {did_dodge(get_dodge(defender)):
    <> but {defender} was too {~quick|fast|nimble} and dodged the attack.
    -> DONE
  }
  
  // Finally, deal damage to defender based on range
  ~ temp damage = heat_damage(Laser, level)
  {
  - get_range() == Long:
    <> The {~laser|blast|engery beam} degraded significantly over the long distance.
    ~ damage = damage / 4
  - get_range() == Medium:
    <> Over the medium distance, the {~laser|blast|engery beam}'s power degraded.
    ~ damage = damage / 2
  - else:
    <> The full power of the {~blast|discharge|beam|laser} hits {defender}.
  }
  ~ update_heat(defender, damage)
  
 {attacker} deals {damage} HEAT to {defender}.
  -> DONE
