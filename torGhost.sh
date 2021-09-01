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
	echo -e "\033[01;32m Acesse: https://www.test-ipv6.com/\033[01;37m"
	echo -e ""
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

desativarIPv6()
{

# Disable IPv6 on Linux
echo "Desativando IPv6 no boot..."
cat > /etc/sysctl.conf << EOF
net.ipv6.conf.all.disable_ipv6 = 1 
net.ipv6.conf.default.disable_ipv6 = 1 
net.ipv6.conf.lo.disable_ipv6 = 1 
EOF

# Load sysctl
sysctl -p
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
	ifconfig -s | awk {'print $1'}
	echo -n -e "\033[01;32m\n # Interface de rede: \033[01;37m"
	read placa
	clear

	# Tor
	# service tor start
	cd TorghostNG/
	git pull -f
	python3 torghostng.py -s --dns -c -m $placa -id RU

	#######################
	# Desativando IPV6    #
	# vi /etc/sysctl.conf #
	#######################
	desativarIPv6

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
	cd TorghostNG/
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
		git clone https://github.com/jermainlaforce/TorghostNG.git

		# Instalar
		cd TorghostNG
		python3 install.py
		git pull -f
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
