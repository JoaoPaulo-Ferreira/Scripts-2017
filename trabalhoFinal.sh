#!/bin/bash

clear
echo -e "          ####################  BEM VINDO AO JOGO DA FORCA!  ####################\n\n"

while getopts "f:t:" OPTVAR
do
    if [[ $OPTVAR = "f" ]];then
        arquivo=$OPTARG
    fi
    
    if [[ $OPTVAR = "t" ]];then
        tentativas=$OPTARG
    fi
done
restantes=$tentativas
linhas=$(wc -l $arquivo | cut -f1 -d' ')
palavra=$(echo "$RANDOM%$linhas" | bc )
(( palavra++ ))
selecionada=$(sed -n "${palavra}p" $arquivo)
declare -a vet
for ((i=0; i<${#selecionada}; i++)); do vet[$i]="${selecionada:$i:1}"; done
i=0
declare -a final
for ((i=0; i<${#selecionada}; i++)); do final[$i]='-'; done
echo ${final[@]}
while [ $restantes -gt 0 ]
    do
i=0
flag=0
    read -p "Entre com um chute: " chute
    while [ ${vet[$i]} ]
    do
        if [[ ${vet[$i]} == $chute ]];then
            flag=1
            final[$i]=$chute
        fi
    (( i++ ))
    done

    if [[ $flag -eq 0 ]];then
        echo "Erro!"
    fi
        (( restantes-- ))

    echo ${final[@]}

    if [[ ${final[@]} == ${vet[@]} ]];then
        echo "Você acertou! Tinha $tentativas. Você usou $(echo "$tentativas - $restantes " | bc) tentantivas."
        restantes=0
    fi

done

