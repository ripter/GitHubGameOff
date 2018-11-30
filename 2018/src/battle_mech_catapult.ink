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
  # title: Catapult (You)
  # template: message
  ~ temp power = get_value (Catapult, POWER)
  ~ temp heat = get_value (Catapult, HEAT)
  ~ temp weapons = get_value (Catapult, WEAPONS)
  ~ temp range = get_value (Catapult, RANGE)
  ~ temp dodge = get_value (Catapult, DODGE)

  {power == 0:
    ~ set_value (Catapult, TURN_STATE, PASS)
    ->->
  }

  You have <>
  <- mech_base.status_short (Catapult)
  <> Range is {get_value (Catapult, RANGE)}
  What action should you take?
  -> player_menu (target) ->
  -
  ->->

= player_menu (target)
  + [Fire Weapons]
    -> player_menu_weapons (target) ->
  + [Move and Dodge]
    -> player_menu_move (target) ->
  + [Scanners]
    -> player_menu_scanners (target) ->
  + [Pass until next turn]
    ~ set_value (Catapult, TURN_STATE, PASS)
  -
  ->->

= player_menu_weapons (target)
  ~ temp level = 1

  + {can_afford (Catapult, Laser, 1)} [Fire Laser! ({power_cost(Laser, 1)} PWR)]
    You fire a laser at {target} <>
    <- mech_base.fire_laser (Catapult, target)
  + {can_afford (Catapult, Missile, 1)} [Launch Missiles! ({power_cost(Missile, 1)} PWR)]
    You fire missiles at {target} <>
    <- mech_base.fire_missile (Catapult, target)
  + [Back]
    -> player_menu (target) ->
  -
  ->->

= player_menu_move (target)
  + [Evasive Maneuvers ({power_cost(Evasive_Maneuvers, 1)} PWR)]
    <- mech_base.evasive_maneuvers (Catapult)
  + [Run forward! ({power_cost(Move_Forward, 1)} PWR)]
    <- mech_base.charge_forward (Catapult)
  +  [Back away! ({power_cost(Move_Back, 1)} PWR)]
    <- mech_base.charge_backwards (Catapult)
  + [Back]
    -> player_menu (target) ->
  -
  ->->

= player_menu_scanners (target)
  + My Status
    <- mech_base.status (Catapult)
  + Opponent Status
    <- mech_base.status (target)
  + [Back]
  -
  -> player_menu (target) ->
  ->->
