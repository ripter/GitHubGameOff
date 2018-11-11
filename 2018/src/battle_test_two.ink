This battle features two mech fighting. {attacker} and {defender}.
-> start
-> END

== start

// Turn 1


-> DONE



  
== fire_missiles(from, two, racks)

  -> DONE


//
// Player Data


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

== function power_change(name, delta)
{
- name == attacker:

- name == defender:

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
  

//
// Math Functions
== function min_zero(value)
{value < 0:
  ~ return 0
}
~ return value

