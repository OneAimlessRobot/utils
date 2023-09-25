#!/bin/bash

if [ $# -ne 3 ]; 
    then echo "primeiro argumento- diretoria do repo\nSegundo- nome do repo\nTerceiro- username"
	exit
fi

echo "$1/$2"
mkdir "$1"
mkdir "$1/$2"

echo "Queres criar repo local com permissões totais? (Senao n vais poder alterar nada sem escrever sudo o tempo todo...)"
read option
if [[ "$option" == "y" ]];
        then
	sudo chmod -R a+rwx "$1/$2"
        echo "CRIADO COM PERMISSOES TOTAIS!!! CUIDADO COM QUEM MEXE!!!!!"

elif [[ "$option" == "n" ]];
        then
        echo "Diretoria criada normalmente"
fi




cd  "$1/$2"
git init
touch ".gitkeep"
git add .
git commit 
echo "AGORA VAI AO GITHUB NA TUA CONTA E CRIA REPO NO BROWSER"
read -n1 kbd
git remote add origin "git@github.com:$3/$2.git"
git push origin master


