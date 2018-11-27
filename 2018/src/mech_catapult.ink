== mech_catapult
  Mech Catapult {Catapult}
  -> DONE

= start
  // Load the catapult specific weapons
  ~ temp weapons = Missile
  ~ weapons += Laser
  Catapult custom setup finished.
  Weapons {weapons} loaded.
  -> DONE


= player_volley
  <- mech_base.status (Catapult)
  -> DONE
