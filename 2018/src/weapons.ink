== laser
= fire(attacker, defender)
  {attacker} shoots a laser at {defender} costing {power_cost(Laser, 1)} POWER.
  <> He has {get_power(attacker)} POWER before the attack 
  // Cost to fire
  ~ update_power(attacker, -power_cost(Laser, 1))
  ~ update_heat(attacker, heat_cost(Laser, 1))
  
  // Damage delt
  ~ update_heat(defender, heat_damage(Laser, 1))
  
  <> and {get_power(attacker)} POWER after the attack.
  -> DONE
