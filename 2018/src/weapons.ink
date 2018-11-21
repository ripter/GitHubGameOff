== laser
= fire(attacker, defender)
  {attacker} attempts to  {~fires|blast} a laser at {defender}.
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

  {damage == 0:
    <> There was not enough power in the {~laser|blast|engery beam} to affect {defender}.
  - else:
    <> Sensors indicate {damage} HEAT was delt to {defender}
  }
  ~ update_heat(defender, damage)
  -> DONE



== reactor
= move_forward (self)
//  So all the logic to move forwarD
{self} is moving forward
  // Make sure we have the power to spend.
  {get_value (self, POWER) <= 0:
    {self} attempted to increase speed, but did not have enough POWER.
    -> DONE
  }
  ~ update_value (self, POWER, -power_cost (Move, 1))
  
  ~ update_value (self, SPEED, 1)
  ~ update_value (self, DODGE, 10)
  
  {self} Increases reactor power, increasing speed by 1kpp. Speed is now {get_value (self, SPEED)}; Dodge is now {get_value (self, DODGE)}.
  -> DONE
