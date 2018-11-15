# Ideas
For all of this, we will assume a standard mech, perfectly average with all values at the base level. Once we have this, we can make special adjustments and scaling as needed.

## Ideas about Environment and Water
Standing in water, dissipates heat every turn. How much it dissipates depends on how much of the mech is underwater.

Environmental effects like rain, a desert, etc can affect how equipment works during battle. For example in a hot desert heatsinks don't work as well, dissipating less heat than normal.

## Ideas about distance and power.
Distance between the two fighting mechs determine their fighting range. Long Range, Medium Range, and Short Range. Every 5 POWER changes the range by 1 in either direction. This is a total movement spent by each mech.
>>> Attacker uses 3 power to move forward, range is still long.
>>> Defender uses 2 power to move forward, range is now medium because a total of 5 power was used moving forward (aka moving towards each other)

## Energy, Heat, Physical Damage (Draft 2)
The match is won by overheating your opponent before they overheat you.
Reactor generates POWER every turn, heatsinks remove HEAT every turn.
The number of Weapons/Equipment determines how many heatsinks are provided. ~Typically there is a 2-1 ratio as the baseline.~ Or it could be the waste HEAT + 1 is the baseline formula for heatsinks. Weapons can always cover their own waste and a little more. Makes sense that they would be build that way. I also like the idea that the base mech determines the number of heatsinks, and that limits the weapons, instead of the other way around. Plus equipment and abilities will adjust the final numbers.
Every action has a POWER cost to perform, including things like dodge or cloak or jump jets.
There are two types of weapons: Energy and Projectile.

### Energy
These weapons turn energy spent into heat damage on an opponent. These weapons are not 100% efficient so some of the energy is turned into waste HEAT on the mech that fired the laser. As an example, our baseline laser takes 4 POWER to charge is 3 HEAT Damage, 1 HEAT waste. This base line sets up the base laser formula. Then it can be scaled and modified to create other energy weapons. It would keep the formula and scaling the same.
Energy weapons lose energy over distance.

* Base
  * 4 POWER to fire.
  * 3 HEAT Damage dealt to the mech hit.
  * 1 HEAT wasted on the mech that fired.
  * Damage / 2 per range after close. (Medium divides the final damage by two, Long divides it by 4)
  * Chance to dodge: 0
  * Type: Instant
  * Number of heat sinks provided/required: 2

### Projectile
These weapons use a small amount of POWER because everything costs POWER. But instead of dealing HEAT damage, they deal physical damage in the form of destroying heatsinks. You can not win with physical projectiles alone, to win you need to overheat the opponent, not deal physical damage. Projectile weapons carry a limited number of rounds ~and must be reloaded~.
Example baseline projectile might be missiles. 1 POWER to launch. Takes 1 Turn to reach target, Destroys 1 heatsink, 3 Rounds.

* Base
  * 1 POWER and 1 Ammo to fire.
  * 1 destroyed heat sink as damage
  * 0 HEAT waste
  * Chance to dodge is 10%
  * Type: Delayed Hit +1 Turn
  * Number of heat sinks provided/required: 1

### Mechs
Mechs come in all shapes and forms. A little bit like pokemon. The baseline mech is a 65 ton Catapult. It features both Missiles and Lasers, all at baseline levels.

* Base
  * Fusion Power Reactor that generates 5 POWER per turn.
  * Provides 10 heatsinks that remove 10 HEAT per turn.
  * Overheats at 20 HEAT.
  * Batteries can store 10 POWER total. Each turn the reactor puts power into the batteries, and during a turn the mech pulls power out of the batteries.
  * 5 POWER to change range in 1 turn. (Full Run)


### Abilities, Equipment, and Other
There are a limited number of variables that are used in the different calculations. Each of these parts of the formula can be altered by abilities, skills, equipment, whatever you want to call it. Since it's a battle tech style game, equipment works well.

An Example: Jump Jets. 4 POWER + 2 HEAT to add 1 height unit. 2 POWER + 1 HEAT to maintain existing height. Effect of being 1 unit height above opponent. All opponent dodge change is -45%, and your dodge chance is +10%. Range is increased by 1 for each height unit. So a mech using Jump Jets, can never be in close range to a mech on the ground. Even directly under the other mech, they would still be at medium range.

* Variables
  * POWER generation rate per turn.
  * HEAT dissipation rate per turn.
  * Max POWER limit (aka battery)
  * Max HEAT limit (aka overheating)
  * Range or distance between the mechs.
  * Cost to fire a weapon, POWER and/or Ammo.
  * Type and amount of damage dealt from weapons. Does it add HEAT or lower dissipation rate? By how much?
  * Chance to dodge an attack.
  * Number of heatsinks when the mech is 100% (In a way, the heatsinks are the mechs health.)
  * Projectiles in air.
  * Power requires for a full run (aka change the range in one turn.)
  * Position in 3D(-ish) space.
  * Energy cost type: One time like weapons, or every turn like jump jets, cloaks, power melee weapons


## Ideas about Health, Damage, Heat, etc (Draft 1)
A Mech can keep fighting until it reaches 20 HEAT. At that point it loses and the fight is over. The Mech automatically shuts down to avoid exploding.

There is no health or damage. Combat is about balancing POWER and HEAT.
Physical attacks like Missiles, Guass Rifles, Autocannon, and melee weapons destroy HEATSINKs. If a mech has no more HEATSINKs, then it will not only not dissipate any more heat, but the fusion reactor will produce 1 HEAT per turn. (This reactor heat is negated by having at least one heatsink.)
Energy attacks like Particle Projectors and Lasers turn POWER into HEAT on the opponent.

Unlike physical weapons that are ineffective or dodge-able and specific ranges, energy weapons always hit with a target lock. Energy weapons do loser power over distance.

Laser weapons work on a scale, Heaver lasers are able to use larger amounts of power to generate more heat in the target, while light lasers take less power, but provide little heat.

### Hardpoints
How many weapons can a mech hold? How many heatsinks?
Every Weapon or Equipment that can be mounted on a mech is also half a heatsink! The downside is that when two heatsinks are destroyed, so is the thing the heatsinks are attached to are also destoyed.
Hardpoints are fixed by the frame, weight, and size of the mech.

### Weapons
* Long Range Weapons:
  * Physical: Missiles, Gauss Rifle
  * Energy: Particle Projector
* Medium Range Weapons:
  * Physical: Gauss Rifle, Autocannon
  * Energy: Laser
* Short Range Weapons:
  * Physical: Melee, Autocannon
  * Energy: Laser

### Long Range
* Missiles
  * Physical, destroys a heatsink if hit.
  * Can only be fired when at LONG range.
  * Takes 1 turn to reach target.
  * If target is in MEDIUM range, there is a chance for the other mech to spend POWER and dodge the missiles.
  * If target is in LONG range, missiles hit.
  * If target is in SHORT range, missiles miss.
  * Takes 1 turn to reload missiles.
  * Takes very little power, long waiting time.
* Particle Projector
  * Energy, increases the target's heat.
  * LONG range.
  * Takes a large amount of power.
  * Generates some HEAT when fired.
* Gauss Rifle
  * Physical, destroy heatsink if it hits.
  * LONG or MEDIUM
  * Takes 1 turn to reload the slug.
  * Takes a large amount of power.

### Medium Range
* Gauss Rifle
  * Physical, destroy heatsink if it hits.
  * LONG or MEDIUM
  * Takes 1 turn to reload the slug.
  * Takes a large amount of power.
* Laser
  * Energy, adds HEAT to the target.
  * MEDIUM or SHORT
  * Generates some HEAT to fire.
* Autocannon
  * Physical, destroys heatsink if it hits.
  * MEDIUM or SHORT
  * Takes 1 turn to reload rounds.
  * Takes little energy

### Short Range
* Melee
  * Physical, destroys heatsink if it hits.
  * No reload time, no ammo.
  * SHORT
  * Takes little energy.
* Laser
  * Energy, adds HEAT to the target.
  * MEDIUM or SHORT
  * Generates some HEAT to fire.
* Autocannon
  * Physical, destroys heatsink if it hits.
  * MEDIUM or SHORT
  * Takes 1 turn to reload rounds.
  * Takes little energy

---
what if real world paid like loot boxes in games like overwatch?

maybe there are some real world examples that are paid like that.  slot machines


the difference between a slot machine and a RNG that enhances gameplay/fun.

for example: diablo 1/2 loot system is the best i've played. followed bu boarderlands 1.

harthstone packs i do not mind because duplicates are recycled at prices based on rarity.  so you always win, which makes the cards feel like a safe investment.

gambling is very old, when money appears probably, what percentage of a population is addicted to gambling and what percentage resists? goal is to figure out which market is bigger.

is it better to drain a few people of all their money; or to get a little money from a lot of people. i assume this is a formula or graphs.

if the addicted market is large, the. the formula doesn't matter because draining a lot of people would provide the biggest profit (assuming costs stay the same).

my instincts tell me that there is a much larger of casual addiction people, or the term I lovingly use is Fan. The fans will not let you drain them, but they will spend a large amount over a longer period if time. you could call this the Disney model, as they have been buying and combining all the different fan bases.

i include fickle fans in this, because i think they are a larger share than die hard fans. its a scale, so the distinction doesnt matter that much.

Every Fan has $X they can spend a year on products, services, etc related to their fandom.

$X is limited by a number of factors, including: how much they make, other expenses like medical bills, housing, or anything else that would prevent then from spending as much as they would like too.

Fans are limited by a number if factors including; still living, know about the fandom, able to buy things from thr fandom.

So, to maximize sales, you need a lot of health, employed, people who make a lot of money.

todo: graph over time that shows the profit change over time as they factors go io and down.
