INCLUDE weapons.ink
INCLUDE function_weapons.ink
INCLUDE function_utils.ink
INCLUDE function_attributes.ink


LIST MECHS = IronWolf, Axman
LIST turn_states = Volley, Wait, GAMEOVER, PLAYING
VAR battle_state = PLAYING
VAR mech_attacker = IronWolf
VAR mech_attacker_turn_state = Volley
VAR mech_defender = Axman
VAR mech_defender_turn_state = Volley
VAR mech_overheat = 20

// Setup the mechs for battle
<- ironwolf.start
<- axman.start


VAR turn_count = 0
- (main_loop)
{battle_state == PLAYING:
  ~ turn_count += 1
  Loop Numner {turn_count}

  -> arena.turn_start ->

  -> arena.turn_volley ->

  {turn_count >= 5:
    ~ battle_state = GAMEOVER
  }

  // Check if we should loop again.
  {battle_state == PLAYING:
    -> main_loop
  }
}

-
Post Battle stuff goes here.





== arena
= turn_start
  // Recharge
  ~ mech_recharge(mech_attacker)
  ~ mech_recharge(mech_defender)
  // Reset turn mode
  ~ set_turn_state(mech_attacker, PLAYING)
  ~ set_turn_state(mech_defender, PLAYING)
  ->->
= turn_volley
  Starting Volley
  {get_fastest() == mech_attacker:
    // {IronWolf} is faster and gets to make the first move.
    {mech_attacker} is the first to make a move.
    -> ironwolf.pick_action ->
    -> axman.random_action ->
  - else:
    // {Axman} is quick and gets the first move.
    {mech_defender} is the first to make a move.
    -> axman.random_action ->
    -> ironwolf.pick_action ->
  }

  {is_gameover():
    ~ battle_state = GAMEOVER
    ->->
  }

  {get_turn_state (mech_defender) == GAMEOVER and get_turn_state (mech_attacker) == GAMEOVER:
    Both are done
  }
  Repeat for another volley
  -> turn_volley

= how_battle_works
  This is a one on one arena match between challenger {mech_attacker} and the defending {mech_defender}.
  <> Each mech is powered by a reactor that generates POWER each turn; and HEATSINKS that reduce HEAT each turn.
  <> The first mech to reach {mech_overheat} HEAT loses the battle.
  <> Firing weapons, moving, dodging, all cost POWER and generate some HEAT.
  ->->


== ironwolf
= start
  ~ mech_attacker = IronWolf
  ~ set_heat(IronWolf, 0)
  ~ set_power(IronWolf, 0)
  ~ set_heatsinks(IronWolf, 3)
  ~ set_power_regen(IronWolf, 5)
  ~ set_dodge(IronWolf, 10)
  ~ set_speed(IronWolf, 0)
  -> DONE
= status
  {IronWolf} {get_power(IronWolf)} POWER
  <>; {get_heat(IronWolf)} HEAT
  <>; {get_heatsinks(IronWolf)} HEATSINKS
  <>; {get_speed(IronWolf)} Kilometer per POWER
  -> DONE
= pick_action
  ~ temp currentPower = get_power(IronWolf)
  
  + {currentPower >= 4} [Fire Laser - {power_cost(Laser, 1)} POWER; {heat_cost(Laser, 1)} HEAT; 3-4 Damage]
    <- laser.fire(IronWolf, mech_defender)
  + [Wait]

  -
  ~ set_turn_state(IronWolf, Wait)
  ->->
= post_turn
  ~ set_turn_state(IronWolf, Wait)
  ->->
= upkeep
  ~ temp speed = get_speed(IronWolf)
  { speed <= 0:
    ->->
  }

  Continue current speed of {speed}kpp?
  + [Yes, Keep up speed]
    ~ mech_upkeep_speed(IronWolf, 1)
  + [No, cut speed]
    ~ mech_clear_speed(IronWolf)
  -
  ->->




== axman
= start
  ~ mech_defender = Axman
  ~ set_heat(Axman, 0)
  ~ set_power(Axman, 0)
  ~ set_heatsinks(Axman, 3)
  ~ set_power_regen(Axman, 5)
  ~ set_dodge(Axman, 10)
  ~ set_speed(Axman, 0)
  -> DONE
= status
  Axman: {get_heat(Axman)} HEAT, {get_power(Axman)} POWER
  -> DONE
= fire_laser
  <- laser.fire(Axman, IronWolf)
  ->->
= random_action
  <- laser.fire(Axman, IronWolf)
  -> post_turn ->
  ->->
= post_turn
  ~ set_turn_state(Axman, Wait)
  ->->


== function is_gameover()
  ~ return get_heat(mech_defender) >= mech_overheat or get_heat(mech_attacker) >= mech_overheat
== function can_continue_volley()
{
-  get_turn_state(mech_attacker) == GAMEOVER and get_turn_state(mech_defender) == GAMEOVER:
  ~ return false
}

== function get_fastest()
  {
  - get_power(mech_defender) <= 0:
    ~ return mech_attacker
  - get_power(mech_attacker) <= 0:
    ~ return mech_defender
//   - get_speed(mech_attacker) <= 0:
//     ~ return mech_attacker
//   - get_speed(mech_defender) <= 0:
//     ~ return mech_defender
  - else:
    ~ temp toss = "{~head|tail}"
    // Random Toss {toss}
    {toss == "head":
      ~ return mech_attacker
    }
    ~ return mech_defender
  }

== function mech_recharge(who)
  ~ update_power(who, get_power_regen(who))
  ~ update_heat(who, -get_heatsinks(who))

== function mech_change_speed(who, delta, level)
  ~ update_speed(who, delta)
  // range counts down to move forward, so flip the sign on delta
  ~ update_range(-1 * delta)
  // use a positive delta for cost calculations.
  {delta < 0:
    ~ delta = -1 * delta
  }
  ~ update_power(who, -delta * power_cost(Move, level))
== function mech_upkeep_speed(who, level)
  ~ temp delta = get_speed(who)
  ~ update_power(who, -delta * power_cost(Move, level))
== function mech_clear_speed(who)
  ~ set_speed(who, 0)

== function get_turn_state(who)
{
-  who == mech_attacker:
  ~ return mech_attacker_turn_state
- who == mech_defender:
  ~ return mech_defender_turn_state
}
== function set_turn_state(who, value)
{
-  who == mech_attacker:
  ~ mech_attacker_turn_state = value
  ~ return mech_attacker_turn_state
- who == mech_defender:
  ~ mech_defender_turn_state = value
  ~ return mech_defender_turn_state
}
