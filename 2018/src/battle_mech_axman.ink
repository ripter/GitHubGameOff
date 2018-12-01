== mech_axman
  Mech {Axman}
  -> DONE

= start
  -> DONE


= ai_simple (target)
  ~ temp level = 1
  ~ temp power = get_value (Axman, POWER)
  ~ temp range = get_value (Axman, RANGE)
  ~ temp isHurt = get_value (Axman, OVERHEAT) - 2 <= 0
  ~ temp canAffordLaser = can_afford (Axman, Laser, level)
  ~ temp canAffordPunch = can_afford (Axman, Punch, level)
  ~ temp canAffordCharge = can_afford (Axman, Move_Forward, level)
  ~ temp canAffordDodge = can_afford (Axman, Evasive_Maneuvers, level) and get_value (Axman, DODGE) <= 50
  ~ temp next_action = Laser

  {
  - range == Long:
    {coin_flip():
      ~ next_action = Move_Forward
    - else:
      // Use our dodge chance as the chance to dodge 🤣
      {canAffordDodge and did_dodge (Axman):
        ~ next_action = Evasive_Maneuvers
      - else:
        ~ next_action = Move_Forward
      }
    }
    
  - range == Medium:
    {
    - isHurt and canAffordDodge:
      ~ next_action = Evasive_Maneuvers
    - canAffordLaser:
      {coin_flip():
        ~ next_action = Laser
      - else:
        ~ next_action = Move_Forward
      }
    }
  - range == Melee:
    {
    - get_value (target, HEATSINKS) > 0:
      ~ next_action = Punch
    - isHurt:
      ~ next_action = Move_Back
    - else:
      {coin_flip():
        ~ next_action = Laser
      - else:
        ~ next_action = Punch
      }
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
  - next_action == Laser:
    <- mech_base.fire_laser (Axman, target)
  - next_action == Punch:
    <- mech_base.punch (Axman, target)
  - next_action == Evasive_Maneuvers:
    <- mech_base.evasive_maneuvers (Axman)
  - next_action == Move_Forward:
    <- mech_base.charge_forward (Axman)
  - next_action == Move_Back:
    <- mech_base.charge_backwards (Axman)
  }
  -
  ->->


= player_volley
  TODO: player controls axman
  ->->
