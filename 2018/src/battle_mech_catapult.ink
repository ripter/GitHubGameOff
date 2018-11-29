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
//    You have run out of power. You will regenerate POWER and dissipate HEAT next turn.
    ~ set_value (Catapult, TURN_STATE, PASS)
    ->->
  }

  # speaker: player
  You have <>
  <- mech_base.status_short (Catapult)
  # speaker: player
  What action should you take?

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
  {can_afford (Catapult, Laser, 1):
    Lasers are Medium to Melee range weapons that deal direct HEAT damage to your opponent. They may also create some waste heat when fired.
    <> Costs {power_cost(Laser, 1)} POWER and {heat_cost(Laser, 1)} HEAT to fire.
    <> Deals {heat_damage(Laser, 1)} HEAT to opponent.
    + [Fire Laser! ({power_cost(Laser, 1)} PWR)]
      <- mech_base.fire_laser (Catapult, target)
  }
  {can_afford (Catapult, Missile, 1):
    Missiles are a Long to Medium range weapon that deal physical damage, but have a low chance to hit.
    <> Costs {power_cost(Missile, 1)} POWER to fire.
    <> Destroys {heatsink_damage(Missile, 1)} HEATSINK
    + [Fire Missiles! ({power_cost(Missile, 1)} PWR)]
      <- mech_base.fire_missile (Catapult, target)
  }
  -
  ->->

= player_menu_move (target)
  {can_afford (Catapult, Evasive_Maneuvers, 1):
    Evasive Maneuvers: Move in random patterns that make it harder for the opponent to target you.
    <> Costs {power_cost(Evasive_Maneuvers, 1)} POWER.
    <> Adds +25% Dodge until the next turn.
    + [Evasive Maneuvers ({power_cost(Evasive_Maneuvers, 1)} PWR)]
      <- mech_base.evasive_maneuvers (Catapult)
  }
  {can_afford (Catapult, Move_Forward, 1):
    Run forward: Quickly charge at your opponent to reduce the range.
    <> Costs {power_cost(Move_Forward, 1)} POWER
    <> Reduces Range by 1, adds 10% dodge.
    + [Run forward! ({power_cost(Move_Forward, 1)} PWR)]
      <- mech_base.charge_forward (Catapult)
  }
  {can_afford (Catapult, Move_Back, 1):
    Run backwards: Quickly back up to increase distance between you and your opponent.
    <> Costs {power_cost(Move_Forward, 1)} POWER
    <> Increase Range by 1, adds 10% dodge.
    +  [Back away! ({power_cost(Move_Back, 1)} PWR)]
      <- mech_base.charge_backwards (Catapult)
  }
  -
  ->->

== player_menu_scanners (target)
  + My Status
    <- mech_base.status (Catapult)
  + Opponent Status
    <- mech_base.status (target)
  -
  ->->
