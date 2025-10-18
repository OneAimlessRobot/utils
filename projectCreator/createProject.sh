#!/bin/bash

projectDirectories=" Sources Includes resources"

startDir="$(echo $(pwd))/"

resDir="$(echo $(pwd))/.resources/"

mainFileName="main.c"

mainBodyFile="mainBody"

tmpFileName="tmp"

templateFileName="template"

mainHeaderFileName="preprocessor.h"

moduleSpawner="spawnModule.sh"

headerOpener="openAllHeaders.sh"

sourceOpener="openAllSources.sh"

mainHeaderTemplate="mainHeaderBody"
if [ $# -ne 2 ];
    then echo "primeiro argumento- diretoria do projeto\nSegundo- nome do projeto\n"
        exit -1
fi
echo "Currently at: $startDir"
touch "$resDir$tmpFileName"
echo "BINARY= $2.exe" >> "$resDir$tmpFileName"
echo "" >> "$resDir$tmpFileName"
echo "$(cat $resDir$templateFileName)" >> "$resDir$tmpFileName"
echo "$1/$2 about to be created"
mkdir "$1"
mkdir "$1/$2"
echo "$1/$2 created"
cp $resDir"headGuardWritter" "$1/$2"
cp $resDir$moduleSpawner "$1/$2"
cp $resDir$headerOpener "$1/$2"
cp $resDir$sourceOpener "$1/$2"
cd  "$1/$2"
mkdir $projectDirectories
touch Makefile
touch $mainFileName
touch "Includes/$mainHeaderFileName"
echo "$(cat $resDir$tmpFileName)" > Makefile
echo "$(cat $resDir$mainBodyFile)" > $mainFileName
echo "$(cat $resDir$mainHeaderTemplate)" > "Includes/$mainHeaderFileName"
rm -r $resDir$tmpFileName
echo "done!"
exit 0





