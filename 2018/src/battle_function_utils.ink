

== function min_zero(value)
{value < 0:
  ~ return 0
}
~ return value



== function is_in_volley (who)
  ~ return get_value (who, TURN_STATE) == VOLLEY

== function did_pass (who)
  ~ return get_value (who, TURN_STATE) == PASS



// Decide who is faster, favoring the attacker.
== function get_fastest()
  {
  // Passing is slow
  - did_pass (mech_defender):
    ~ return mech_attacker
  - did_pass (mech_attacker):
    ~ return mech_defender
  // Power downed mechs are slow
  - get_value (mech_defender, POWER) <= 0:
    ~ return mech_attacker
  - get_value (mech_attacker, POWER) <= 0:
    ~ return mech_defender
  // Dodging mechs are moving faster.
  - get_value (mech_attacker, DODGE) > get_value (mech_defender, DODGE):
    ~ return mech_attacker
  - get_value (mech_defender, DODGE) > get_value (mech_attacker, DODGE):
    ~ return mech_defender
  // Random 50/50 chance
  - else:
    {coin_flip():
      ~ return mech_attacker
    }
    ~ return mech_defender
  }



== function can_afford (who, weapon, level)
  ~ temp canAffordPower = get_value (who, POWER) >= power_cost(weapon)
  ~ return canAffordPower
  

== function able_to_activate (who, action, level)
  {not can_afford (who, action, level):
    ~ return false
  }
  // Pay the Costs
  ~ update_value (who, POWER, -power_cost (action))
  ~ update_value (who, HEAT,  heat_cost (action, level))
  ~ return true


== function did_dodge (who)
  ~ temp chance = get_value (who, DODGE)
  {
  - chance <= 0:
    ~ return false
  - chance <= 10:
    ~ return did_chance_pass("{~win|||||||||}", "win")
  - chance <= 20:
    ~ return did_chance_pass("{~win|win||||||||}", "win")
  - chance <= 30:
    ~ return did_chance_pass("{~win|win|win|||||||}", "win")
  - chance <= 40:
    ~ return did_chance_pass("{~win|win|win|win||||||}", "win")
  - chance <= 50:
    ~ return did_chance_pass("{~win|win|win|win|win|||||}", "win")
  - chance <= 60:
    ~ return did_chance_pass("{~win|win|win|win|win|win||||}", "win")
  - chance <= 70:
    ~ return did_chance_pass("{~win|win|win|win|win|win|win|||}", "win")
  - chance <= 80:
    ~ return did_chance_pass("{~win|win|win|win|win|win|win|win||}", "win")
  - chance <= 90:
    ~ return did_chance_pass("{~win|win|win|win|win|win|win|win|win|}", "win")
  - else:
    ~ return true
  }
  ~ return false


// Energy weapons always deal damage as HEAT
== function deal_energy_damage (who, damage)
  ~ update_value (who, HEAT, damage)

// Physical weapons destroy parts of the opponent in a cascading order
== function deal_physical_damage (who, damage)
  ~ temp heatsinks = get_value (who, HEATSINKS)
  ~ temp damage_to_deal = damage

  {damage_to_deal <= heatsinks:
    ~ update_value (who, HEATSINKS, -damage_to_deal)
    ~ return
  - else:
    ~ damage_to_deal -= heatsinks
    ~ set_value (who, HEATSINKS, 0)
  }

  {damage_to_deal > 0:
    ~ update_value (who, HEAT, damage_to_deal)
  }

== function random_number_string()
  ~ return "{~10|20|30|40|50|60|70|80|90|100}"




== function coin_flip()
  ~ temp toss = "{~head|tail}"
  {toss == "head":
    ~ return true
  }
  ~ return false

== function chance_10()
  ~ return did_chance_pass ("{~win|lose|lose|lose|lose|lose|lose|lose|lose|lose}", "win")
== function chance_20()
  ~ return did_chance_pass("{~win|win||||||||}", "win")
== function chance_30()
  ~ return did_chance_pass("{~win|win|win|||||||}", "win")
== function chance_40()
  ~ return did_chance_pass("{~win|win|win|win||||||}", "win")

== function did_chance_pass(result, win)
  {result == win:
    ~return true
  }
  ~ return false
