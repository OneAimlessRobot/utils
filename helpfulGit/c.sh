echo "Queres criar repo local com permissões totais? (Senao n vais poder alterar nada sem escrever sudo"
read option
if [[ "$option" == "y" ]];
        then
        echo "CRIADO COM SUDO!!! CUIDADO COM QUEM MEXE!!!!!"

elif [[ "$option" == "n" ]];
        then
        echo "Diretoria criada normalmente"
fi
