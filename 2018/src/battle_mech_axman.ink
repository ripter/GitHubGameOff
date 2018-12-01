== mech_axman
  Mech {Axman}
  -> DONE

= start
  -> DONE


= ai_simple (target)
  ~ temp level = 1
  ~ temp power = get_value (Axman, POWER)
  ~ temp range = get_value (Axman, RANGE)
  ~ temp isHurt = get_value (Axman, OVERHEAT) / get_value (Axman, HEAT) <= 2
  ~ temp canAffordLaser = can_afford (Axman, Laser, level)
  ~ temp canAffordPunch = can_afford (Axman, Punch, level)
  ~ temp canAffordCharge = can_afford (Axman, Move_Forward, level)
  ~ temp canAffordDodge = can_afford (Axman, Evasive_Maneuvers, level) and get_value (Axman, DODGE) <= 50
  ~ temp next_action = Punch

  // If we can not use our Ax
  {
  - range == Long:
    {canAffordCharge:
      ~ next_action = Move_Forward
    - else:
      ~ next_action = Evasive_Maneuvers
    }
  - range == Medium:
    {
    - isHurt and canAffordDodge:
      ~ next_action = Evasive_Maneuvers
    - not isHurt and canAffordCharge:
      ~ next_action = Move_Forward
    - canAffordLaser:
      ~ next_action = Laser
    }
  - range == Melee:
    {
    - not isHurt and canAffordLaser and get_value (target, HEATSINKS) == 0:
      ~ next_action = Laser
    - isHurt and canAffordCharge:
      ~ next_action = Move_Back
    - else:
      next_action = Punch
    }
  }

  // Pass if we can not afford the action.
  {not can_afford (Axman, next_action, level):
    ~ set_turn_state(Axman, PASS)
    Axman is passing until the next round.
    ->->
  }

  // perform the action
  {
  - next_action == Punch:
    <- mech_base.punch (Axman, target)
  - next_action == Laser:
    <- mech_base.fire_laser (Axman, target)
  - next_action == Move_Forward:
    <- mech_base.charge_forward (Axman)
  }
  -
  ->->


= player_volley
  TODO: player controls axman
  ->->
