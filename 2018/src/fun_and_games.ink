== fun_and_games
= start
  The next weekend Rex was back to continue his climb up the ladder. With IronWolf fully repaired. Maybe some changes to the loadout and one or two upgrades picked.

  (NOTE: I am still trying to figure out how these fights might work as a story/game. So I am going to try a bunch of different things and try and find
  the diamond in the rough.)

  - (top)
  * [Battle FAQ]
    -> how_battle_works -> top
  * [Battle One]
    -> battle_one -> top
  ->->

= battle_one
  * [IronWolf Status]
    IronWolf, Level 3 Scout Class.
    Weapons: Claws;
    Abilities: Jump, Heal, Cloak
    Equipment: Upgraded reactor, charge capacitors.

  *
  ->->

= how_battle_works
  + So how do you win a battle?
    The oponents can no longer continue the fight.
  + How do you disable the oponent?
    Physical damage, which is protected by armor.
    Overheating, which is protected by heat sinks.
    Weapons destoried/out of ammo.
  + How does Heat work?
    Heat builds up in both mechs when lasors are fired. Most of the heat conentrated on a single point on the defender.
    Weapons will not fire if they are too hot.
    Engines shut down if they get too hot.
    Missiles explode if they get too hot.
    Armor and superstructure can warp and melt if they get too hot.
    The main goal of lasors is to disable parts of the opoinent or melt though their armor. Setting off missiles inside an oponent mech can be quite the show.
    Moving and firing weapons generate heat.
    Heat Sinks will continusally disipate heat.
  + How does power generation work?
    Weapons and movement have a power requirement to work. When the Mech wants to take an action, like moving or fireing, or jumping, it uses up some of the stored power in the mech. It's internal rector is continusally recharging these internal batteries.
    It is possible for Mechs to not have battery systems (a lot of the old generation mech are this way) which limits their action to the max continus output of their reactors.
    The reactor has a set tempature cutoff value and the amount of heat it generates to produce that continues output.
    This means it is possible for a Mech to do soemthing like fire it's lasors continusally. The reactor will have no issue, but the lasor will eventurally heat up to the point it shuts down or breaks.
  + Phsyscal Damage and armor
    Mechs weigh a lot because of all their Equipment and armor. Armor protects the mechs from physcal damage, like IronWolf's physcal claws, or the swords and hatchets some mechs carry.
    The more armor, the slower the acceloration/max speed and the more power required to move the mech.
    This armor protects from missiles, and redirects heat to heatsinks.

  + Overview
    Heat Management, limits how often you can attack/move.
    Weapons/Armor Management, limits speed, acceleration, and scanner footprint.
    Equipment, provides special overrides to limits or new abilites.
    Weight, Limits the number and how much weapons, armor, and equipment a mech can carry.
  + Game Dev notes
    Each trackable area of a mech, the body, arms, legs, etc all have a heat meter. Each turn that meter will reduce by the number of active heat sinks connected to it (and functional.)
    The player can take an action, which causes one or more parts to generate some amount of heat.
    The player can get hit with energy weapons, which generate some amount of heat across one or more areas.
    Each area has a different reaction to the overheating depending on what is inside the mech. Example: and area holding missiles could explode if it generates too much heat. Weapons will refuse to fire after they have too much heat and will be destroyed or disabled if then get even hotter.
    Water will cool heated area, like walking in a river or rain falling.
  + Parts of a Mech.
    Body, Cockpit, four limbs, (left arm, left leg, right arm, right leg or in cases like IronWolf just call all the limbs arms or legs or whatever makes you feel better about the terminaligy.)
    Each part has: Head, Armor, Internal structure; (Equiment and ammo must be stored in one of the internal stucture areas), and hardpoints; (Places where it's structurely safe to mount weapons and other external equipment like countermeasure devices, cloaking devices, extra heat sinks.)
    The Mechs type and construction will determin the heat displacement, size of the internal storage and number of hard points. These factors are static on the mech type level. The NextGen mechs have the ability to change these factors.
  + Stat idea
    Catapult, 65 tons.
    Speed 43 kph - 64 kph.
    Weapons: 2 Long Range Missiles (ammo for 4 shots total), 4 medium lasors.
    Equipment: Jump Jets
    Body: reactor generating 10 power units per turn. Four hard points mount the four medium lasors. Each lasor uses 4 power units per turn to fire and generate 2 heat units.
    Cockpit: Has Armor and Heat meter, internal storage hold pilot.
    Left Arm: Arm is an armored missle rack (one hard point). Armor, heat, meteres. Holds one round inside the rack.
    Right Arm: the arm is just an armored missle rack (one hard point). Holds one round inside the rack.
    Left Leg: Interal holds one missle ammo reload. jump jets equiped
    Right left: Internal storage holds one missile reload. jump jets equiped.

  ->->
