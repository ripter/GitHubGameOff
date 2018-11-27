== mech_axman
  Mech {Axman}
  -> DONE

= start
  -> DONE


= ai_simple (target)
  ~ temp power = get_value (Axman, POWER)

  {power < power_cost(Laser, 1):
    ~ set_turn_state(Axman, PASS)
  }

  // Simple AI, move into Medium/Melee Range and fire lasers
  {get_value (Axman, RANGE) >= Medium:
    {power >= power_cost(CHARGE_FORWARD, 1):
      Charge Forward!
    }
  - else:
    {power > power_cost(Laser, 1):
      AI Simple: Fire Laser!!
      <- mech_base.fire_laser (Axman, target)
    }
  }

  ->->


= player_volley
  TODO: player controls axman
  ->->
