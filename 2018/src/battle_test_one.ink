LIST range = (LONG), MEDIUM, SHORT

VAR attacker = "Axman"
VAR attacker_power = 10
VAR attacker_power_regen = 5
VAR attacker_heat = 0
VAR attacker_heat_dissipate = 3

VAR defender = "Catapult"
VAR defender_power = 10
VAR defender_power_regen = 5
VAR defender_heat = 0
VAR defender_heat_dissipate = 3


-> battle_test_one.start ->
-> END

== battle_test_one
= start
  Two mechs, the challenger, an {attacker} and the defender, a {defender} stand across the battle arena from each other. Each Mech standing 10 meters tall and weighing 65 tons. The buzzer rings over the battle channel, starting the battle.
  The Axman's signature move is it's Hatcet for a left hand. 
  The Catapult's signature move it's the two missile racks mounded on it's shoulders.
  <- display_turn
  
  <- fire_lrm(defender, defender_power, defender_heat)
  <- run_full_speed(attacker, attacker_power, attacker_heat)
  * [Next Turn]
  - <- turn_post
  ~ range = MEDIUM
  
  <- display_turn
  
  The first rack of 5 missiles land. <>
  <- attempt_dodge(attacker, attacker_power, attacker_heat)
  
  
  * [Next Turn]
  - <- turn_post
  <- display_turn
  -> DONE
  

= display_turn
  \---
  The Mechs have moved into {range} range.
  <- display_stats("Axman", attacker_power, attacker_heat)
  <- display_stats("Catapult", defender_power, defender_heat)
  \---
  -> DONE
  
= turn_post
  <- recharge("Catapult", defender_power, defender_power_regen, defender_heat, defender_heat_dissipate)
  <- recharge("Axman", attacker_power, attacker_power_regen, attacker_heat, attacker_heat_dissipate)
  
  -> DONE
  
= display_stats(name, power, heat)
  {name} Status: POWER: {power}; HEAT {heat}
  -> DONE

= recharge(name, ref power, ref power_regen, ref heat, ref heat_dissipate)
  {name}'s reactor regenerated {power_regen} POWER. It's heat sinks dissipated {heat_dissipate} HEAT.
  ~ power += power_regen
  ~ heat -= heat_dissipate
  
  <- cap_stats(power, 10, heat)
  -> DONE
  
= fire_lrm(name, ref power, ref heat)
  {name} fires a rack of long range missiles. The missile streak into the air and lock on their target. They will hit on the next turn.
  ~ power -= 2
  ~ heat += 1
  -> DONE


= run_full_speed(name, ref power, ref heat)
  {name} runs at full speed.
  ~ power -= 10
  ~ heat += 5
  -> DONE
= attempt_dodge(name, ref power, ref heat)
  {name} attempts to doge,
  {power >= 2:
    <> using 2 POWER.
    ~ power -= 2
  - else:
    but does not have enough POWER.
  }
  
  The doge is successful.
  {name} stumbles and just is not quite fast enough. The attack hits.
  -> DONE
  
= cap_stats(ref power, max_power, ref heat)
  {power > max_power:
    ~ power = max_power
  }
  {heat < 0:
    ~ heat = 0
  }
  -> DONE




  
  
= start_draft_one
  Battle Starts!
//   <- display_range
//   <- display_attacker_stats
//   <- display_defender_stats
//   <- display_stats("Axman", attacker_heat, attacker_power)
//   <- display_stats("Catapult", defender_heat, defender_power)
  <- display_turn_draft_one
  
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
  
  

  

= display_range
  The Mechs are at {range} range.
  -> DONE
  
= display_attacker_stats
  The attacker has {attacker_heat} Heat buildup and {attacker_power} power avialable.
  -> DONE
= display_defender_stats
  The attacker has {defender_heat} Heat buildup and {defender_power} power avialable.
  -> DONE

= display_turn_draft_one
  <- display_range
  <- display_stats_draft_one("Axman", attacker_heat, attacker_power)
  <- display_stats_draft_one("Catapult", defender_heat, defender_power)
  -> DONE
= display_stats_draft_one(name, heat, power)
  {name} has {power} POWER avialable and {heat} HEAT buildup.
  -> DONE
  
  
