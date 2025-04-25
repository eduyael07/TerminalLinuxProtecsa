#!/bin/bash

# Evitar salir con Ctrl+C o Ctrl+Z
stty intr undef  # Desactiva Ctrl+C (SIGINT)
stty susp undef  # Desactiva Ctrl+Z (SIGTSTP)

# Definición de colores
RED="\e[31m"
GREEN="\e[32m"
YELLOW="\e[33m"
CYAN="\e[36m"
WHITE="\e[37m"
RESET="\e[0m"

clear
echo -e "${GREEN}"
cat << "EOF"
=====================================================================================================================                                        
___                         _                                       _  _  __   
 |  _  ____  o __  _  |    |_) _  __ _  _ __  _  | o _  _  _| _    |_)|_|(_ |_|
 | (/_ | ||| | | |(_| |    |  (/_ | _> (_)| |(_| | | /_(_|(_|(_|   |_)| |__)| |

 ESCRIBE 'AYUDA' PARA VER LOS COMANDOS

=====================================================================================================================
EOF

usuario=$(whoami)

while true; do
    echo
    ruta=$(pwd)
    # Mostrar prompt con colores
    read -e -p "$(echo -e "${CYAN}${usuario}${RESET}:${YELLOW}${ruta}${RESET}$ ")" comando

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
        ahorcado)
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
            if ! eval "$comando" 2>/dev/null; then
                echo -e "${RED}Comando no reconocido. Escribe 'ayuda' para ver los comandos disponibles.${RESET}"
            fi
            ;;
    esac
done
