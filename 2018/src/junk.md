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