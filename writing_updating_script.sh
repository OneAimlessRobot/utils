#!/bin/bash


echo "Beginning script!!!!"
echo "Replacing botchats!!!!!"
((rm -rf F:/FASTprogs/webcrookedstuff/pages/botchatsFAST)&&(cp -rv F:/botchatsFAST F:/FASTprogs/webcrookedstuff/pages/))&
((rm -rf F:/FASTprogs/webcrookedstuff/pages/BotchatsFASTNEWEST)&&(cp -rv F:/BotchatsFASTNEWEST F:/FASTprogs/webcrookedstuff/pages/))&
((rm -rf F:/FASTprogs/webcrookedstuff/pages/BotchatsFASTNEWEST2)&&(cp -rv F:/BotchatsFASTNEWEST2 F:/FASTprogs/webcrookedstuff/pages/))&
#((rm -rf E:/Adriano/progs/webcrookedstuff/pages/botchatsFAST)&&(cp -rv F:/botchatsFAST E:/Adriano/progs/webcrookedstuff/pages/))&
#((rm -rf E:/Adriano/progs/webcrookedstuff/pages/BotchatsFASTNEWEST)&&(cp -rv F:/BotchatsFASTNEWEST E:/Adriano/progs/webcrookedstuff/pages/))&
#((rm -rf E:/Adriano/progs/webcrookedstuff/pages/BotchatsFASTNEWEST2)&&(cp -rv F:/BotchatsFASTNEWEST2 E:/Adriano/progs/webcrookedstuff/pages/))&
wait
echo "Done replacing botchats!!!"


echo "Replacing Writing!!!!!"
((rm -rf I:/Writing)&&(cp -rv ~/Desktop/Writing I:/))&
((rm -rf F:/Writing)&&(cp -rv ~/Desktop/Writing F:/))&
#((rm -rf E:/Adriano/Writing)&&(cp -rv ~/Desktop/Writing E:/Adriano/))&
((rm -rf F:/GithubFAST/escrita/Writing)&&(cp -rv ~/Desktop/Writing F:/GithubFAST/escrita/))&
((rm -rf F:/FASTprogs/webcrookedstuff/texts/Writing)&&(cp -rv ~/Desktop/Writing F:/FASTprogs/webcrookedstuff/texts/))&
#((rm -rf E:/Adriano/progs/webcrookedstuff/texts/Writing)&&(cp -rv ~/Desktop/Writing E:/Adriano/progs/webcrookedstuff/texts/))&
wait
echo "Done replacing Writing!!!!"







