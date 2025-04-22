#!/bin/bash

./login.sh

if [ $? -eq 0 ]; then
    ./terminal.sh

else
    echo "Error al iniciar sesion. Saliendo."
    exit 1

fi