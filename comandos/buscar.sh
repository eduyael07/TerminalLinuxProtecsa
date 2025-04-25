#!/bin/bash

# Pedir al usuario que ingrese el directorio y el archivo
read -p "Ingrese el directorio donde buscar (ruta): " directorio
read -p "Ingrese el nombre del archivo a buscar: " archivo

# Verificar si el directorio existe
if [ ! -d "$directorio" ]; then
    echo "ERROR: El directorio '$directorio' no existe."
    exit 1
fi

# Buscar el archivo en el directorio
busqueda=$(find "$directorio" -name "$archivo" 2>/dev/null)

# Comprobar si el archivo fue encontrado
if [ -z "$busqueda" ]; then
    echo "ERROR: El archivo '$archivo' no existe en '$directorio'."
    exit 1
else
    echo "Archivo '$archivo' encontrado en:"
    echo "$busqueda"
fi
