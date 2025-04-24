#!/bin/bash

# Reproductor de Música Avanzado
# Versión mejorada con interfaz gráfica y más funcionalidades

# Configuración inicial
carpeta_musica="/home/eduardo-yjs/proyectoTerminal/musica"
temp_file="/tmp/music_player_temp.txt"
icono_reproductor="audio-x-generic"
player_command="mpg123"  # Puedes cambiarlo por tu reproductor preferido (mpg123, mplayer, etc.)

# Verificar dependencias
if ! command -v zenity &> /dev/null || ! command -v $player_command &> /dev/null; then
    echo "Error: Necesitas instalar zenity y $player_command para usar este reproductor."
    echo "En Ubuntu/Debian puedes instalarlos con:"
    echo "sudo apt install zenity mpg123"
    exit 1
fi

# Función para obtener la lista de canciones
obtener_canciones() {
    find "$carpeta_musica" -type f \( -iname "*.mp3" -o -iname "*.ogg" -o -iname "*.wav" \) | sort
}

# Función para mostrar el menú principal
mostrar_menu_principal() {
    zenity --list \
        --title="Reproductor de Música" \
        --text="Selecciona una opción:" \
        --column="Opción" \
        --width=500 \
        --height=300 \
        --window-icon="$icono_reproductor" \
        "Reproducir canción" \
        "Lista de reproducción" \
        "Reproducir aleatorio" \
        "Buscar canción" \
        "Información del reproductor" \
        "Salir"
}

# Función para mostrar la lista de canciones con selección
mostrar_lista_canciones() {
    canciones=$(obtener_canciones)
    if [ -z "$canciones" ]; then
        zenity --error \
            --title="Error" \
            --text="No se encontraron canciones en $carpeta_musica" \
            --width=300
        return 1
    fi
    
    # Mostrar lista con nombres de archivo sin la ruta
    (IFS=$'\n'; zenity --list \
        --title="Selecciona una canción" \
        --text="Canciones disponibles:" \
        --column="Canciones" \
        --width=600 \
        --height=400 \
        --window-icon="$icono_reproductor" \
        $(while read -r cancion; do basename "$cancion"; done <<< "$canciones"))
}

# Función para reproducir una canción
reproducir_cancion() {
    local cancion="$1"
    if [ ! -f "$cancion" ]; then
        zenity --error \
            --title="Error" \
            --text="No se pudo encontrar la canción: $cancion" \
            --width=400
        return 1
    fi
    
    # Mostrar información de la canción que se está reproduciendo
    (
        zenity --info \
            --title="Reproduciendo" \
            --text="Reproduciendo:\n$(basename "$cancion")" \
            --width=400 \
            --height=150 \
            --window-icon="$icono_reproductor" &
    ) 2>/dev/null
    
    # Reproducir la canción
    $player_command "$cancion" 2>/dev/null
    
    # Cerrar la ventana de información después de la reproducción
    pkill -f "zenity --info.*Reproduciendo"
}

# Función para crear una lista de reproducción
crear_lista_reproduccion() {
    canciones=$(obtener_canciones)
    if [ -z "$canciones" ]; then
        zenity --error \
            --title="Error" \
            --text="No se encontraron canciones para crear la lista" \
            --width=300
        return 1
    fi
    
    # Guardar lista temporalmente
    echo "$canciones" > "$temp_file"
    
    zenity --info \
        --title="Lista de reproducción creada" \
        --text="Se ha creado una lista con ${#canciones[@]} canciones" \
        --width=300
}

# Función para reproducir la lista de reproducción
reproducir_lista() {
    if [ ! -f "$temp_file" ]; then
        zenity --error \
            --title="Error" \
            --text="No hay lista de reproducción creada" \
            --width=300
        return 1
    fi
    
    while read -r cancion; do
        reproducir_cancion "$cancion"
    done < "$temp_file"
}

# Función para reproducir en modo aleatorio
reproducir_aleatorio() {
    canciones=($(obtener_canciones | shuf))
    if [ ${#canciones[@]} -eq 0 ]; then
        zenity --error \
            --title="Error" \
            --text="No se encontraron canciones para reproducir" \
            --width=300
        return 1
    fi
    
    for cancion in "${canciones[@]}"; do
        reproducir_cancion "$cancion"
    done
}

# Función para buscar canciones
buscar_cancion() {
    termino=$(zenity --entry \
        --title="Buscar canción" \
        --text="Introduce el nombre de la canción:" \
        --width=400)
    
    if [ -z "$termino" ]; then
        return 1
    fi
    
    resultados=$(obtener_canciones | grep -i "$termino")
    if [ -z "$resultados" ]; then
        zenity --info \
            --title="Resultados de búsqueda" \
            --text="No se encontraron canciones con '$termino'" \
            --width=300
        return 1
    fi
    
    seleccion=$(IFS=$'\n'; zenity --list \
        --title="Resultados de búsqueda" \
        --text="Canciones encontradas:" \
        --column="Canciones" \
        --width=600 \
        --height=400 \
        $(while read -r cancion; do basename "$cancion"; done <<< "$resultados"))
    
    if [ -n "$seleccion" ]; then
        cancion=$(echo "$resultados" | grep -i -m1 "$seleccion")
        reproducir_cancion "$cancion"
    fi
}

# Función para mostrar información del reproductor
mostrar_info() {
    total_canciones=$(obtener_canciones | wc -l)
    zenity --info \
        --title="Información del Reproductor" \
        --text="Reproductor de Música\n\nVersión: 2.0\nCarpeta de música: $carpeta_musica\nCanciones disponibles: $total_canciones" \
        --width=400 \
        --height=200 \
        --window-icon="$icono_reproductor"
}

# Bucle principal del reproductor
while true; do
    opcion=$(mostrar_menu_principal)
    
    case "$opcion" in
        "Reproducir canción")
            cancion_seleccionada=$(mostrar_lista_canciones)
            if [ -n "$cancion_seleccionada" ]; then
                # Obtener la ruta completa de la canción seleccionada
                cancion=$(obtener_canciones | grep -i -m1 "$cancion_seleccionada")
                reproducir_cancion "$cancion"
            fi
            ;;
        "Lista de reproducción")
            crear_lista_reproduccion && reproducir_lista
            ;;
        "Reproducir aleatorio")
            reproducir_aleatorio
            ;;
        "Buscar canción")
            buscar_cancion
            ;;
        "Información del reproductor")
            mostrar_info
            ;;
        "Salir"|"")
            exit 0
            ;;
        *)
            zenity --error \
                --title="Error" \
                --text="Opción no válida" \
                --width=300
            ;;
    esac
done