== mech_axman
  Mech {Axman}
  -> DONE

= start
  -> DONE


= ai_simple (target)
  ~ temp level = 1
  ~ temp power = get_value (Axman, POWER)
  ~ temp range = get_value (Axman, RANGE)
  ~ temp next_action = Punch

  // If we can not use our Ax
  {
  - range == Long:
    ~ next_action = CHARGE_FORWARD
  - range == Medium:
    {coin_flip():
      ~ next_action = Laser
    - else:
      ~ next_action = CHARGE_FORWARD
    }
  }

  // Pass if we can not afford the action.
  {not can_afford (Axman, next_action, level):
    ~ set_turn_state(Axman, PASS)
    ->->
  }

  // perform the action
  {
  - next_action == Punch:
    <- mech_base.punch (Axman, target)
  - next_action == Laser:
    <- mech_base.fire_laser (Axman, target)
  - next_action == CHARGE_FORWARD:
    <- mech_base.charge_forward (Axman)
  }
  ->->


= player_volley
  TODO: player controls axman
  ->->
