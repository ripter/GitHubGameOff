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
  ~ temp weapons = get_value (Catapult, WEAPONS)
  <- mech_base.status (Catapult)
  You have {power} POWER left.
  You have {weapons} weapons available.

  + {can_afford (Catapult, Laser, 1)} Fire Laser! ({power_cost(Laser, 1)} PWR)
    <- mech_base.fire_laser (Catapult, target)
  + {can_afford (Catapult, Missile, 1)} Fire Missiles! ({power_cost(Missile, 1)} PWR)
    <- mech_base.fire_missile (Catapult, target)
  + {can_afford (Catapult, Evasive_Maneuvers, 1)} Evasive Maneuvers ({power_cost(Evasive_Maneuvers, 1)} PWR)
    <- mech_base.evasive_maneuvers (Catapult)
  + {can_afford (Catapult, Move_Forward, 1)} Run forward! ({power_cost(Move_Forward, 1)} PWR)
    <- mech_base.charge_forward (Catapult)
  + {can_afford (Catapult, Move_Back, 1)} Back away! ({power_cost(Move_Back, 1)} PWR)
    <- mech_base.charge_backwards (Catapult)
  + Save the remaining {power} POWER for the next turn.
    ~ set_turn_state (Catapult, PASS)
  -
  ->->
