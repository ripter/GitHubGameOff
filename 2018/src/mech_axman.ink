== mech_axman
  Mech {Axman}
  -> DONE

= start
  -> DONE


= ai_simple (target)
 ~ temp power = get_value (Axman, POWER)

 {power > power_cost(Laser, 1):
   <- mech_base.fire_laser (Axman, target)
 }
 ->->


= player_volley
  TODO: player controls axman
  ->->
