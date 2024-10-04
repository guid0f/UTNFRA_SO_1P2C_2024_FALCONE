#!/bin/bash

# Variables
DISCO="/dev/sdc"  # Reemplazar con el disco correcto, ej. /dev/sda
MONTAJE_BASE="/Examenes-UTN"
PARTICIONES=10
TAMANIO_PARTICION="1G"  # Tamaño aproximado por partición

# 1. Crear las 10 particiones
for i in $(seq 1 $PARTICIONES); do
    echo "Creando partición $i"
    parted $DISCO mkpart primary ext4 $((($i - 1) * $TAMANIO_PARTICION))G $(($i * $TAMANIO_PARTICION))G
done

# 2. Formatear las particiones con ext4
for i in $(seq 1 $PARTICIONES); do
    mkfs.ext4 "${DISCO}${i}"
done

# 3. Crear directorios de montaje (si no se crearon antes)
mkdir -p $MONTAJE_BASE/alumno_1/parcial_1 $MONTAJE_BASE/alumno_1/parcial_2 $MONTAJE_BASE/alumno_1/parcial_3
mkdir -p $MONTAJE_BASE/alumno_2/parcial_1 $MONTAJE_BASE/alumno_2/parcial_2 $MONTAJE_BASE/alumno_2/parcial_3
mkdir -p $MONTAJE_BASE/alumno_3/parcial_1 $MONTAJE_BASE/alumno_3/parcial_2 $MONTAJE_BASE/alumno_3/parcial_3
mkdir -p $MONTAJE_BASE/profesores

# 4. Montar particiones en los directorios creados de forma persistente
for i in $(seq 1 3); do
    mount "${DISCO}${i}" $MONTAJE_BASE/alumno_1/parcial_$i
    echo "${DISCO}${i} $MONTAJE_BASE/alumno_1/parcial_$i ext4 defaults 0 0" >> /etc/fstab
done

for i in $(seq 4 6); do
    mount "${DISCO}${i}" $MONTAJE_BASE/alumno_2/parcial_$((i-3))
    echo "${DISCO}${i} $MONTAJE_BASE/alumno_2/parcial_$((i-3)) ext4 defaults 0 0" >> /etc/fstab
done

for i in $(seq 7 9); do
    mount "${DISCO}${i}" $MONTAJE_BASE/alumno_3/parcial_$((i-6))
    echo "${DISCO}${i} $MONTAJE_BASE/alumno_3/parcial_$((i-6)) ext4 defaults 0 0" >> /etc/fstab
done

# Montar la última partición en profesores
mount "${DISCO}10" $MONTAJE_BASE/profesores
echo "${DISCO}10 $MONTAJE_BASE/profesores ext4 defaults 0 0" >> /etc/fstab

echo "Particiones creadas, formateadas y montadas de forma persistente."
