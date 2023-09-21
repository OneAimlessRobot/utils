#!/bin/bash


projectDirectories=" Sources Includes resources"

startDir="$(echo $(pwd))/"

mainFileName="main.c"

mainBodyFile="mainBody"

tmpFileName="tmp"

templateFileName="template"

if [ $# -ne 2 ];
    then echo "primeiro argumento- diretoria do projeto\nSegundo- nome do projeto\n"
        exit -1
fi
echo "Currently at: $startDir"
touch tmp
echo "BINARY= $2" >> $tmpFileName
echo "" >> $tmpFileName
echo "$(cat $templateFileName)" >> $tmpFileName
echo "$1/$2 about to be created"
mkdir "$1"
mkdir "$1/$2"
echo "$1/$2 created"
cd  "$1/$2"
mkdir $projectDirectories
touch Makefile
touch $mainFileName
echo "$(cat $startDir$tmpFileName)" > Makefile
echo "$(cat $startDir$mainBodyFile)" > $mainFileName
rm -r $startDir$tmpFileName
echo "done!"
exit 0





