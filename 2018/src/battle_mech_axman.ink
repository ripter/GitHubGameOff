== mech_axman
  Mech {Axman}
  -> DONE

= start
  -> DONE


= ai_simple (target)
  ~ temp power = get_value (Axman, POWER)
  ~ temp range = get_value (Axman, RANGE)

  // Should we continue the volley or pass so we can recharge?
  // Pass if we can not fire a laser
  {not can_afford (Axman, Laser, 1):
    ~ set_turn_state(Axman, PASS)
    ->->
  }

  // Simple AI, move into Medium/Melee Range and fire lasers
  {
  - get_value (Axman, RANGE) == Melee:
    <- mech_base.punch (Axman, target)
  - get_value (Axman, RANGE) >= Medium:
    {power >= power_cost(CHARGE_FORWARD, 1):
      <- mech_base.charge_forward (Axman)
    }
  - else:
    {power > power_cost(Laser, 1):
      <- mech_base.fire_laser (Axman, target)
    }
  }
  ->->


= player_volley
  TODO: player controls axman
  ->->
