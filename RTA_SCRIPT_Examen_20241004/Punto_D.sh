#!/bin/bash

# Crear el directorio principal
mkdir -p ~/Estructura_Asimetrica/{correo,clientes}

# Crear los archivos cartas_1 a cartas_100 en ambos directorios
for i in {1..100}; do
    touch ~/Estructura_Asimetrica/correo/cartas_$i
    touch ~/Estructura_Asimetrica/clientes/cartas_$i
done

# Crear el directorio carteros dentro de correo
mkdir -p ~/Estructura_Asimetrica/correo/carteros

# Crear los archivos carteros_1 a carteros_10 en la carpeta carteros
for i in {1..10}; do
    touch ~/Estructura_Asimetrica/correo/carteros/carteros_$i
done
