#!/bin/bash

# Formato de fecha: YYYY-MM-DD
fecha=$(printf '%(%d-%m-%Y)T' -1)

# Formato de hora: HH:MM:SS
hora=$(printf '%(%H:%M:%S)T' -1)
echo
echo "Fecha actual: $fecha"
echo "Hora actual:  $hora"

