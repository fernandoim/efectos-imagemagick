#!/bin/bash


function muestraayuda() {
  echo -e "\e[1mNOMBRE\e[0m"
  echo -e "\t cualesmenor - Comprueba cuál de dos números pasados como parámetro es menor, sean estos enteros, con decimales, positivos o negativos."
  echo ""
  echo -e "\e[1mSINOPSIS\e[0m"
  echo -e "\t cualesmenor 5.78 -62"
  echo ""
  echo -e "\e[1mDESCRIPCIÓN\e[0m"
  echo -e "\t \e[1mcualesmenor\e[0m Toma dos números racionales como parámetro y comprueba cuál de los dos es menor."
  echo -e "\t Devuelve:"
  echo ""
  echo -e "\t 0 En caso de que ambos números sean iguales."
  echo -e "\t 1 Si el primer número es menor."
  echo -e "\t 2 Si el segundo número es menor."
  echo ""

}


function cualesmenor() {
  solonumeros='^[0-9]+$'
  if [[ $1 =~ $solonumeros ]] && [[ $2 =~ $solonumeros ]]
  then
    if [[ $1 -eq $2 ]]
    then
      menor=0
    elif [[ $1 -gt $2 ]]
    then
      menor=2
    else
      menor=1
    fi
    echo $menor
    exit 0
  fi

  racionales='^-?[0-9]+([.][0-9]+)?$'
  if [[ $1 =~ $racionales ]] && [[ $2 =~ $racionales ]]
  then
    if [[ "$1" == "$2" ]]
    then
      menor=0
    elif [[ "${1:0:1}" == "-" ]] && [[ "${2:0:1}" != "-" ]]
    then
      menor=1
    elif [[ "${1:0:1}" != "-" ]] && [[ "${2:0:1}" == "-" ]]
    then
      menor=2
    elif [[ ${1:0:1} != "-" ]] && [[ ${2:0:1} != "-" ]]
    then
      arraynumero1=(${1//./ })
      arraynumero2=(${2//./ })
      if [[ ${arraynumero1[0]} -gt ${arraynumero2[0]} ]]
      then
        menor=2
      elif [[ ${arraynumero1[0]} -lt ${arraynumero2[0]} ]]
      then
        menor=1
      else
        if [[ ${#arraynumero1[1]} -eq ${#arraynumero2[1]} ]]
        then
          if [[ ${arraynumero1[1]} -gt ${arraynumero2[1]} ]]
          then
            menor=2
          else
            menor=1
          fi
        elif [[ ${#arraynumero1[1]} -gt ${#arraynumero2[1]} ]]
        then
          let diferencia=${#arraynumero1[1]}-${#arraynumero2[1]}
          for i in `seq 1 $diferencia`
          do
            arraynumero2[1]=${arraynumero2[1]}"0"
          done
          if [[ ${arraynumero1[1]} -gt ${arraynumero2[1]} ]]
          then
            menor=2
          else
            menor=1
          fi
        else
          let diferencia=${#arraynumero2[1]}-${#arraynumero1[1]}
          for i in `seq 1 $diferencia`
          do
            arraynumero1[1]=${arraynumero1[1]}"0"
          done
          if [[ ${arraynumero1[1]} -gt ${arraynumero2[1]} ]]
          then
            menor=2
          else
            menor=1
          fi
        fi
      fi
    else
      # Ambos números son negativos
      # Aquí, el número mayor es el menor al estar más alejado de cero.
      longitud1=${#1}
      longitud2=${#2}
      sinsigno1=${1:1:$longitud1}
      sinsigno2=${2:1:$longitud2}
      arraynumero1=(${sinsigno1//./ })
      arraynumero2=(${sinsigno2//./ })

      if [[ ${arraynumero1[0]} -lt ${arraynumero2[0]} ]]
      then
        menor=2
      elif [[ ${arraynumero1[0]} -gt ${arraynumero2[0]} ]]
      then
        menor=1
      else
        if [[ ${#arraynumero1[1]} -eq ${#arraynumero2[1]} ]]
        then
          if [[ ${arraynumero1[1]} -lt ${arraynumero2[1]} ]]
          then
            menor=2
          else
            menor=1
          fi
        elif [[ ${#arraynumero1[1]} -gt ${#arraynumero2[1]} ]]
        then

          let diferencia=${#arraynumero1[1]}-${#arraynumero2[1]}


          for i in `seq 1 $diferencia`
          do
            arraynumero2[1]=${arraynumero2[1]}"0"
          done
          if [[ ${arraynumero1[1]} -lt ${arraynumero2[1]} ]]
          then
            menor=2
          else
            menor=1
          fi
        else
          let diferencia=${#arraynumero2[1]}-${#arraynumero1[1]}
          for i in `seq 1 $diferencia`
          do
            arraynumero1[1]=${arraynumero1[1]}"0"
          done
          if [[ ${arraynumero1[1]} -lt ${arraynumero2[1]} ]]
          then
            menor=2
          else
            menor=1
          fi
        fi
      fi
    fi
  else
    exit -1
  fi

echo $menor

}



if [ ! $1 ] || [ ! $2 ]
then
  echo "Para calcular qué número es menor entre dos dados, es necesario que indique dos números."
  echo "Por favor, revise la sintaxis:"
  echo ""
  echo "cualesmenor $numero1 $numero2"
  echo ""
else
  if [ "$1" == "-h" ] || [ "$1" == "ayuda" ] || [ "$2" == "-h" ] || [ "$2" == "ayuda" ]
  then
    muestraayuda
  else
    cualesmenor $1 $2
  fi
fi
