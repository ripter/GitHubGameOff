== midpoint
= start
  After a lot of long and hard fought battles, Rex had made it. He was going up against the champion.
  Rex sat on a small bed next to IronWolf, the two of them plugged in together though Rex's port on his missing arm.
  
  * [Next] 
  -
  
  "I thought you wanted to be the galaxy champion" IronWolf asked.
  "Well yeah, of course." Rex said.
  "So why are you so excited about the fight this weekend?" IronWolf asked. "This is just some underground fighting arena. We haven't even left this planet since we arrived." IronWolf snorted "Seems like an awfully small galaxy to me."
  "What? Where is this coming from?" Rex asked. "We have been winning! Look at all the money we've earned, all the upgrades we have. We win the champaionship here, and we can get into the galaxy qualifying rounds."
  "So more time here? In this place?" IronWolf asked.
  "Temporary!" Rex said. "We just need to keep pressing forward. We are so close."
  IronWolf just looked at him.
  "I promise you" Rex said. "After this match, we will leave."
  "Really?" IronWolf said.
  "Yeah. After this match we will take our winnings and charter a ship somewhere else." Rex said. "It is a galaxy wide tournament after all."
  "I hope we get to see a lot of different planets" IronWolf said. "Even if we lose."
  Rex smiled. "We won't lose. We are awesome."

  * [Final Battle]
  -
  
  This was it, Rex and IronWolf made their way though the underground tunnels between the Aurigan compound and the arena. In the tunnels, people, fans, mechanics, lines the hallway and watched as he passed. When he arrived, he was in the starting position of the arena. A bright sun overheat, and a desert setting. A few cactuses and no water.
  Rex smiled. "Perfect, we should be able to overheat him in no time. a hot desert will hamper heatsink efficiency and no water means no easy way to cool down."

  The Atlas walked out from his side of the arena. The stadium camera footage was streaming into both pilots cockpit as they got ready. The Atlas looked different than the last battle. It's large heatsinks were fanned out, giving the mech a spiky shadows appearence. The heat radating off the mech made the immage shimmer from a distance.

  * [Atlas Boss Stats]
    Atlas, 100 tons 12 meters tall.
    Power Regen: 10
    Heat Sinks: 10
    Weapons: 1x Guass Rifle; 1x Particle Projector; 3x Autocannons; 5x Lasers;

  * [Start Battle]

  -
  "The challenger Rex has earned the right to fight our champion!" The Announcer said over the channel. "Will he win? will he even last past the first shot? Our Atlas is a devastating foe to challenge."

  // IronWolf was ready. The moment the buzzer rang, he took off in a zig zag across the battle field. Running at incredible speed. IronWolf used {power_cost(Run, 1)} POWER and generated {heat_cost(Run, 1)} waste HEAT.
  // ~ perform(IronWolf, Run, 1)


  Milliseconds after IronWolf moved a large slug slammed into IronWolf's starting position. The loud sonic boom quickly following. The slug was the size of IronWolf's heat.
  // Atlas had fired it's Guass Rifle, using {power_cost(GuassRifle, 1)} POWER and generating {heat_cost(GuassRifle, 1)} waste HEAT.
  // ~ perform(Atlas, GuassRifle, 1)

  IronWolf tried to calculate the best evasive maneuvers while Rex guided the general direction. They where moving forward, which was easy considering the areana lacked any obsticals Rex and IronWolf could use.
  A breif wave of heat soared past IronWolf right when he zagged. The plasma ball from the Atla's partical projector seared by, missing by meters.
  // Atlas fired it's Partical Projector Cannon, using {power_cost(PPC, 1)} and generating {heat_cost(PPC, 1)} waste heat. IronWolf used {power_cost(Dodge, 1)} POWER to dodge the attack; generating {heat_cost(Dodge, 1)} waste HEAT.
  // ~ perform(Atlas, PPC, 1)
  // ~ perform(IronWolf, Dodge, 1)



  * [Next Turn]
  * [Atlas Status]
    // Atlas: {power(Atlas)} POWER, {heat(Atlas)} HEAT
  * [IronWolf Status]
    // IronWolf: {power(IronWolf)} POWER, {heat(IronWolf)} HEAT
  -
  // ~ update_power(IronWolf, 5)
  // ~ update_heat(IronWolf, -3)
  // ~ update_power(Atlas, 10)
  // ~ update_heat(Atlas, -10)


  IronWolf managed to close the distance down to medium. Rex let IronWolf keep running while he aimed the Guass Rifle. A boom struck out as the slug impacted the unmoving Atlas.
  // IronWolf fired his Guass Rifle, using {power_cost(GuassRifle, 1)} POWER and generating {heat_cost(GuassRifle, 1)} waste HEAT.
  // ~ perform(IronWolf, GuassRifle, 1)

  The Atlas returned fire with 5 lasers. IronWolf was not able to dodge as the beams fired in the flash of light. IronWolf suddenly suffered from 10 HEAT damage, causing warning to flash on Rex's screen. He could feel the heat. One of the beams hat struct the cockpit.
  // Atlas fired 5 lasers, using {power_cost(Laser, 5)} POWER and generating {heat_cost(Laser, 5)} waste HEAT.

  "I can't take another hit like that" IronWolf said over the channel.
  "Good thing we updated your heatsinks" Rex responded "or we would be out of the battle all ready."

  * [Next] 
  -
  
  IronWolf dodged again, activating short range teleport to move faster than the Atlas's targeting computer could calculate. IronWolf dropped out of teleport right in front of the Atlas. He jumped, claws covered in a bright blue flames.
  The Atlas managed to rase an arm in defense. IronWolfs claws sliced though the limb, severing the Guass Rifle arm from the Atlas.
  In retaliation the Atlas's Autocannons opened fired, each round slamming into the armor of close range opponent. heatsinks chipping or cracking under the impacts before IronWolf could move out of range again.

  This time would have to be it. The Atlas fired laser after laser at IronWolf, but the mech was able to dodge teleport out of the way. IronWolf was a few dozen meters away. Rex setup and activated the claw attack while IronWolf calculated the jump and flight path. They were aiming for the heat this time. They needed to finish this in one hit.
  IronWolf landed from a teleport ready to leap. Heat warning flashed in Rex's vision. The mech was suddenly overloading. Rex could only watch as IronWolf shut down and the Atlas's Autocannons rained slugs down on the mech.
  Then it was over.
  "Winner!" The announcer said. "Atlas has overheated IronWolf!" The crowd cheered and booed, depending on who they bet on.
  Rex sat in the cockpit dumbfounded. How did he miss that? Did the Atlas hit him with something? He was in shock and frozen inside IronWolf's body.

  // ~ update_power(IronWolf, 5)
  // ~ update_heat(IronWolf, -5)
  // ~ update_power(Atlas, 10)
  // ~ update_heat(Atlas, -10)
  * [Exit Battle]
  * [Atlas Status]
    // Atlas: {power(Atlas)} POWER, {heat(Atlas)} HEAT
  * [IronWolf Status]
    // IronWolf: {power(IronWolf)} POWER, {heat(IronWolf)} HEAT


  Tammy came with moving truck to pick up the broken and managed IronWolf. Outside the cockpit Rex sat down and held his head in his hands.
  Tammy put a hand on his shoulder. "It's ok, it's not the end of the world."
  Rex jumped up, throwing Tammy's hand off of him. "You don't know anything." he said as he stormed off.
  "You stupid jerk" Tammy said after he left. "I was trying to help you." she muttered to herself. She opened the video of the fight and ran it though her analyzer. Sure enough it picked up the same energy spike she had seen in the other quote unquote wins from this champion Atlas.
  She know for sure, Clan Aurigan was cheating, and they got Rex.

  * [Next] 
  -
  ->->

= notes
  [Writer's note: the fun and games section was one of the big player playing sections. I spent two days working on it and, I was able to make some progress.]
  [Writer's note: This section is after a lot of fighting and building up Rex's riches and upgrades. I am going to do the thing that everyone hates in games because it makes sense for the story (eh, maybe makes sense for the story?) Either way, I hope to turn this into a little detective section in a future draft.]
  [Writer's note: After looking up the midpoint again, I realized I was thinking of the bad guys close in, not midpoint, which is much smaller.]
  [Writer's note: This is the "Final Boss", or the player is supposed to think it is, (or assume it is not because of te trope). The player will win the battle, but the bad guys are going to win.]
  ->->

// Code moved to junk because it was in conflict with newer code.
