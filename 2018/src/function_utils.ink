== function min_zero(value)
{value < 0:
  ~ return 0
}
~ return value

== function random_number_string()
  ~ return "{~10|20|30|40|50|60|70|80|90|100}"

== function bonus_small()
  ~ temp rnd = "{~win|lose|lose|lose}"
  {rnd == "win":
    ~ return 1
  }
  ~ return 0
  