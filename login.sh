#!/bin/bash

echo " Bienvenido a la terminal "

read -p "Usuario: " usuario
read -s -p "Contraseña: " clave

if id "$usuario" &>/dev/null; then
	echo "$clave" | sudo -S -u "$usuario" true &>/dev/null
	if [ $? -eq 0 ]; then
		echo "Acceso concedido. Bienvenido $usuario"
		exit 0
	else 
		echo "Contraseña incorrecta"
		exit 1
	fi 
else 
	echo "Usuario no encontrado"
	exit 1
fi
