#!/bin/bash

# Evitar salir con Ctrl+C o Ctrl+Z
stty intr undef  # Desactiva Ctrl+C (SIGINT)
stty susp undef  # Desactiva Ctrl+Z (SIGTSTP)

clear
echo "=========================================="
echo "     TERMINAL PERSONALIZADA EN BASH       "
echo "        Proyecto final del curso Linux    "
echo "     Escribe 'ayuda' para ver los comandos"
echo "=========================================="

usuario=$(whoami)

while true; do
    echo
    ruta=$(pwd)
    read -p "$usuario:$ruta$ " comando

    case "$comando" in
        ayuda)
            ./comandos/ayuda.sh
            ;;
        infosis)
            ./comandos/infosis.sh
            ;;
        fecha)
            ./comandos/fecha.sh
            ;;
        buscar)
            ./comandos/buscar.sh
            ;;
        creditos)
            ./comandos/creditos.sh
            ;;
        juego)
            ./juegos/ahorcado.sh
            ;;
        reproductor)
            ./reproductor/mp3Player.sh
            ;;
        salir)
            echo "Cerrando sesión..."
            break
            ;;
        *)
            echo "Comando no reconocido. Escribe 'ayuda' para ver los comandos disponibles."
            ;;
    esac
done
