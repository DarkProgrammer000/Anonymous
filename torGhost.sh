#!/bin/bash
# Design: DARKPROGRAMMER000
# BE CAREFUL !!!!

# Monitoramento do IP de 8 em 8 minutos
monitoramento()
{
	# Apresentacao
	clear
	echo -e "\033[01;32m ---------------- \033[01;37m"
	echo -e "\033[01;33m + Lista de Ips + \033[01;37m"
	echo -e "\033[01;32m ---------------- \033[01;37m"

	# Controle
	ctr=1

	# Estrutura em loop
	while ((1))
	do
		# Controle de resposta IP
		ip=$(curl ifconfig.me --silent)

		# Mensagem
		echo -e "\033[01;34m $ctr) $ip \033[01;37m"

		# Track
		mtr -r duckduckgo.com

		# Incremento
		ctr=$((ctr + 1))

		# Tempo de espera
		sleep $((8 * 60))
	done
}

# Execucao do programa
execucao()
{

	############
	# CONTROLE #
	############

	# Capturando IP
	ip=$(curl ifconfig.me --silent | awk {'print $1'})
	
	# Apresentacao
	clear
	echo -e "\033[01;34m\n ----- Execucao ----- \n\033[01;37m"	
	echo -e "\033[01;35m --> IP atual: $ip \n\033[01;37m"
	
	echo -e "\033[01;33m # Placas de rede \n\033[01;37m"

	# Placas de redes	
	ifconfig | cut -f 1 -d " " | uniq -i

	echo -n -e "\033[01;32m # Interface de rede: \033[01;37m"
	read placa
	clear

	# Tor
	# service tor start
	cd TorghostNG/
	python3 torghostng.py -u -s --dns -c -m $placa -id RU

	# Controle de IP
	cd ../
	sleep 30
	monitoramento
}

# Desativacao do programa
desativacao()
{
	clear
	echo -e "\033[01;34m\n  ----- Desativacao ----- \n\033[01;37m"
	
	# Finalizando conexao
	cd Torghost/
	python3 torghostng.py -x
	cd ../

	# Desativar placa de rede: ifconfig eth0 down \n\033[01;37m"
	# Ativar placa de rede:    ifconfig eth0 up \n\033[01;37m"
}

# Instalacao do programa
instalacao()
{
	echo -e "\033[01;35m\n  ----- Instalacao ----- \n\033[01;37m"
    
	# Estutura de decisao: Analisar se o arquivo existe
	if [[ -r TorghostNG/ ]]
	then
		echo -e "\033[01;33m\n # Diretorio existente \n\033[01;37m"
	
	else
		# Instalar TOR
		apt-get install tor -y
		apt-get install privoxy

		# GitHub
		git clone https://github.com/githacktools/TorghostNG

		# Instalar
		cd TorghostNG
		python3 install.py
	fi
}

# Apresentacao
clear
echo -e "\033[01;34m --------------------\033[01;37m"
echo -e "\033[01;35m     TOR GHOST NG    \033[01;37m"
echo -e "\033[01;34m --------------------\033[01;37m"
echo ""
echo -e "\033[01;31m [1] Executar   	 \033[01;37m"
echo -e "\033[01;33m [2] Desativar  	 \033[01;37m"
echo -e "\033[01;36m [3] Instalar   	 \033[01;37m"
echo ""
echo -e -n "\033[01;37m - Opc: \033[01;37m"
read opc
clear

# Estrutura de escolha
case $opc in

1)	execucao;;
2)	desativacao;;
3)	instalacao;;
*)	;;

esac
