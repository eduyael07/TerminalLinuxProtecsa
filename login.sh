#!/bin/bash

echo "Bienvenido a la terminal"

# Leer usuario y contraseña (con read -s, luego un echo para el salto)
read -p "Usuario: " usuario
read -s -p "Contraseña: " clave
echo

# Verificar si el usuario existe
if ! id "$usuario" &>/dev/null; then
    echo "Usuario no encontrado"
    exit 1
fi

# Comprobar la contraseña mediante el comando `passwd`
echo "$clave" | su - "$usuario" -c "exit" &>/dev/null

# Verificar si la contraseña fue correcta
if [ $? -eq 0 ]; then
    echo "Acceso concedido. Bienvenido $usuario"
    exit 0
else
    echo "Contraseña incorrecta"
    exit 1
fi


