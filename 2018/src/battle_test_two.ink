This battle features two mech fighting. {attacker} and {defender}.
-> start
-> END

== start

// Turn 1
<- mech_attempt_to_launch_missiles(defender, attacker, 2)

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
  + [End Turn]
    ->->

  
== mech_attempt_to_launch_missiles(from, to, racks)
~ temp racks_launched = missile_launch_start(from, racks)
{from} launches <>
{racks > 1: 
  {racks_launched} racks of missiles <>
- else:
  a missle rack <>
}
at {to}.
-> DONE

== mech_attempt_fire_laser(from, to, laser_count)
  {not laser_possible(from, laser_count):
    Attempts to fire a laser, but does not have enough power.
    -> DONE
  }
  {from} fires {laser_count} lasers at {to}. Crimson flashes of light flash across the battle field. (actually that does not make sense, if you saw the flash of light it would be a terrable laser.)
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

== function laser_possible(name, laser_count)
  ~ return prop_power(name, 0) >= laser_count * 4


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
LIST WEAPONS = Laser, Missiles, Autocannon, Hatchet
VAR attacker = Axman
VAR attacker_power = 5
VAR attacker_heatsinks = 6

VAR defender = Catapult
VAR defender_power = 5
VAR defender_heatsinks = 6
== function prop_power(name, delta)
{
- name == attacker:
  ~ attacker_power += delta
  ~ return attacker_power
- name == defender:
  ~ defender_power += delta
  ~ return defender_power
}

== function template(name, delta)
{
- name == attacker:

- name == defender:

}