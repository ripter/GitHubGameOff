# Battle
Two mechs battle each other in an arena. The winner is the mech that survives the longest without overheating.
* Terms:
  * Turn: one or more rounds.
  * Round: Both mechs have performed all the moves/actions they are going to perform before the next turn. ~this turn.~


### Battle Style: Volley by Volley
* start turn (aka recharge)
* Confirm speed upkeep.
* loop until both players can not continue:
  * Each Mech performs 1 action or skips.
  * Check for game over


# Idea: Full Single Turn
Each "player" take a full turn to set their mech speed, and fire whatever weapons they are going to fire for this battle. Speed or random can determine who takes their turn first. The cost of whatever the player wants to do during the turn is subtracted after the turn is confirmed. Damage to the opponent is applied then, the opponent gets the opportunity to take their turn. After each player takes a turn, the round is over, game over is checked, then power recharges and heat dissipates.

* Each mech spends some or all of their POWER
* affects of a mech's turn (like damage) apply once they confirm their turn.
* After both mechs take their turn
  * check game over
  * recharge and start a new turn.


# Idea: Volley by Volley Turn
Each player takes turns performing an ACTION, one after the other. Each mech does one ACTION, then the other mech gets a chance to take an ACTION. Once both Mechs pass, the turn ends, game over is checked, and recharge happens.

* Mechs confirm movement spending. (Then movement upkeep is paid)
* Mechs take turns performing some actions until either they skip, or run out of POWER.
* After each volley, game over is checked.
* After each round, recharge happens.
