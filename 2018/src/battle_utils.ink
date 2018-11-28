== function min_zero(value)
{value < 0:
  ~ return 0
}
~ return value

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
