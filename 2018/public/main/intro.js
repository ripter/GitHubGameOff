var introContent = ﻿{"inkVersion":18,"root":[["^Game Off 2018 is a month long jam to write a game the follows a theme. The theme this year is Hybrid.","\n","^National Novel Writing Month (NaNoWriMo) is a challenge to write a novel (50,000 words or about the length of The Great Gatsby) in the month of November.","\n",["ev",{"^->":"0.4.$r1"},{"temp=":"$r"},"str",{"->":".^.s"},[{"#n":"$r1"}],"/str","/ev",{"*":"0.c-0","flg":18},{"s":["^Play The Hybrid Novel Game (Unfinished)",{"->":"$r","var":true},null]}],["ev",{"^->":"0.5.$r1"},{"temp=":"$r"},"str",{"->":".^.s"},[{"#n":"$r1"}],"/str","/ev",{"*":"0.c-1","flg":18},{"s":["^Read Novel NaNoWriMo (First Draft)",{"->":"$r","var":true},null]}],["ev",{"^->":"0.6.$r1"},{"temp=":"$r"},"str",{"->":".^.s"},[{"#n":"$r1"}],"/str","/ev",{"*":"0.c-2","flg":18},{"s":["^Play the Game (First Demo)",{"->":"$r","var":true},null]}],{"c-0":["ev",{"^->":"0.c-0.$r2"},"/ev",{"temp=":"$r"},{"->":"0.4.s"},[{"#n":"$r2"}],"\n",{"->":"play_full_game"},{"->":"0.g-0"},{"#f":7}],"c-1":["ev",{"^->":"0.c-1.$r2"},"/ev",{"temp=":"$r"},{"->":"0.5.s"},[{"#n":"$r2"}],"\n",{"->":"nanowrimo_only"},{"->":"0.g-0"},{"#f":7}],"c-2":["ev",{"^->":"0.c-2.$r2"},"/ev",{"temp=":"$r"},{"->":"0.6.s"},[{"#n":"$r2"}],"\n",{"->":"battle_only"},{"->":"0.g-0"},{"#f":7}],"g-0":["done",{"#f":7}]}],"done",{"nanowrimo_only":[{"#":"story: story"},"done",{"#f":3}],"battle_only":[{"#":"story: battle"},"done",{"#f":3}],"play_full_game":[{"#":"story: full"},{"#":"status: disabled"},"done",{"#f":3}],"#f":3}],"listDefs":{}};