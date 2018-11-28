== mech_catapult
  Mech Catapult {Catapult}
  -> DONE

= start
  // Load the catapult specific weapons
  ~ temp weapons = Missile
  ~ weapons += Laser
  ~ set_value (Catapult, WEAPON, weapons)
  -> DONE


= player_volley
  ~ temp power = get_value (Catapult, POWER)
  ~ temp weapons = get_value (Catapult, WEAPON)
  <- mech_base.status (Catapult)
  You have {power} POWER left.
  You have {weapons} weapons available.

  + {can_afford (Catapult, Laser, 1)} Fire Laser! ({power_cost(Laser, 1)} PWR)
    Pew Pew!
  + {can_afford (Catapult, Missile, 1)} Fire Missiles! ({power_cost(Missile, 1)} PWR)
    Boom Boom!
  + {can_afford (Catapult, EVASIVE_MANEUVERS, 1)} Evasive Maneuvers ({power_cost(EVASIVE_MANEUVERS, 1)} PWR)
    Zig Zag!
  + {can_afford (Catapult, CHARGE_FORWARD, 1)} Run forward! ({power_cost(CHARGE_FORWARD, 1)} PWR)
    Speed Dash!
  + {can_afford (Catapult, CHARGE_BACKWARD, 1)} Back away! ({power_cost(CHARGE_BACKWARD, 1)} PWR)
    Retreat!
  + Save the remaining {power} POWER for the next turn.
    ~ set_turn_state (Catapult, PASS)
  -
  ->->
