
# TerminalLinuxProtecsa

##  Proyecto Terminal Linux

Este proyecto consiste en la creación de una terminal de trabajo personalizada en **Bash** que simula un entorno de línea de comandos. El objetivo es poner en práctica los conocimientos adquiridos en el curso de Linux y demostrar habilidades de scripting, desarrollo de comandos personalizados y uso de herramientas del sistema operativo.

##  Objetivo

El proyecto tiene como finalidad desarrollar un programa que simule una terminal de trabajo. La terminal debe permitir al usuario trabajar con archivos, consultar información del sistema, reproducir música y jugar juegos desarrollados por el usuario. Los siguientes comandos son implementados:

- **Comandos personalizados**: 
  - `ayuda`: Muestra los comandos disponibles.
  - `infosis`: Muestra información del sistema (RAM, arquitectura, versión del SO).
  - `fecha`: Muestra la fecha y hora actual.
  - `buscar`: Busca archivos en un directorio específico.
  - `creditos`: Muestra los créditos del programador.
  - `juego`: Juega un juego textual (Ahorcado o Gato).
  - `mp3`: Reproductor de música con interfaz gráfica.

##  Requisitos de Instalación

Para ejecutar este proyecto, es necesario tener un sistema GNU/Linux con Bash. Asegúrate de contar con lo siguiente:

- **Bash** (v4 o superior)
- **Zenity** para la interfaz gráfica del reproductor de música (`sudo apt install zenity` en Debian/Ubuntu)
- **unzip** y **file** (`sudo apt install unzip file`)
- **Permisos de ejecución** en los scripts (`chmod +x nombre_script.sh`)

##  Instalación y Ejecución

1. Clona el repositorio:

```bash
git clone https://github.com/tuusuario/terminal-linux-yael.git
cd terminal-linux-yael
```

2. Da permisos de ejecución a los scripts:

```bash
chmod +x main.sh shell.sh comandos/*.sh
```

3. Ejecuta el script principal:

```bash
./main.sh
``` 