Battle Test three, the player action menu loop test.
-> battle_test_three.pick_action ->

Wow, such action. maybe you could pick another?

-> battle_test_three.pick_action ->

And again to show that the menu keep continuing. 

== battle_test_three
= pick_action
  + [Fire Laser!]
    <- fire_laser 
    -> pick_action
  + [Fire Missile!]
    <- fire_missile 
    -> pick_action
  + [Dodge!]
    <- dodge 
    -> pick_action
  + [Move Closer!]
    <- forward 
    -> pick_action
  + [Move Away!]
    <- back 
    -> pick_action
  + [End Turn]
    ->->
  -> DONE
  
= fire_laser
  You fired a laser! Pew Pew!
  -> DONE
= fire_missile
  You fired some missiles! Whoosh Boom!
  -> DONE
= dodge
  That was a close one, but you managed to doge!
  -> DONE
== forward
  You run ahead, trying to get in range.
  -> DONE
== back
  You back up, trying to put some distance between the two of you.
  -> DONE