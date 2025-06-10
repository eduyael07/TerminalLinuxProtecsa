#!/bin/bash

# Juego del Ahorcado simplificado

# Palabra secreta
palabra="hola"
intentos=6
letras_adivinadas=()
letras_incorrectas=()

# Dibujar el ahorcado según intentos restantes
dibujar_ahorcado() {
    case $intentos in
        6) echo "  _____"; echo " |    "; echo " |    "; echo " |    "; echo "_|____";;
        5) echo "  _____"; echo " |    O"; echo " |    "; echo " |    "; echo "_|____";;
        4) echo "  _____"; echo " |    O"; echo " |    |"; echo " |    "; echo "_|____";;
        3) echo "  _____"; echo " |    O"; echo " |   /|"; echo " |    "; echo "_|____";;
        2) echo "  _____"; echo " |    O"; echo " |   /|\\"; echo " |    "; echo "_|____";;
        1) echo "  _____"; echo " |    O"; echo " |   /|\\"; echo " |   / "; echo "_|____";;
        0) echo "  _____"; echo " |    O"; echo " |   /|\\"; echo " |   / \\"; echo "_|____";;
    esac
}

# Mostrar la palabra con letras adivinadas
mostrar_palabra() {
    for ((i=0; i<${#palabra}; i++)); do
        letra=${palabra:i:1}
        [[ " ${letras_adivinadas[@]} " =~ " $letra " ]] && echo -n "$letra" || echo -n "_"
    done
    echo
}

# Bucle principal
while (( intentos > 0 )); do
    clear
    echo "=== AHORCADO ==="
    dibujar_ahorcado
    echo
    echo "Palabra: $(mostrar_palabra)"
    echo "Intentos restantes: $intentos"
    echo "Letras incorrectas: ${letras_incorrectas[*]}"
    
    # Verificar si ganó
    if ! mostrar_palabra | grep -q "_"; then
        echo "¡Ganaste! La palabra era: $palabra"
        exit 0
    fi
    
    # Pedir letra
    read -p "Introduce una letra: " -n 1 letra
    echo
    
    # Validar letra
    if [[ " ${letras_adivinadas[@]} ${letras_incorrectas[@]} " =~ " $letra " ]]; then
        echo "Ya usaste esa letra"
        sleep 1
        continue
    fi
    
    # Verificar letra
    if [[ "$palabra" == *"$letra"* ]]; then
        letras_adivinadas+=("$letra")
        echo "¡Correcto!"
    else
        letras_incorrectas+=("$letra")
        ((intentos--))
        echo "Incorrecto"
    fi
    
    sleep 1
done

# Si llega aquí, perdió
clear
dibujar_ahorcado
echo "¡Perdiste! La palabra era: $palabra"