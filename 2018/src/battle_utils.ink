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
    ~ temp toss = "{~head|tail}"
    // Random Toss {toss}
    {toss == "head":
      ~ return mech_attacker
    }
    ~ return mech_defender
  }



== function can_afford (who, weapon, level)
  ~ return get_value (who, POWER) >= power_cost(weapon, level)

== function able_to_activate (who, action, level)
  {not can_afford (who, action, level):
    ~ return false
  }
  ~ update_value (who, POWER, -power_cost (action, level))
  ~ return true


== function did_dodge(chance)
  {
  - chance <= 0:
    ~ return false
  - chance <= 10:
    ~ return chance_10()
  - chance <= 20:
    ~ return chance_20()
  - chance <= 30:
    ~ return "{~miss|miss|miss|hit|hit}" == "miss"
  - chance <= 40:
    ~ return "{~miss|miss|miss|miss|hit}" == "miss"
  - chance <= 50:
    ~ return "{~miss|miss|miss|miss|miss|hit|hit|hit|hit|hit}" == "miss"
  - chance <= 60:
    ~ return "{~miss|miss|miss|miss|miss|miss|hit|hit|hit|hit}" == "miss"
  - chance <= 70:
    ~ return "{~miss|miss|miss|miss|miss|miss|miss|hit|hit|hit}" == "miss"
  - chance <= 80:
    ~ return "{~miss|miss|miss|miss|miss|miss|miss|miss|hit|hit}" == "miss"
  - chance <= 90:
    ~ return "{~miss|miss|miss|miss|miss|miss|miss|miss|miss|hit}" == "miss"
  - else:
    ~ return "miss" == "miss"
  }
  ~ return false


== function random_number_string()
  ~ return "{~10|20|30|40|50|60|70|80|90|100}"

== function bonus_small()
  {chance_10():
    Bonus damage +1
    ~ return 1
  }
  ~ return 0

== function did_chance_pass(result, win)
  {result == win:
    ~return true
  }
  ~ return false

== function chance_10()
  ~ return did_chance_pass ("{~win|lose|lose|lose|lose|lose|lose|lose|lose|lose}", "win")
== function chance_20()
  ~ return did_chance_pass("{~win|win||||||||}", "win")
