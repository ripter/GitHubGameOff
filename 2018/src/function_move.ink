

So this is a small test to try the battle range.
Right now we are at {range}
If I move forward, that is from longer to shorter. I need to add 5 to the range.

~ move_reset_delta()
~ move_range(2)
~ move_range(3)
If I add 2 + 3, then battle range becomes: {range} ({range_turn_delta}) It should be MEDIUM.

~ move_reset_delta()
~ range = LONG
~ move_range(5)
If I add 5, then battle range becomes: {range} ({range_turn_delta}) It should be MEDIUM.

~ move_reset_delta()
~ range = LONG
~ move_range(10)
Move +10 {range} should equal LONG when range is long.
// If I add 10, then battle range becomes: {range} ({range_turn_delta}) It should be LONG.

~ move_reset_delta()
~ range = SHORT
~ move_range(-2)
~ move_range(-3)
Move -2, then Move -3 in the same turn, {range} should equal MEDIUM when starting at short range.
// If I remove 2 - 3, then battle range becomes: {range} ({range_turn_delta})

~ move_reset_delta()
~ range = SHORT
~ move_range(-5)
Move -5, {range} should equal MEDIUM when starting at a short range.
// If I remove 5, then battle range becomes: {range} ({range_turn_delta})

~ move_reset_delta()
~ range = SHORT
~ move_range(-10)
Move -10, {range} should equal LONG when starting at a short range.
// If I remove 3, then battle range becomes: {range} ({range_turn_delta})


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
