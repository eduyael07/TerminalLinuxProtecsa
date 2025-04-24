#!/bin/bash

clear
echo "===== INFORMACIÓN DEL SISTEMA ====="
echo


# Nombre del equipo
echo "Nombre del equipo: $(hostname)"

# Nombre del usuario
echo "Usuario actual: $USER"

# Tiempo activo del sistema
echo "Tiempo activo: $(uptime -p)"

# Arquitectura del sistema
echo "Arquitectura del sistema: $(uname -m)"

# Sistema operativo y versión
grep "PRETTY_NAME" /etc/os-release | cut -d= -f2

# Uso de memoria
echo "Uso de memoria:"
free -h | awk 'NR==2{printf "  Usada: %s / Total: %s\n", $3, $2}'

echo
read -p "Presiona Enter para volver al menú..."
