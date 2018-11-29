== mech_catapult
  Mech Catapult {Catapult}
  -> DONE

= start
  // Load the catapult specific weapons
  ~ temp weapons = Missile
  ~ weapons += Laser
  ~ set_value (Catapult, WEAPONS, weapons)
  -> DONE


= player_volley (target)
  ~ temp power = get_value (Catapult, POWER)
  ~ temp heat = get_value (Catapult, HEAT)
  ~ temp weapons = get_value (Catapult, WEAPONS)
  ~ temp range = get_value (Catapult, RANGE)
  ~ temp dodge = get_value (Catapult, DODGE)

  {power == 0:
    You have run out of power. You will regenerate POWER and dissipate HEAT next turn.
    ~ set_value (Catapult, TURN_STATE, PASS)
    ->->
  }

  What action should you take?
  You have <>
  <- mech_base.status_short (Catapult)

  + [Fire Weapons]
    -> player_menu_weapons (target) ->
  + {can_afford (Catapult, Evasive_Maneuvers, 1)} [Evasive Maneuvers ({power_cost(Evasive_Maneuvers, 1)} PWR)]
    <- mech_base.evasive_maneuvers (Catapult)
  + {can_afford (Catapult, Move_Forward, 1)} [Run forward! ({power_cost(Move_Forward, 1)} PWR)]
    <- mech_base.charge_forward (Catapult)
  + {can_afford (Catapult, Move_Back, 1)} [Back away! ({power_cost(Move_Back, 1)} PWR)]
    <- mech_base.charge_backwards (Catapult)
  + My Status
    <- mech_base.status (Catapult)
  + Opponent Status
    <- mech_base.status (target)
  + [Pass until next turn]
    ~ set_value (Catapult, TURN_STATE, PASS)
  -
  ->->

= player_menu_weapons (target)
  {can_afford (Catapult, Laser, 1):
    Lasers are Medium to Melee range weapons that deal direct HEAT damage to your opponent. They may also create some waste heat when fired.
    + [Fire Laser! ({power_cost(Laser, 1)} PWR)]
      <- mech_base.fire_laser (Catapult, target)
  }
  {can_afford (Catapult, Missile, 1):
    Missiles are a Long to Medium range weapon that deal physical damage, but have a low chance to hit.
    + [Fire Missiles! ({power_cost(Missile, 1)} PWR)]
      <- mech_base.fire_missile (Catapult, target)
  }
  -
  ->->
