var tagTestContent = ﻿{"inkVersion":18,"root":[[{"#":"debug: top level file."},"^Tags and Knots Testing","\n",{"->t->":"my_knot.start"},["done",{"#f":7,"#n":"g-0"}],null],"done",{"my_knot":[{"->":".^.start"},{"start":[{"#":"title: Story"},"^We are going to start a loop.","\n","^This way we can figure out how we need to structure the knots/diverts/choices along with paragraphs.","\n","^The goal is to know a pattern to make sure each section is displayed with the correct tags in the game.","\n",{"->t->":"next_section"},{"->t->":".^.^.main_loop"},"end",{"#f":3}],"main_loop":[[{"->t->":".^.^.^.player_pick_action"},{"->t->":".^.^.^.ai_pick_action"},"ev","str","^Next Loop","/str","/ev",{"*":".^.c-0","flg":4},"ev","str","^Quit","/str","/ev",{"*":".^.c-1","flg":4},{"c-0":["\n",{"->t->":".^.^.^"},{"->":".^.^.g-0"},{"#f":7}],"c-1":["\n",{"->":".^.^.g-0"},{"#f":7}],"g-0":["ev","void","/ev","->->",{"#f":7}]}],{"#f":3}],"player_pick_action":[[{"#":"title: Player"},"^Pick an action to perform.","\n","^Did you know is fun.","\n","ev","str","^Crazy Fact","/str","/ev",{"*":".^.c-0","flg":4},"ev","str","^Did you know?","/str","/ev",{"*":".^.c-1","flg":4},["ev",{"^->":"my_knot.player_pick_action.0.17.$r1"},{"temp=":"$r"},"str",{"->":".^.s"},[{"#n":"$r1"}],"/str","/ev",{"*":".^.^.c-2","flg":2},{"s":["^End",{"->":"$r","var":true},null]}],{"c-0":["\n","thread",{"->":"my_knot.crazy_facts"},{"->":".^.^.g-0"},{"#f":7}],"c-1":["\n","thread",{"->":"my_knot.did_you_know"},{"->":".^.^.g-0"},{"#f":7}],"c-2":["ev",{"^->":"my_knot.player_pick_action.0.c-2.$r2"},"/ev",{"temp=":"$r"},{"->":".^.^.17.s"},[{"#n":"$r2"}],"\n","done",{"->":".^.^.g-0"},{"#f":7}],"g-0":[{"->t->":"next_section"},"ev","void","/ev","->->",{"#f":7}]}],{"#f":3}],"ai_pick_action":[[{"#":"title: AI"},"^The AI shoots a laser at you! He also brags to tell you that ","<>","\n","thread",{"->":".^.^.^.did_you_know_no_title"},[{"->t->":"next_section"},"ev","void","/ev","->->",{"#f":7,"#n":"g-0"}],null],{"#f":3}],"did_you_know":[{"#":"title: Did You Know?"},["ev","visit",11,"seq","/ev","ev","du",0,"==","/ev",{"->":".^.s0","c":true},"ev","du",1,"==","/ev",{"->":".^.s1","c":true},"ev","du",2,"==","/ev",{"->":".^.s2","c":true},"ev","du",3,"==","/ev",{"->":".^.s3","c":true},"ev","du",4,"==","/ev",{"->":".^.s4","c":true},"ev","du",5,"==","/ev",{"->":".^.s5","c":true},"ev","du",6,"==","/ev",{"->":".^.s6","c":true},"ev","du",7,"==","/ev",{"->":".^.s7","c":true},"ev","du",8,"==","/ev",{"->":".^.s8","c":true},"ev","du",9,"==","/ev",{"->":".^.s9","c":true},"ev","du",10,"==","/ev",{"->":".^.s10","c":true},"nop",{"s0":["pop","^11% of people are left handed",{"->":".^.^.71"},null],"s1":["pop","^August has the highest percentage of births",{"->":".^.^.71"},null],"s2":["pop","^rabbits like licorice",{"->":".^.^.71"},null],"s3":["pop","^reindeer like bananas",{"->":".^.^.71"},null],"s4":["pop","^macadamia nuts are toxic to dogs",{"->":".^.^.71"},null],"s5":["pop","^all insects have 6 legs",{"->":".^.^.71"},null],"s6":["pop","^camel's milk doesn't curdle",{"->":".^.^.71"},null],"s7":["pop","^dragonflies have 6 legs but can't walk",{"->":".^.^.71"},null],"s8":["pop","^an octopus pupil is rectangular",{"->":".^.^.71"},null],"s9":["pop","^only female mosquitoes bite",{"->":".^.^.71"},null],"s10":["pop","^scorpions glow under ultra violet light",{"->":".^.^.71"},null],"#f":5}],"\n","<>","^?","\n","done",{"#f":3}],"did_you_know_no_title":[["ev","visit",7,"seq","/ev","ev","du",0,"==","/ev",{"->":".^.s0","c":true},"ev","du",1,"==","/ev",{"->":".^.s1","c":true},"ev","du",2,"==","/ev",{"->":".^.s2","c":true},"ev","du",3,"==","/ev",{"->":".^.s3","c":true},"ev","du",4,"==","/ev",{"->":".^.s4","c":true},"ev","du",5,"==","/ev",{"->":".^.s5","c":true},"ev","du",6,"==","/ev",{"->":".^.s6","c":true},"nop",{"s0":["pop","^each time you see a full moon you always see the same side",{"->":".^.^.47"},null],"s1":["pop","^Earth is the only planet not named after a god",{"->":".^.^.47"},null],"s2":["pop","^if your DNA was stretched out it would reach to the moon 6,000 times",{"->":".^.^.47"},null],"s3":["pop","^every year the sun loses 360 million tons",{"->":".^.^.47"},null],"s4":["pop","^45% of Americans don't know that the sun is a star",{"->":".^.^.47"},null],"s5":["pop","^If you could drive to the sun at a speed of 88.5 km/h (55 mp/h) it would take around 193 years",{"->":".^.^.47"},null],"s6":["pop","^hydrogen is the most abundant element in the Universe (75%)",{"->":".^.^.47"},null],"#f":5}],"\n","<>","^?","\n","done",{"#f":3}],"crazy_facts":[["ev","visit",7,"seq","/ev","ev","du",0,"==","/ev",{"->":".^.s0","c":true},"ev","du",1,"==","/ev",{"->":".^.s1","c":true},"ev","du",2,"==","/ev",{"->":".^.s2","c":true},"ev","du",3,"==","/ev",{"->":".^.s3","c":true},"ev","du",4,"==","/ev",{"->":".^.s4","c":true},"ev","du",5,"==","/ev",{"->":".^.s5","c":true},"ev","du",6,"==","/ev",{"->":".^.s6","c":true},"nop",{"s0":["pop","^The Supreme Court has its own private basketball court",{"->":".^.^.47"},null],"s1":["pop","^Walmart has a lower acceptance rate than Harvard",{"->":".^.^.47"},null],"s2":["pop","^Hunting unicorns is legal in Michigan",{"->":".^.^.47"},null],"s3":["pop","^It officially takes 364 licks to get to the center of a Tootsie Pop. Well, at least according to engineering students at Purdue University, who used a proprietary “licking machine” rather than a human tongue.",{"->":".^.^.47"},null],"s4":["pop","^Cows moo with regional accents",{"->":".^.^.47"},null],"s5":["pop","^In the small town of Dorset, Minnesota, where a new mayor is picked every two years by drawing names out of a hat, a three year old named Robert Tufts was elected mayor in 2015",{"->":".^.^.47"},null],"s6":["pop","^You’re twice as likely to be killed by a vending machine than a shark.",{"->":".^.^.47"},null],"#f":5}],"\n","done",{"#f":3}],"#f":3}],"next_section":[["ev","str","^Continue","/str","/ev",{"*":".^.c-0","flg":4},{"c-0":["\n",{"->":".^.^.g-0"},{"#f":7}],"g-0":["ev","void","/ev","->->",{"#f":7}]}],{"#f":3}],"#f":3}],"listDefs":{}};
