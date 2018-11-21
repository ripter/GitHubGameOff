// NaNoWriMo says we do not delete things once written. Great for the story, sucks for programming.
// defunt code that can be deleted after NaNoWriMo
// I am going to pick some random numbers to see if my function works. {random_numner()}, {random_numner()}, oh and {random_numner()} we should never forget {random_numner()}.
// But what we want to know the most, is if we can compare with a number: {random_numner() > 10: Grater than 10! Oh my!}
// Because the random numbers did not work, now I am going back to the string method I tested in battle_test_one.
// At 10% {did_dodge(10, 1)}, 20% {did_dodge(20, 1)}, 30% {did_dodge(30, 1)}, 40% {did_dodge(40, 1)}, 50% {did_dodge(50, 1)}, 60% {did_dodge(60, 1)}, 70% {did_dodge(70, 1)}, 80% {did_dodge(80, 1)}, 90% {did_dodge(90, 1)}, 100% {did_dodge(100, 1)}
//   {who} had {get_power(who)} POWER, and regenerated {get_power_regen(who)} POWER.
//   <> {who} now has {get_power(who)} POWER.
//   ~ update_power(Axman, -4)
//   ~ update_heat(Axman, 2)
//   ~ update_heat(IronWolf, 4)
//   + {currentPower >= 1} [Fire Missile!]
//     You fired some missiles! Whoosh Boom!
//     -> pick_action
//   + {currentPower >= 2} [Dodge!]
//     That was a close one, but you managed to doge!
//     -> pick_action
//   + {currentPower >= 5} [Move Closer!]
//     You run ahead, trying to get in range.
//     -> pick_action
//   + {currentPower >= 5} [Move Away!]
//     You back up, trying to put some distance between the two of you.
//     -> pick_action
// ~ update_power(IronWolf, -4)
// ~ update_heat(IronWolf, 2)
// You fired a laser! Pew Pew!
// Now {mech_defender} gets a chance to attack.
// // -> battle_test_three.pick_action ->
// Wow, such action. maybe you could pick another?
// // -> battle_test_three.pick_action ->
// And again to show that the menu keep continuing.
// ~ update_speed(IronWolf, -1)
// ~ update_power(IronWolf, -1)
// ~ update_speed(IronWolf, 1)
// ~ update_power(IronWolf, -1)
//   {~Challenger|} {mech_attacker}
//   {mech_attacker} faces off against {mech_defender} at {get_range()} range.

  // ~ state_attacker = get_turn_state(mech_attacker)
  // ~ state_defender = get_turn_state(mech_defender)
  // {state_attacker == GAMEOVER || state_defender == GAMEOVER:
  //   Battle Over!
  //   ->->
  // - else:
  //   -> battle_hub ->
  // }

  // {
  // - get_turn_state(mech_attacker) == ATTACKING && get_turn_state(mech_defender) == ATTACKING:
  //   Next Turn! Random order
  // - get_turn_state(mech_attacker) == ATTACKING && get_turn_state(mech_defender) != ATTACKING:
  //   Just Attacker Turn!
  // - get_turn_state(mech_attacker) != ATTACKING && get_turn_state(mech_defender) == ATTACKING:
  //   Just Defender Turn!
  // }

  // {get_power(IronWolf) > 0:
  //   -> ironwolf.pick_action ->
  // }
  //
  // -> axman.fire_laser ->
  //

//   {
// //  - state_attacker == Volley && state_defender == Volley:
//  //   Alternate turns.
//   - state_attacker == Volley:
//     // Player Attack!
//     -> ironwolf.pick_action -> turn_loop
//   - state_defender == Volley:
//     // Defender Attack!
//     -> axman.random_action -> turn_loop
//   - else:
//     No one can attack
//   }

  // Check for losing condition
//   {
//   - get_heat(mech_defender) >= mech_overheat:
//     Defender loses!
//     ->->
//   - get_heat(mech_attacker) >= mech_overheat:
//     Attacker Loses!
//     ->->
//   - else:
//     -> battle_hub
//   }
//   You have {get_power(IronWolf)} POWER left.
//   POWER: {currentPower}
//   <>; HEAT: {currentHeat}
//   <>; HEATSINKS: {currentHeatsinks}
//   <>; Speed: {currentSpeed} KPP
// -> arena.how_battle_works ->
// // -> arena.battle_hub ->
// <- arena.battle_hub
// Loop Again.
// Post game stuff I think.
//   {get_turn_state (mech_attacker) == GAMEOVER:
//     Player is DONE
//   }
//   Ending Volley

= battle_hub
  ~ set_turn_state(mech_attacker, Volley)
  ~ set_turn_state(mech_defender, Volley)

  // Turn Start, Recharge everyone
  ~ mech_recharge(mech_attacker)
  ~ mech_recharge(mech_defender)

  // Perform upkeep costs
  -> ironwolf.upkeep ->

  <- axman.status
  <- ironwolf.status

  // Player and AI pick moves until they run out of power or end the turn.
  - (turn_loop)
  ~ temp state_attacker = get_turn_state(mech_attacker)
  ~ temp state_defender = get_turn_state(mech_defender)
  Turn Loop: Player: {state_attacker}; AI: {state_defender}

  // First step, check for gameover
  {get_heat (mech_defender) >= mech_overheat:
    // Attacker wins!
    Player Wins!
    -> DONE
  }
  {get_heat (mech_attacker) >= mech_overheat:
    Player Loses!
    -> DONE
  }

  ^^^^Start Volley^^^^
  {
  - state_attacker == state_defender && state_attacker == Volley:
    ~ temp first_volley = "{~attacker|defender}"
    {first_volley == "attacker":
      Player is the first to act.
       -> ironwolf.pick_action_draft_one ->
       -> axman.random_action
    - else:
      AI is the first to respond.
    }
    We all equal playing dudes.
  - state_attacker == state_defender && state_attacker == Wait:
    We are all done taking turns dude.
  }

  // Repeat!
  ^^^^Calling turn_loop^^^^
  -> turn_loop


  -
  Post play turn loop
  -> DONE

//   IronWolf: {get_heat(IronWolf)} HEAT, {get_power(IronWolf)} POWER
= pick_action_draft_one
//   Pick an action.
  ~ temp currentPower = get_power(IronWolf)
  ~ temp currentHeat = get_heat(IronWolf)
  ~ temp currentHeatsinks = get_heatsinks(IronWolf)
  ~ temp currentSpeed = get_speed(IronWolf)

  IronWolf Status: {currentPower} POWER; {currentHeat} HEAT; {currentSpeed} Speed kpp.
  What would you like to do?
  + {currentPower >= 4} [Fire Laser - {power_cost(Laser, 1)} POWER; {heat_cost(Laser, 1)} HEAT; 3-4 Damage]
    <- laser.fire(IronWolf, Axman)
    // -> pick_action_draft_one
  + {currentPower >= 1} [Move]
    -> menu_move ->
    // -> pick_action_draft_one
  + [Wait for now]
    // -> post_turn ->
    ->->
  -
  // If we have enough power for more actions.
  {currentPower > 0:
    -> pick_action_draft_one
  - else:
    -> post_turn ->
  }
  -> DONE
= menu_move
  ~ temp currentRange = get_range()
  {IronWolf} is moving at {get_speed(IronWolf)} POWER/Kilometer PPK Power per Kilometer, Power over Range

  + Evasive Maneuvers
    # TODO add this feature
  + [Increase Speed]
    ~ mech_change_speed(IronWolf, 1, 1)
    {IronWolf} moves faster, increasing speed to {get_speed(IronWolf)} kpp.
  + Decrease Speed
    ~ mech_change_speed(IronWolf, -1, 1)
    {IronWolf} slows down, decreasing speed to {get_speed(IronWolf)} kpp.

  -
  {currentRange != get_range():
    Range changed to {get_range()}
  }
  ->->

//   Ending Player Turn {get_turn_state(IronWolf)}
// {IronWolf} is faster and gets to make the first move.
// {Axman} is quick and gets the first move.
= how_battle_works
  This is a one on one arena match between challenger {mech_attacker} and the defending {mech_defender}.
  <> Each mech is powered by a reactor that generates POWER each turn; and HEATSINKS that reduce HEAT each turn.
  <> The first mech to reach {mech_overheat} HEAT loses the battle.
  <> Firing weapons, moving, dodging, all cost POWER and generate some HEAT.
  ->->
//   ~ set_turn_state(IronWolf, Wait)
= post_turn
//   ~ set_turn_state(IronWolf, Wait)
  ->->
//   Axman: {get_heat(Axman)} HEAT, {get_power(Axman)} POWER
== function can_continue_volley()
{
-  get_turn_state(mech_attacker) == GAMEOVER and get_turn_state(mech_defender) == GAMEOVER:
  ~ return false
}

-> post_turn ->
= post_turn
  ~ set_turn_state(Axman, PASS)
  ->->
//   Starting Volley
//    {mech_attacker} is the first to make a move.
//    -> ironwolf.pick_action ->
//    -> axman.random_action ->
//       {mech_attacker} is ready.
//    {mech_defender} is the first to make a move.
//    -> axman.random_action ->
//    -> ironwolf.pick_action ->
//    Both are done
//   Repeat for another volley
// == function bonus_small()
//   ~ temp rnd = "{~win|lose|lose|lose}"
//   {rnd == "win":
//     ~ return 1
//   }
//   ~ return 0
