#!/bin/bash

function muestraayuda() {
  echo -e "\e[1mNOMBRE\e[0m"
  echo -e "\t generaovalo - Dibuja un óval en una posición aleatoria sobre un fotograma. En caso de no indicarle la imagen sobre la que trabajar, genera un fondo transparente de 1920x1080 pixeles"
  echo ""
  echo -e "\e[1mSINOPSIS\e[0m"
  echo -e "\t generaovalo imagendefondo.png"
  echo -e "\t generaovalo "
  echo ""
  echo -e "\e[1mDESCRIPCIÓN\e[0m"
  echo -e "\t \e[1mgeneraovalo\e[0m Genera una sucesión de imágenes con un óvalo creciente."
  echo ""
  echo -e "\t La posición del centro del óvalo es aleatoria. Se le suma el radio, por lo que puede que parte del óvalo se quede fuera."
  echo ""

}

function generaovalo() {
  #statements

  if [[ -f $1 ]]
  then
    imagen1=$1
  else
    convert -size 1920x1080 xc:Transparent fondotransparente.png
    imagen1="fondotransparente.png"
  fi

  let anchura=$(identify -format %w $imagen1)
  let altura=$(identify -format %h $imagen1)

  # Mismo valor para los dos primeros valores de -draw
  # Para que en lugar de óvalo, sea un círculo.
  valor1=$(shuf -i 0-$anchura -n 1)
  valor2=$(shuf -i 0-$altura -n 1)

  # Posición aleatoria XxY
  valor3=$(shuf -i 0-$anchura -n 1)
  valor4=$(shuf -i 0-$altura -n 1)

  grados1=$(shuf -i 0-90 -n 1)

  numerodefotogramas=$(shuf -i 5-25 -n 1)

  let rellenar=360-$grados1
  let crecimiento=$rellenar/$numerodefotogramas

  grosor=$(shuf -i 5-15 -n 1)

  color1=$(convert -list color | cut -f 1 -d " " | shuf -n 1)
  let grados2=$grados1

  for i in `seq 0 $numerodefotogramas`
  do
    let grados2=$grados2+$crecimiento
    instruccion="convert "$imagen1" -fill Transparent -stroke "$color1" -strokewidth "$grosor" -draw 'arc "$valor1","$valor2" "$valor3","$valor4" "$grados1","$grados2"' generacirculo_"$i".png"
    eval $instruccion

  done
}

if [ "$1" == "-h" ] || [ "$1" == "ayuda" ]
then
  muestraayuda
elif [[ -f $1 ]]
  generaovalo $1
else 
  generaovalo
fi
