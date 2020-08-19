#!/bin/bash

function muestraayuda() {
  echo -e "\e[1mNOMBRE\e[0m"
  echo -e "\t listaentrenumeros - Genera una lista entre dos números cualesquiera, sean estos positivos, negativos, con decimales o sin ellos."
  echo ""
  echo -e "\e[1mSINOPSIS\e[0m"
  echo -e "\t listaentrenumeros 4 95"
  echo ""
  echo -e "\e[1mDESCRIPCIÓN\e[0m"
  echo -e "\t \e[1mlistaentrenumeros\e[0m Genera una lista de números consecutivos entre dos números dados."
  echo ""
  echo -e "\t Si uno de esos números tiene decimales, se generará una lista con tantas cifras decimales como el número con mayor cifra de decimales."
  echo -e "\t Si el número de cifras detrás del punto es distinto en los dos números, se igualarán a la mayor cantidad de dígitos tras el punto."
  echo -e "\t La sucesión se genera en función de esas cifras."
  echo ""

}

function listasindecimales(){

  # Recibe uno o dos parámetros y comprueba si son numéricos:
  # Si son dos parámetros numéricos, sean positivos o negativos, genera una lista de enteros entre ellos.
  # Si es un único parámetro:
    # si es positivo genera una lista desde el valor del parámetro hasta cero.
    # Si el valor es negativo, desde cero hasta el valor del parámetro.
  caracteresnumericos='^-?[0-9]+$'
  if [[ $1 =~ $caracteresnumericos ]] && [[ $2 =~ $caracteresnumericos ]]
  then
    if [ $1 -lt $2 ]
    then
      for i in `seq $1 $2`
      do
        listado=("${listado[@]}" $i)
      done
    else
      for i in `seq $1 -1 $2`
      do
        listado=("${listado[@]}" $i)
      done
    fi
  elif [[ $1 =~ $caracteresnumericos ]] && [[ ! $2 ]]
  then
    if [ $1 -lt 0 ]
    then
      for i in `seq $1 0`
      do
        listado=("${listado[@]}" $i)
      done
    else
      for i in `seq $1 -1 0`
      do
        listado=("${listado[@]}" $i)
      done
    fi
  fi


  for i in ${listado[@]}
  do
    echo "$i"
  done
}

function listacondecimales() {
  menor=$(cualesmenor $1 $2)
  if [[ $menor -eq 0 ]]
  then
    echo $1
    exit 0
  else
    arraynumero1=(${1//./ })
    arraynumero2=(${2//./ })
    if [[ ${#arraynumero1[1]} -gt ${#arraynumero2[1]} ]]
    then
      let diferencia=${#arraynumero1[1]}-${#arraynumero2[1]}
      for i in `seq 1 $diferencia`
      do
        arraynumero2[1]=${arraynumero2[1]}"0"
      done
    elif [[ ${#arraynumero1[1]} -lt ${#arraynumero2[1]} ]]
    then
      let diferencia=${#arraynumero2[1]}-${#arraynumero1[1]}
      for i in `seq 1 $diferencia`
      do
        arraynumero1[1]=${arraynumero1[1]}"0"
      done
    fi
    if [[ $menor -eq 1 ]]
    then

      # Numeración ascendente

      entero1=${arraynumero1[0]}
      entero2=${arraynumero2[0]}
      decimal1=${arraynumero1[1]}
      decimal2=${arraynumero2[1]}
      if [[ $entero1 -eq $entero2 ]]
      then
        for i in `seq $decimal1 $decimal2`
        do
          echo $entero1"."$i
        done
      else
        limite="1"
        if [[ ${#arraynumero1[1]} -ge ${#arraynumero2[1]} ]]
        then
          for i in `seq 1 ${#arraynumero1[1]}`
          do
            limite=$limite"0"
          done
        else
          for i in `seq 1 ${#arraynumero2[1]}`
          do
            limite=$limite"0"
          done
        fi
        let limite=$limite-1
        for i in `seq $decimal1 $limite`
        do
          if [[ ${#i} -lt ${#limite} ]]
          then
            let ceros=${#i}-${#limite}
            for x in `seq 1 $ceros`
            do
              decimales="0"$i
            done
          else
            decimales=$i
          fi
          echo $entero1"."$decimales
        done
        let entero1=$entero1+1
        while [[ $entero1 -lt $entero2 ]]
        do
          for i in `seq 0 $limite`
          do
            if [[ ${#i} -lt ${#limite} ]]
            then
              let ceros=${#i}-${#limite}
              for x in `seq 1 $ceros`
              do
                decimales="0"$i
              done
            else
              decimales=$i
            fi
            echo $entero1"."$decimales
          done
          let entero1=$entero1+1
        done
        for i in `seq 0 $decimal2`
        do
          if [[ ${#i} -lt ${#limite} ]]
          then
            let ceros=${#i}-${#limite}
            for x in `seq 1 $ceros`
            do
              decimales="0"$i
            done
          else
            decimales=$i
          fi
          echo $entero1"."$decimales
        done
      fi

    else

       # Numeración descendiente

             entero1=${arraynumero1[0]}
             entero2=${arraynumero2[0]}
             decimal1=${arraynumero1[1]}
             decimal2=${arraynumero2[1]}

             # La parte entera es igual. Sólo cambian los decimales.

             if [[ $entero1 -eq $entero2 ]]
             then
               for i in `seq $decimal1 -1 $decimal2`
               do
                 echo $entero1"."$i
               done
             else

               # La parte entera del primer parámetro es mayor que la parte entera del segundo parámetro.

               limite="1"
               if [[ ${#arraynumero2[1]} -ge ${#arraynumero1[1]} ]]
               then
                 for i in `seq ${#arraynumero1[1]} -1 1`
                 do
                   limite=$limite"0"
                 done
               else
                 for i in `seq ${#arraynumero1[1]} -1 1`
                 do
                   limite=$limite"0"
                 done
               fi
               let limite=$limite-1
               for i in `seq $decimal1 -1 0`
               do
                 if [[ ${#i} -lt ${#limite} ]]
                 then
                   let ceros=${#i}-${#limite}
                   for x in `seq 1 $ceros`
                   do
                     decimales="0"$i
                   done
                 else
                   decimales=$i
                 fi
                 echo $entero1"."$decimales
               done

              # Ya ha recorrido los decimales del primer parámetro hasta dejarlo en la parte entera del primer parámetro.
              let entero1=$entero1-1
               while [[ $entero1 -gt $entero2 ]]
               do
                 for i in `seq $limite -1 0`
                 do
                   if [[ ${#i} -lt ${#limite} ]]
                   then
                     let ceros=${#i}-${#limite}
                     for x in `seq 1 $ceros`
                     do
                       decimales="0"$i
                     done
                   else
                     decimales=$i
                   fi
                   echo $entero1"."$decimales
                 done
                 let entero1=$entero1-1
               done

               # Sólo queda la última unidad. Hay que recorrer desde el límite hasta el decimal indicado.

               for i in `seq $limite -1 $decimal2`
               do
                 if [[ ${#i} -lt ${#limite} ]]
                 then
                   let ceros=${#i}-${#limite}
                   for x in `seq 1 $ceros`
                   do
                     decimales="0"$i
                   done
                 else
                   decimales=$i
                 fi
                 echo $entero1"."$decimales
               done
             fi

    fi
  fi



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


for parametro in "$@"
do
    if [ "$parametro" == "ayuda" ] || [ "$parametro" == "-h" ]
    then
        muestraayuda
        exit 0
    fi
done

# Convertir de formato decimal español / hispano a anglosajón.

coma1="${1//[^,]}"
if [[ ${#coma1} -eq 1 ]]
then
  parametro1=${1/,/.}
else
  parametro1=$1
fi
coma2="${2//[^,]}"
if [[ ${#coma2} -eq 1 ]]
then
  parametro2=${2/,/.}
else
  parametro2=$2
fi



caracteresnumericos='^-?[0-9]+$'
racionales='^-?[0-9]+([.][0-9]+)?$'
if [[ $parametro1 =~ $caracteresnumericos ]] && [[ $parametro2 =~ $caracteresnumericos ]]
then
  listasindecimales $parametro1 $parametro2
elif [[ $parametro1 =~ $racionales ]] && [[ $parametro2 =~ $racionales ]]
then
  listacondecimales $parametro1 $parametro2
else
  echo "Algo ha fallado."
  echo ""
  echo "Compruebe que ha introducido dos números con un formato correcto."
  echo ""
  exit -1
fi


