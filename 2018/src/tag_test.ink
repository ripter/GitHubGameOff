# debug: top level file.
Tags and Knots Testing
-> my_knot.start ->

== my_knot
= start
  # title: Story
  We are going to start a loop.
  
  This way we can figure out how we need to structure the knots/diverts/choices along with paragraphs.
  
  The goal is to know a pattern to make sure each section is displayed with the correct tags in the game.
  
  -> next_section ->
  
  -> main_loop ->
  -> END
  
= main_loop
  -> player_pick_action ->
  -> ai_pick_action ->
  
  + [Next Loop]
    -> main_loop ->
  + [Quit]
  -
  ->->
  
= player_pick_action
  # title: Player
  Pick an action to perform.
  Did you know is fun.

  + [Crazy Fact]
    <- crazy_facts
  + [Did you know?]
    <- did_you_know
  + End
    -> DONE
    
  -
  -> next_section ->
  ->->
  
= ai_pick_action
  # title: AI
  
  The AI shoots a laser at you! He also brags to tell you that <>
  <- did_you_know_no_title
  

  -
  -> next_section ->
  ->->

  
  
= did_you_know
  # title: Did You Know?
  {~11% of people are left handed|August has the highest percentage of births|rabbits like licorice|reindeer like bananas|macadamia nuts are toxic to dogs|all insects have 6 legs|camel's milk doesn't curdle|dragonflies have 6 legs but can't walk|an octopus pupil is rectangular|only female mosquitoes bite|scorpions glow under ultra violet light}
  <>? 
  -> DONE
  
= did_you_know_no_title
  {~each time you see a full moon you always see the same side|Earth is the only planet not named after a god|if your DNA was stretched out it would reach to the moon 6,000 times|every year the sun loses 360 million tons|45% of Americans don't know that the sun is a star|If you could drive to the sun at a speed of 88.5 km/h (55 mp/h) it would take around 193 years|hydrogen is the most abundant element in the Universe (75%)}
  <>? 
  -> DONE
  
= crazy_facts
  {~The Supreme Court has its own private basketball court|Walmart has a lower acceptance rate than Harvard|Hunting unicorns is legal in Michigan|It officially takes 364 licks to get to the center of a Tootsie Pop. Well, at least according to engineering students at Purdue University, who used a proprietary “licking machine” rather than a human tongue.|Cows moo with regional accents|In the small town of Dorset, Minnesota, where a new mayor is picked every two years by drawing names out of a hat, a three year old named Robert Tufts was elected mayor in 2015|You’re twice as likely to be killed by a vending machine than a shark.}
  -> DONE
  
== next_section
  + [Continue]
  -
  ->->