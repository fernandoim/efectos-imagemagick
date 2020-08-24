#!/bin/bash

function muestraayuda() {
  echo -e "\e[1mNOMBRE\e[0m"
  echo -e "\t manchaanitido - Genera una secuencia de imágenes desde un conjuntos de manchas borrosas a la imagen nítida. Si se le indica la opción «video» o «-l», esta secuencia de imágenes se convierte en vídeo."
  echo ""
  echo -e "\e[1mSINOPSIS\e[0m"
  echo -e "\t manchaanitido imagen.png 24"
  echo -e "\t manchaanitido -v imagen.png 24"
  echo ""
  echo -e "\e[1mOPCIONES\e[0m"
  echo -e "\t \e[1mmanchaanitido\e[0m necesita una imagen sobre la que aplicar las modificaciones. Opcionalmente, acepta los parámetros más:"
  echo ""
  echo -e "\t \t-v o video: Si se indica cualquieras de estos dos parámetros, el resultado será un vídeo desde manchas a nítido."
  echo -e "\t \tnumero: Si se indica un número, será la cantidad de imágenes de la que constará la secuencia o el número de fotogramas del vídeo. Si no se indica un número de fotogramas, se utilizará un número aleatorio entre 5 y 25."
  echo ""

}


function manchaanitido() {
# Toma una imagen, la convierte en manchas de color y genera una secuencia en la que cada vez se ve esa imagen más nitida.

caracteresnumericos='^[0-9]+$'

if [[ -f $1 ]]
then
  imagen=$1
elif [[ $1 =~ $caracteresnumericos ]]
then
  numerodefotogramas=$1
fi
if [[ -f $2 ]]
then
  imagen=$2
elif [[ $2 =~ $caracteresnumericos ]]
then
  numerodefotogramas=$2
fi

if [ -z "$imagen" ]
then
    echo "Es necesario que indique un fichero sobre el que aplicar los filtros."
    exit -1
elif [ -z "$numerodefotogramas" ]
then
    numerodefotogramas=$(shuf -i 5-25 -n 1)
fi

let numeral=0
let contador=0

    for i in `seq $numerodefotogramas -1 0`
    do
      if [[ $numerodefotogramas -gt 9 ]] && [[ $numeral -lt 10 ]]
      then
        numeral="0"$numeral
      fi
      if [[ $i -ne 0 ]]
      then
        convert $1 -paint $i -blur "0x"$i "manchaanitido_"$numeral".png"
      else
        convert $1 "manchaanitido_"$numeral".png"
      fi
      let contador=$contador+1
      let numeral=$contador
    done
}

function manchaanitido_video() {
# Toma una imagen, la convierte en manchas de color y genera una secuencia en la que cada vez se ve esa imagen más nitida.

caracteresnumericos='^[0-9]+$'

if [[ -f $1 ]]
then
  imagen=$1
elif [[ $1 =~ $caracteresnumericos ]]
then
  numerodefotogramas=$1
fi
if [[ -f $2 ]]
then
  imagen=$2
elif [[ $2 =~ $caracteresnumericos ]]
then
  numerodefotogramas=$2
fi

if [ -z "$imagen" ]
then
    echo "Es necesario que indique un fichero sobre el que aplicar los filtros."
    exit -1
elif [ -z "$numerodefotogramas" ]
then
    numerodefotogramas=$(shuf -i 5-25 -n 1)
fi
sinextension="${imagen%.*}"

    for i in `seq $numerodefotogramas -1 0`
    do
      if [[ $i -ne 0 ]]
      then
        convert $imagen -paint $i -blur "0x"$i png:-
      else
        convert $imagen png:-
      fi
    done | ffmpeg -f image2pipe -i - $sinextension"_manchaanitido.mp4"
}

for parametro in "$@"
do
    if [ "$parametro" == "ayuda" ] || [ "$parametro" == "-h" ]
    then
        muestraayuda
        exit 0
    fi
    if [ "$parametro" == "video" ] || [ "$parametro" == "-v" ]
    then
        shift
        video=1
    fi

    if [ $video ]
    then
      manchaanitido_video $1 $2
    else
      manchaanitido $1 $2
    fi

done
