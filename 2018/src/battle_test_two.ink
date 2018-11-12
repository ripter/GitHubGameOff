This battle features two mech fighting. {attacker} and {defender}.
-> start
-> END


== start

// Turn 1
<- mech_attempt_to_launch_missiles(defender, attacker, 2)
-> player_turn ->

// Turn 2
<- mech_turn_start(defender)
<- mech_turn_start(attacker)
-> mech_land_missiles(defender, attacker, 2) ->
{
- range == MEDIUM:
  Medium range
- range == LONG:
  <- mech_attempt_to_launch_missiles(defender, attacker, 2)
}
-> player_turn ->
Add more content
-> DONE


== player_turn
  ~ temp name = attacker
  ~ temp power = prop_power(name, 0)
  
  {name} has {power} power left. ({prop_power(name, 0)})
  
  + {power >= 5} Run foward, closing the range.
    -> mech_attempt_charge(name, 5) ->
    -> player_turn
  + {laser_possible(name, 1)} Fire Laser
    -> mech_attempt_fire_laser(name, defender, 1) ->
    -> player_turn
  + [Stats]
    POWER: {prop_power(name, 0)}
    HEAT: {prop_heat(name, 0)}
    -> player_turn
  + [End Turn]
    ->->

  
== mech_attempt_to_launch_missiles(from, to, racks)
  ~ temp racks_launched = missile_launch_start(from, racks)
  {from} launches <>
  {racks > 1: 
    {racks} racks of missiles <>
  - else:
    a missle rack <>
  }
  at {to}.
  -> DONE
== mech_land_missiles(from, to, racks)
  {racks * 5} missiles rain down on {to}.
  
  + {move_dodge_possible(to)} [{move_dodge_cost()} POWER: Attempt to dodge]
    -> mech_attempt_dodge(to, racks) ->
    ->->
  + [Brace for the missiles to hit]
  ->->

== mech_attempt_fire_laser(from, to, laser_count)
  {not laser_possible(from, laser_count):
    Attempts to fire a laser, but does not have enough power.
    -> DONE
  - else:
    ~ prop_power(from, -laser_fire_cost(laser_count))
  }
  Fire Cost: {laser_count}x {laser_fire_cost(laser_count)} POWER
  ~ temp damage = laser_damage(laser_count)
  ~ temp waste = laser_fire_waste(laser_count)
  ~ prop_heat(from, waste)
  ~ prop_heat(to, damage)

  {from} fires {laser_count} laser{laser_count > 1:s} at {range} range. Crimson flashes of light flash across the battle field. (actually that does not make sense, if you saw the flash of light it would be a terrable laser.)
  {to} gains {damage} HEAT from the blast.
  {from} gains {waste} HEAT as waste from the laser.
->->


== mech_attempt_charge(from, delta)
  ~ temp power = prop_power(from, 0)
  {power < 5:
    {from} attempted to charge, but lacks the power.
    ->->
  }
  
  ~ prop_power(from, -5)
  ~ temp old_range = range
  ~ move_range(delta)
  {from} {delta >= 5: quickly} charges {delta > 0: forward | away} <>
  
  {old_range != range:
   moving into {range} range.
  }
  ->->
== mech_attempt_dodge(name, racks)
  ~ temp power = prop_power(name, 0)
  ~ temp delta_power = -racks * move_dodge_cost()
  {not move_dodge_possible(name):
    Not enought POWER to dodge.
    ->->
  - else :
    ~ prop_power(name, -move_dodge_cost())
  }
  {name} manages to dodge the incomming attack.
  ->->

== mech_turn_start(who)
  ~ temp regen = prop_power_regen(who, 0)
  ~ temp heatsinks = prop_heatsinks(who, 0)
  ~ temp power = prop_power(who, 0)
  ~ temp heat = prop_heat(who, 0)
  ~ prop_power(who, regen)
  ~ prop_heat(who, -heatsinks)
  {who}'s reactor generated {regen} POWER, and  heatsinks removed {heatsinks} HEAT. Giving {who} a total POWER: {prop_power(who, 0)}, HEAT: {prop_heat(who, 0)} 
//   {who} has {heatsinks} heatsinks; and regenerates {regen} power per turn.
  -> DONE



//
// Combat functions
VAR attacker_missiles_in_air = 0
VAR defender_missiles_in_air = 0
== function missile_launch_start(name, racks)
  ~ temp power = prop_power(name, 0)
  // Power up the missiles
  {missile_launch_possible(power, racks):
    ~ prop_power(name, missile_launch_cost(racks))
  - else:
    ~ return 0
  }
  // Launch the missiles.
  {
  - name == attacker:
    ~ attacker_missiles_in_air += racks
    ~ return attacker_missiles_in_air
  - name == defender:
    ~ defender_missiles_in_air += racks
    ~ return defender_missiles_in_air
  }

== function missile_launch_possible(value, racks)
{value >= missile_launch_cost(racks):
  ~ return true
}
~ return false

== function missile_launch_cost(racks)
  ~ return -racks * 2
  
== function prop_missiles_in_air(name, delta)
{
- name == attacker:
  ~ attacker_missiles_in_air += delta
  ~ return attacker_missiles_in_air
- name == defender:
  ~ defender_missiles_in_air += delta
  ~ return defender_missiles_in_air
}

== function laser_possible(name, count)
  ~ return prop_power(name, 0) >= laser_fire_cost(count)
== function laser_fire_cost(count)
  ~ return count * 4
== function laser_fire_waste(count)
  ~ return laser_fire_cost(count) / 4
== function laser_damage(count)
  ~ temp base = laser_fire_cost(count)
  {
  - range == SHORT:
    ~ return base
  - range == MEDIUM:
    ~ return base / 2
  - range == LONG:
    ~ return base / 4
  }

//
// Movement Functions
LIST range = (LONG), MEDIUM, SHORT
VAR range_turn_delta = 0
== function move_range(delta)
  ~ range_turn_delta += delta
  {
  - range_turn_delta >= 5:
    ~ range++
    ~ range_turn_delta -= 5
  - range_turn_delta <= -5:
    ~ range--
    ~ range_turn_delta += 5
  }
== function move_reset_delta()
  ~ range_turn_delta = 0
== function move_dodge_possible(name)
  ~ return prop_power(name, 0) >= move_dodge_cost()
== function move_dodge_cost()
  ~ return 2

//
// Math Functions
== function min_zero(value)
{value < 0:
  ~ return 0
}
~ return value


//
// Mech Data
LIST MECHS = Catapult, Axman
// LIST WEAPONS = Laser, Missiles, Autocannon, Hatchet
VAR attacker = Axman
VAR attacker_power = 5
VAR attacker_power_regen = 5
VAR attacker_heat = 0
VAR attacker_heatsinks = 3

VAR defender = Catapult
VAR defender_power = 5
VAR defender_power_regen = 5
VAR defender_heat = 0
VAR defender_heatsinks = 3
== function prop_power(name, delta)
{
- name == attacker:
  ~ attacker_power += delta
  ~ return attacker_power
- name == defender:
  ~ defender_power += delta
  ~ return defender_power
}
== function prop_power_regen(name, delta)
{
- name == attacker:
  ~ attacker_power_regen += delta
  ~ return attacker_power_regen
- name == defender:
  ~ defender_power_regen += delta
  ~ return defender_power_regen
}
== function prop_heat(name, delta)
{
- name == attacker:
  ~ attacker_heat = min_zero(delta + attacker_heat)
  ~ return attacker_heat
- name == defender:
  ~ defender_heat += min_zero(delta + defender_heat)
  ~ return defender_heat
}
== function prop_heatsinks(name, delta)
{
- name == attacker:
  ~ attacker_heatsinks += delta
  ~ return attacker_heatsinks
- name == defender:
  ~ defender_heatsinks += delta
  ~ return defender_heatsinks
}

== function template(name, delta)
{
- name == attacker:

- name == defender:

}