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
  The Challenger: {attacker} is a 12 meter tall bipedial machine of war. This man shaped mech, weighing in at 65 tons, weilds a hatchet for a left hand! A devistating melee attack. His other hand features three medium lasers, and he has a special surprise hidden in the chest, an autocannon.
  The Defender: {defender} is a 9 meter tall bipedial machine of war. Some would say this armless mech looks more like a bird. It has a missile rack on each shoulder instead of arms. It has four medum lasers mounted in long nose or beak of the mech.
  
  // Turn 1
  <- display_turn
  <- fire_lrm(defender)
  <- fire_lrm(defender)
  <- run_full_speed_draft_one(attacker, attacker_power, attacker_heat)
 
  * [Next Turn]
  - <- turn_post
  
  
  // Turn 2
  ~ range = MEDIUM
  <- display_turn
  
  The first rack of 5 missiles land. <>
  <- attempt_dodge(attacker)
//   {attacker}'s power is down to {get_power(attacker)} power, and has {get_heatsinks(attacker)} heatsinks left.
  The second rack of 5 missiles land. <>
  <- attempt_dodge(attacker)
  {attacker}'s power is down to {get_power(attacker)} power, and has {get_heatsinks(attacker)} heatsinks left.
  
  The Axman conserves his remaning power.
  
  {defender} reloads both missile racks.
  ~ update_power(defender, -2)
  <> it has {get_power(defender)} power.
  <- fire_many_medium_lasers(defender, attacker, 2)
//   <- fire_medium_laser(defender, attacker)
//   <- fire_medium_laser(defender, attacker)
//   <- fire_medium_laser(defender, attacker)
//   <- fire_medium_laser(defender, attacker)
  
  * [Next Turn]
  - <- turn_post
  
  
  // Turn 3
  <- display_turn
  
  <- charge_forward(attacker)
  
  <- fire_medium_laser(defender, attacker)
//   <- fire_many_medium_lasers(defender, attacker, 1)
//   POWER of {defender} {get_power(defender)}
  
  * [Next Turn]
  - <- turn_post
  
  
  // Turn 4
  <- display_turn
  
  {attacker} swings his mighty hatchet at {defender}, slicing off a missile rack.
  ~ update_power(attacker, 3)
  ~ update_heat(attacker, 2)
  ~ update_heatsinks(defender, -1)
  
  <- charge_back(defender)
  
  <- fire_many_medium_lasers(attacker, defender, 2)
  {get_heat(attacker) >= 10:
    {attacker} is overheating at {get_heat(attacker)} HEAT and unable to move next turn.
  }
  
  * [Next Turn]
  - <- turn_post
  
  // Turn 5
  <- display_turn
  
  
  
  
  
  * [Next Turn]
  - <- turn_post 
  <- display_turn
  -> DONE
  
  
= display_turn
  \--- Turn {TURNS_SINCE(-> start)+1} ---
  The Mechs have moved into {range} range.
  <- display_stats("Axman", attacker_power, attacker_heat)
  <- display_stats("Catapult", defender_power, defender_heat)
  -> DONE
  
= turn_post
  <- recharge(attacker)
  <- recharge(defender)
  -> DONE
  
= turn_post_draft_one
  <- recharge_draft_one("Catapult", defender_power, defender_power_regen, defender_heat, defender_heat_dissipate)
  <- recharge_draft_one("Axman", attacker_power, attacker_power_regen, attacker_heat, attacker_heat_dissipate)
  
  -> DONE
  
= display_stats(name, power, heat)
  {name} Status: POWER: {power}; HEAT {heat}
  -> DONE

= recharge(name)
  ~ temp added_power = 0
  ~ temp removed_heat = 0
  // get the right numbers based on name
  {
  - name == attacker:
    ~ added_power = attacker_power_regen
    ~ removed_heat = attacker_heat_dissipate
  - name == defender:
    ~ added_power = defender_power_regen
    ~ removed_heat = defender_heat_dissipate
  }
  // Update based on name.
  ~ update_power(name, added_power)
  ~ update_heat(name, -removed_heat)
  {name}'s {~fusion reactor|reactor|generator} added {added_power} POWER while the heat sinks dissipated {removed_heat} HEAT.
  -> DONE
= recharge_draft_one(name, ref power, ref power_regen, ref heat, ref heat_dissipate)
  {name}'s reactor regenerated {power_regen} POWER. It's heat sinks dissipated {heat_dissipate} HEAT.
  ~ power += power_regen
  ~ heat -= heat_dissipate
  
  <- cap_stats(power, 10, heat)
  -> DONE
  
= fire_lrm(name)
  ~ update_power(name, -2)
  ~ update_heat(name, 1)
  {name} fires a rack of long range missiles. Five missiles streak into the air, quickly locking on their target and reaching {MEDIUM} range. 
//   and lock on their target. They will hit on the next turn.
  -> DONE
= fire_many_medium_lasers(from, to, laser_count)
  {get_power(from) < 4 * laser_count:
    {from} attempts to fire {laser_count} lasers, but does not have enough power.
    -> DONE
  }
  ~ update_power(from, -4 * laser_count)
  ~ update_heat(from, 2 * laser_count)
  ~ temp total_heat = 0 
  {
  - range == SHORT:
    ~ total_heat = 4 * laser_count
  - range == MEDIUM:
    ~ total_heat = 2 * laser_count
  - range == LONG:
    ~ total_heat = laser_count
  }
  ~ update_heat(to, total_heat)
  {from} Opens up with {laser_count} lasers. A blinding flash of red and white light flash across the battlefield strikeing {to} for {total_heat} HEAT damage.
  -> DONE
= fire_medium_laser(from, to)
  {get_power(from) < 4:
    {from} attempts to fire a medium laser, but does not have enough power.
    -> DONE
  }
  ~ update_power(from, -4)
  ~ update_heat(from, 2)
  A bright flash of red light streaks across the battlefield as {from} fires a medium laser at {to}.
  {
  - range == SHORT:
    ~ update_heat(to, 4)
    <> The laser deals 4 HEAT damage to {to}.
  - range == MEDIUM:
    ~ update_heat(to, 2)
    <> The laser deals 2 HEAT damage to {to}.
  - range == LONG:
    ~ update_heat(to, 1)
    <> The laser deals 1 HEAT damage to {to}.
  }
  -> DONE


= charge_forward(name)
  {get_power(name) < 5:
    {name} pushes the throddle forward, but lacks the power.
    -> DONE
  }
  ~ update_power(name, -5)
  ~ range++
  {name} charges forward at full speed, closing the distance between the fighters.
  -> DONE
= charge_back(name)
  {get_power(name) < 5:
    {name} pushes the throddle forward, but lacks the power.
    -> DONE
  }
  ~ update_power(name, -5)
  ~ range--
  {name} rushes to get some distance.
  -> DONE
= attempt_dodge(name)
  ~ temp power = get_power(name)
  ~ temp result = "{~dodge|hit}"
  
  {
  - power >= 2:
    ~ update_power(name, -2)
    {attacker} attempts to dodge.
    
    {result == "dodge":
      Moving quickly, {name} is able to dodge out of the way of the incomming missiles.
    - else: 
      ~ update_heatsinks(name, -1)
      {name} tried to zig instead of zag and was hit by a missile. The inpact detroyed a heatsink.
    }
  - else:
    {name}'s reactor can not generate power fast enough. Unable to dodge, missiles rain down, destorying 2 heat sinks.
    ~ update_heatsinks(name, -2)
  }
  -> DONE
  
= run_full_speed_draft_one(name, ref power, ref heat)
  {name} runs at full speed.
  ~ update_power(name, -10)
  ~ update_heat(name, 5)
  -> DONE
= attempt_dodge_draft_two(name)  
  ~ temp power = get_power(name)
  ~ temp result = "{~dodge|hit}"
  {result == "dodge":
    ~ update_power(name, -2)
    <> manages to zig zags as missiles rain around in an impotent fury.
     
  - else:
    ~ update_heatsinks(name, -1)
    {power < 2:
      <>'s reactor has already maxed out. Unable to meet power demands, {attacker} is unable to dodge as the missiles rain down.
    - else:
      ~ update_power(name, -2)
      <> attempts to dodge, but is not fast enough. Several missiles strike, destorying a heat sink.
    }
  }
  -> DONE
= attempt_dodge_draft_one(name, ref power)
  ~ temp hit_result = "{~hit|miss}"
  {name} attempts to doge,
  {power >= 2:
    <> using 2 POWER.
    ~ power -= 2
  - else:
    but does not have enough POWER.
    ~ hit_result = "hit"
  }
  
  {hit_result == "miss":
    {name} manages to doge the attack.
  - else:
    {name} attempts to dodge, but is too slow.
  }
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
  
//   Two mechs, the challenger, an {attacker} and the defender, a {defender} stand across the battle arena from each other. Each Mech standing 10 meters tall and weighing 65 tons. The buzzer rings over the battle channel, starting the battle.
//   The Axman's signature move is it's Hatcet for a left hand. 
//   The Catapult's signature move it's the two missile racks mounded on it's shoulders.  
//   The third rack of 5 missiles land. <>
//   <- attempt_dodge(attacker)
//   {attacker}'s power is down to {get_power(attacker)}, and has {get_heatsinks(attacker)} heatsinks left.
//   The fourth rack of 5 missiles land. <>
//   <- attempt_dodge(attacker)
//   {attacker}'s power is down to {get_power(attacker)}, and has {get_heatsinks(attacker)} heatsinks left.

  
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
  
 
 
// Functions Down below! 
== function get_power(name)
{
  - name == attacker:
    ~ return attacker_power
  - name == defender:
    ~ return defender_power
}
== function get_heat(name)
{
- name == attacker:
  ~ return attacker_heat
- name == defender:
  ~ return defender_heat
}
== function get_heatsinks(name)
{
- name == attacker:
  ~ return attacker_heat_dissipate
- name == defender:
  ~ return defender_heat_dissipate
}
 
== function update_power(name, delta)
{
- name == attacker:
//   ~ attacker_power = min_zero(delta + attacker_power)
  ~ attacker_power += delta
  ~ return attacker_power
- name == defender:
//   ~ defender_power = min_zero(delta + defender_power)
  ~ defender_power += delta
  ~ return defender_power
}

== function update_heat(name, delta)
{
- name == attacker:
  ~ attacker_heat = min_zero(delta + attacker_heat)
  ~ return attacker_heat
- name == defender:
  ~ defender_heat = min_zero(delta + defender_heat)
  ~ return defender_heat
}
== function update_heatsinks(name, delta)
{
- name == attacker:
  ~ attacker_heat_dissipate = min_zero(delta + attacker_heat_dissipate)
  ~ return attacker_heat_dissipate
- name == defender:
  ~ defender_heat_dissipate = min_zero(delta + defender_heat_dissipate)
  ~ return defender_heat_dissipate
}

== function min_zero(value)
{value < 0:
  ~ return 0
}
~ return value

== function max(value, ref max_value)
{value > max_value:
  ~ return max_value
}
~ return value

  
== function did_dodge_draft_one(ref power)
  // 2 POWER required to dodge missiles.
  {power <= 2:
    ~ return false
  }
  
  ~ temp hit_result = "{~hit|miss}"
  
  {hit_result == "miss":
    ~ return true
  }
  ~ return false