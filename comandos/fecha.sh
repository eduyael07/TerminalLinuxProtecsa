#!/bin/bash
#Comando para ajustar a la hora local: sudo timedatectl set-local-rtc 1
# Función para obtener fecha y hora desde RTC
obtener_fecha_hora() {
    local rtc_file="/proc/driver/rtc"
    local fecha_hora hora
    
    # Verificar si existe el archivo RTC
    if [[ ! -f "$rtc_file" ]]; then
        echo "Error: No se encontró el archivo RTC" >&2
        return 1
    fi

    # Extraer fecha y hora
    fecha_hora=$(awk '/rtc_date/ {print $3}' "$rtc_file" 2>/dev/null)
    hora=$(awk '/rtc_time/ {print $3}' "$rtc_file" 2>/dev/null)

    # Mostrar resultados
    printf "Fecha (RTC): %s\n" "$fecha_hora"
    printf "Hora (RTC): %s\n" "$hora"
}

# Llamar a la función principal
obtener_fecha_hora