LIST range = (LONG), MEDIUM, SHORT

VAR attacker_power = 10
VAR attacker_heat = 0

VAR defender_power = 10
VAR defender_heat = 0

-> battle_test_one.start ->
-> END

== battle_test_one
= start
  Battle Starts!
//   <- display_range
//   <- display_attacker_stats
//   <- display_defender_stats
//   <- display_stats("Axman", attacker_heat, attacker_power)
//   <- display_stats("Catapult", defender_heat, defender_power)
  <- display_turn
  
  The Catapult fires two racks of Missiles at the Axman. Each rack releasing five missiles.
  ~ defender_power -= 4
  ~ defender_heat += 2
  
  The Axman runs at full speed at the Catapult.
  ~ attacker_power -= 10
  ~ attacker_heat += 5
  
  
  * [Next Turn]
  -
  // Running at fill speed for a turn changes range.
  ~ range = range.MEDIUM
  <- display_turn
  
  The Catapult's reactor generates 5 power.
  ~ defender_power += 5
  The Catapult's heat sinks remove 3 heat.
  ~ defender_heat -= 3
  
  The Axman's reactor generates 5 power.
  ~ attacker_power += 5
  The Axman's heat sinks disipate 3 heat.
  ~ attacker_heat -= 3
  
  The Catapult's Missiles reach Axman. 
  Axman uses 2 power to avoid the first rack of Missiles.
  ~ attacker_power -= 2
  ~ attacker_heat += 1
  Axman uses 2 power to avoid the second rack of Missiles.
  ~ attacker_power -= 2
  ~ attacker_heat += 1
  
  Catapult fires the first medium laser at Axman. At this range the laser's power disipates a little before reaching the Axman. The laser hits causing 2 heat to generate on the Axman.
  ~ defender_power -= 2
  ~ defender_heat += 2
  ~ attacker_heat += 2
  
  Catapult fires the second medium laser at Axman. At this range the laser's power disipates a little before reaching the Axman. The laser hits causing 2 heat to generate on the Axman.
  ~ defender_power -= 2
  ~ defender_heat += 2
  ~ attacker_heat += 2
  
  Catapult fires the third medium laser at Axman. At this range the laser's power disipates a little before reaching the Axman. The laser hits causing 2 heat to generate on the Axman.
  ~ defender_power -= 2
  ~ defender_heat += 2
  ~ attacker_heat += 2
  
  Catapult fires the third medium laser at Axman. At this range the laser's power disipates a little before reaching the Axman. The laser hits causing 2 heat to generate on the Axman.
  ~ defender_power -= 2
  ~ defender_heat += 2
  ~ attacker_heat += 2
  
  * [Next Turn]
  -
  <- display_turn
  ->->
  
= display_turn
  <- display_range
  <- display_stats("Axman", attacker_heat, attacker_power)
  <- display_stats("Catapult", defender_heat, defender_power)
  -> DONE
  
= display_range
  The Mechs are at {range} range.
  -> DONE
  
= display_attacker_stats
  The attacker has {attacker_heat} Heat buildup and {attacker_power} power avialable.
  -> DONE
= display_defender_stats
  The attacker has {defender_heat} Heat buildup and {defender_power} power avialable.
  -> DONE
= display_stats(name, heat, power)
  {name} has {power} POWER avialable and {heat} HEAT buildup.
  -> DONE
  
