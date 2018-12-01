GitHubGameOff 2018 is a month long jam to write a game that follows a theme. The theme this year is Hybrid. This is a hybrid book and game.
National Novel Writing Month (NaNoWriMo) is a challenge to write a novel (50,000 words or about the length of The Great Gatsby) in the month of November.


- (loop)
* Play the Battle Game (Single Battle)
  -> battle_only
* Read Novel NaNoWriMo (NaNoWriMo Draft)
  -> nanowrimo_only
* Play The Hybrid Novel Game (Unfinished)
  Ran out of time. The idea is that as you read the book, battles happen (which you play) and you get to upgrade your Mech.
  Ran out of time before I could really combine the two. My goal is to have the novel be a CYOA/Detective/RPG style with graphical mech battles
  I tried my best to apply the game rules to a text based game. The idea is that volleys happen in semi-real time like in pathfinder's 6 seconds. Except POWER is used for everything.
//   -> play_full_game
  -> loop

== nanowrimo_only
  # story: story
  -> DONE
== battle_only
  # story: battle
  -> DONE
== play_full_game
  # story: full
  -> DONE
