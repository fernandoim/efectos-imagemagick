#!/bin/bash

# Genera una imagen con cinco áreas con colores puros: la mitad superior con tres tercios rojo, verde y azul.
# La mitad inferior, media blanca y media negra.
# Con esta imagen, podemos ver claramente el resultado de muchos de los efectos y filtros de ImageMagick.
#
# Para los efectos que afectan a los colores intermedios, se genera otra imagen que difumina mucho los colores,
# para crear una gran gama de colores intermedios dejando unas zonas en las que se mantienen los colores puros.

# Valores por defecto para imagen en HD. Cámbiense si se quiere otro tamaño de imagen u otros nombres.

let ancho=1920
let alto=1080
imagendepruebas="imagendepruebas.png"
imagendepruebasdifuminada="imagendepruebasdifuminada.png"
mitadsuperior="mitadsuperior.png"
mitadinferior="mitadinferior.png"

# En función a los valores anteriores, se calculan las zonas a colorear.

let tercioanchura=$ancho/3
let mediaanchura=$ancho/2
let mediaaltura=$alto/2


convert -size $tercioanchura"x"$mediaaltura xc:\#ff0000 -size $tercioanchura"x"$mediaaltura xc:\#00ff00 -size $tercioanchura"x"$mediaaltura xc:\#0000ff +append $mitadsuperior
convert -size $mediaanchura"x"$mediaaltura xc:\#ffffff -size $mediaanchura"x"$mediaaltura xc:\#000000 +append $mitadinferior
convert $mitadsuperior $mitadinferior -append $imagendepruebas
convert $imagendepruebas -blur 0x300 $imagendepruebasdifuminada


rm $mitadsuperior
rm $mitadinferior
