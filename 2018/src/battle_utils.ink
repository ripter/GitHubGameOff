== function min_zero(value)
{value < 0:
  ~ return 0
}
~ return value

== function is_in_volley (who)
  ~ return get_value (who, TURN_STATE) == VOLLEY

== fundion did_pass (who)
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
