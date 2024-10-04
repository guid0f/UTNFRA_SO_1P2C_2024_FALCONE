#!/bin/bash

sudo groupadd p1c2_2024_gAlumno
sudo groupadd p1c2_2024_gProfesores

# Crear usuarios con sus grupos secundarios
sudo useradd -m -G p1c2_2024_gAlumno -s /bin/bash p1c2_2024_A1
sudo useradd -m -G p1c2_2024_gAlumno -s /bin/bash p1c2_2024_A2
sudo useradd -m -G p1c2_2024_gAlumno -s /bin/bash p1c2_2024_A3
sudo useradd -m -G p1c2_2024_gProfesores -s /bin/bash p1c2_2024_P1

# Asignar las contraseñas a los usuarios
echo "p1c2_2024_A1:1234" | sudo chpasswd
echo "p1c2_2024_A2:$(openssl passwd -1 '1234')" | sudo chpasswd
echo "p1c2_2024_A3:$(openssl passwd -1 '1234')" | sudo chpasswd
echo "p1c2_2024_P1:$(openssl passwd -1 '1234')" | sudo chpasswd

# Crear las carpetas
sudo mkdir -p /Examenes-UTN/alumno_1
sudo mkdir -p /Examenes-UTN/alumno_2
sudo mkdir -p /Examenes-UTN/alumno_3
sudo mkdir -p /Examenes-UTN/profesores

# Asignar propietarios y permisos

# alumno_1 (Dueño todo, grupo lectura y ejecución, otros nada)
sudo chown p1c2_2024_A1:p1c2_2024_A1 /Examenes-UTN/alumno_1
sudo chmod 750 /Examenes-UTN/alumno_1

# alumno_2 (Dueño rwx, grupo rw-, otros nada)
sudo chown p1c2_2024_A2:p1c2_2024_A2 /Examenes-UTN/alumno_2
sudo chmod 760 /Examenes-UTN/alumno_2

# alumno_3 (Dueño todo, grupo y otros nada)
sudo chown p1c2_2024_A3:p1c2_2024_A3 /Examenes-UTN/alumno_3
sudo chmod 700 /Examenes-UTN/alumno_3

# profesores (Dueño y grupo rwx, otros lectura y ejecución)
sudo chown p1c2_2024_P1:p1c2_2024_gProfesores /Examenes-UTN/profesores
sudo chmod 775 /Examenes-UTN/profesores

# Crear archivo de validación
echo "Validación de usuarios y carpetas" > validar.txt
for usuario in p1c2_2024_A1 p1c2_2024_A2 p1c2_2024_A3 p1c2_2024_P1; do
    sudo -u $usuario bash -c "echo '$usuario: $(whoami)' >> validar.txt"
done

echo "Proceso completado. Revisa el archivo validar.txt para verificar los permisos."
