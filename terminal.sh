#!/bin/bash

# Evitar salir con Ctrl+C o Ctrl+Z
stty intr undef  # Desactiva Ctrl+C (SIGINT)
stty susp undef  # Desactiva Ctrl+Z (SIGTSTP)

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
                echo "Comando no reconocido. Escribe 'ayuda' para ver los comandos disponibles."
            fi
            ;;

    esac
done
