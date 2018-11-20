== laser
= fire(attacker, defender)
  ~ temp level = 1
  // First, make sure we can afford this shot.
  ~ temp power = get_power(attacker)
  {power_cost(Laser, level) > power:
    {attacker} attempted to fire a Laser, but could not muster the required power.
    -> DONE
  }
  // Then charge the attacker for the shot.
  ~ update_power(attacker, -power_cost(Laser, level))
  ~ update_heat(attacker, heat_cost(Laser, level))
  
  // Next, let the defender attempt a dodge.
  {did_dodge(get_dodge(defender)):
    {defender} quickly dodged out of the way.
    -> DONE
  }
  
  // Finally, deal damage to defender.
  ~ update_heat(defender, heat_damage(Laser, level))
  
  {attacker} blasts {defender} with a laser, dealing {heat_damage(Laser, level)} HEAT to {defender}.
  -> DONE
