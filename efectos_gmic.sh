#!/bin/bash

# Funciones para comprobar efectos de G'MIC

function unporcentaje() {
  #statements
  for i in $(seq 1 100)
  do
    # gmic -input $1 -glow $i"% -output glow"$i".png"
    # gmic -input $1 -edges $i"% -output edges"$i".png"
    gmic -input $1 "split x move["$i"%--1:2] 0 append x  -output split_move_append"$i".jpg"
    gmic -input $1 "split x keep[0-"$i"%:2] append x -output  split"$i".jpg"
    gmic -input $1 "split x remove["$i"%-50%] append x  -output remove_primer_porcentaje_"$i"-50.jpg"
    gmic -input $1 "split x remove[50%-"$i"%] append x  -output remove_segundo_porcentaje_50-"$i".jpg"
    gmic -input $1 round $i -output "round_"$i".jpg"
    gmic -input $1 xor $i -output "xor_"$i".jpg"

    gmic -input $1 -blur $i"% -output blur_"$i"_porciento.jpg"
    gmic -input $1 -blur_xy $i" -output blur_xy_"$i".jpg"
    gmic -input $1 -blur_z $i" -output blur_z_"$i".jpg"
  done

}

function efecto_acordeon() {
  # Recibe una imagen, la divide en un número aleatorio de partes y los desordena ligeramente alterando de dos en dos contiguos
  valor=$(shuf -i 1-100 -n 1)
  gmic -input $1 split x,-$valor reverse[0%-100%] append x -output "reverse-"$valor".jpg"

}


function reverse_10() {
  #statements
  valores=$(shuf -i 1-10 -n 6)
  valor1=$(echo $valores | cut -d" " -f 1)
  valor2=$(echo $valores | cut -d" " -f 2)
  valor3=$(echo $valores | cut -d" " -f 3)
  valor4=$(echo $valores | cut -d" " -f 4)
  valor5=$(echo $valores | cut -d" " -f 5)
  valor6=$(echo $valores | cut -d" " -f 6)
  valores="-"$valor1",-"$valor2
  valores2="-"$valor3",-"$valor4
  valores3="-"$valor5",-"$valor6

  gmic -input $1 split x,10 reverse[$valores] reverse[$valores2] reverse[$valores3] append x -output reverse-aleatorio.jpg
}

function unvalor() {
  #statements
  for i in $(seq 1 100)
  do
    gmic -input $1 -warp $i" -output warp_"$i".png"
    gmic -input $1 blur $i" -output blur_"$i".png"
    gmic -input $1 and {$i} -output "and_"$i".jpg"
    gmic -input $1 -noise $i -output "noise_"$i".jpg"

    # Estudiar este corte con otros valores
    gmic -input $1 shift 50%,50%,0,0,2  -output "fft_complex2polar5.jpg"


  done

}

function espejos() {
  gmic -input $1 +mirror x and -output "mirror_x_and.jpg"
  gmic -input $1 +mirror x max -output "mirror_x_max.jpg"
  gmic -input $1 +mirror x min -output "mirror_x_min.jpg"
  gmic -input $1 +mirror x mod -output "mirror_x_mod.jpg"
  gmic -input $1 +mirror x xor -output "mirror_x_xor.jpg"
  gmic -input $1 +mirror x sub -output "mirror_x_sub.jpg"



}

function dosvalores() {
  #statements
  for i in $(seq 1 10 100)
  do
    for x in $(seq 1 10 100)
    do
      gmic -input $1 -boxfitting $i","$x" -output boxfitting"$i"_"$x".png"
      gmic -input $1 -circlism $i","$x" -output circlism"$i"_"$x".png"
      gmic -input $1 -bandpass $i","$x" -output bandpass"$i"_"$x".png"
      gmic -input $1 -normalize $i","$x" -output normalize"$i"_"$x".png"
      gmic -input $1 diffusiontensors $i","$x" -output diffusiontensors"$i"_"$x".png"
      gmic -input $1 tensors $i","$x" -output tensors"$i"_"$x".png"
      gmic -input $1 -n $i","$x  -output "n"$i"_"$x".png"
      gmic -input $1 -denoise $i","$x -output "denoise"$i"_"$x".jpg"
      gmic -input $1 normalize_local $i","$x -output "normalize_local_"$i"_"$x".jpg"
      gmic -input $1 "+luminance ge. {"$i"-"$x"}% mul  -output luminance_ge_"$i"_"$x".jpg"
      gmic $image -to_rgb -luminance -- {iM/2} -abs -negate -n 0,255 -output torgblumince.jpg
    #  gmic -input $1 cut $i","$x -output "cut"$i"-"$x".jpg"
    #  gmic -input $1 +blur $i normalize $i","$x add[1,0] -output "blur_normailze_add_"$i"-"$x".jpg"
    #  gmic -input $1 and {$i"+"$x} -output "and"$i"-"$x".jpg"

    done
  done
}

function multiefectos() {
  #statements
  gmic -input $1 rodilius 10,4,400,16 smooth 60,0,1,1,4 normalize_local 10,16 -output world_rodilius.jpg
  gmic -input $1 -fx_brushify 8,0.25,4,64,25,12,0,2,4,0.2,0.5,30,1,1,1,5,0,0,0.2,0 -output fx_brushify.jpg
  gmic -input $1 split c reverse add[0-2] -blur 5 rodilius 10,4,400,16 smooth 60,0,1,1,4 normalize_local 10,16 -output union_split_c_reverse3.jpg
  gmic -input $1 split c reverse add[0-2] -blur 5 -output union_split_c_reverse4.jpg


}



function valoresaleatorios() {
  #statements
  for i in $(seq 1 10)
  do
    v1=$(shuf -i 0-100 -n 1)
    v2=$(shuf -i 0-100 -n 1)
    v3=$(shuf -i 0-100 -n 1)
    v4=$(shuf -i 0-100 -n 1)
    v5=$(shuf -i 0-100 -n 1)
    v6=$(shuf -i 0-100 -n 1)
    v7=$(shuf -i 0-100 -n 1)
    v8=$(shuf -i 0-100 -n 1)
    v9=$(shuf -i 0-100 -n 1)
    v10=$(shuf -i 0-100 -n 1)
    v11=$(shuf -i 0-100 -n 1)
    v12=$(shuf -i 0-100 -n 1)
    v13=$(shuf -i 0-100 -n 1)
    v14=$(shuf -i 0-100 -n 1)
    v15=$(shuf -i 0-100 -n 1)
    v16=$(shuf -i 0-100 -n 1)
    v17=$(shuf -i 0-100 -n 1)
    v18=$(shuf -i 0-100 -n 1)
    v19=$(shuf -i 0-100 -n 1)
    v20=$(shuf -i 0-100 -n 1)

    sufijo1=$v1"-"$v2"-"$v3"-"$v4"-"$v5"-"$v6"-"$v7"-"$v8"-"$v9"-"$v10"-"$v11
    sufijo2=$v1"-"$v2"-"$v3"-"$v4"-"$v5"-"$v6"-"$v7"-"$v8"-"$v9"-"$v10"-"$v11"-"$v12"-"$v13"-"$v14"-"$v15"-"$v16"-"$v17"-"$v18"-"$v19"-"$v20

    gmic -input $1 rodilius $v1","$v2","$v3","$v4" smooth "$v5","$v6","$v7","$v8","$v9" normalize_local "$v10","$v11" -output world_rodilius_"$sufijo1".jpg"
    gmic -input $1 -fx_brushify $v1","$v2","$v3","$v4","$v5","$v6","$v7","$v8","$v9","$v10","$v11","$v12","$v13","$v14","$v15","$v16","$v17","$v18","$v19","$v20" -output fx_brushify_"$sufijo2".jpg"
  done
}



function alteraciones_de_canal() {
  # Ordenar aleatoriamente los canales RGBA
  # O darle un valor distinto
  gmic -input $1 f "[A,G,B,A]" o output1.png
  gmic -input $1 f "[R,B,B,A]" o output2.png
  gmic -input $1 f "[R,G,G,A]" o output3.png
  gmic -input $1 f "[R,G,B,R]" o output4.png
  gmic -input $1 f "[R*0.707,G,B,A]" o output5.png
  gmic -input $1 f "[R,255-G,B,A]" o output6.png
  gmic -input $1 f "[R,G,B/2+128,A]" o output7.png
}


function modificaciones_de_canal() {
  #statements
  gmic -input $1 sh[0] 0 f. i3\#-2 rm. -output r7.jpg
  gmic -input $1 sh[0] 1 f. i2\#-2 rm. -output r2.jpg
  gmic -input $1 sh[0] 2 f. i1\#-2 rm. -output r3.jpg
  gmic -input $1 sh[0] 2 f. i1\#-2 rm. -output r4.jpg
  gmic -input $1 sh[0] 0 *. .707 rm. -output r5.jpg
  gmic -input $1 sh[0] 1 f. 255-i rm. -output r6.jpg
  gmic -input $1 sh[0] 1 f. i/2+128 rm. -output r7.jpg
  gmic -input $1 sh[0] 1 f. i/2+128 rm. o output.png
}


function cincovalores() {
  #statements
  for i in $(seq 1 50 300)
  do
    for w in $(seq 1 50 300)
    do
      for x in $(seq 1 50 300)
      do
        for y in $(seq 1 50 300)
        do
          for z in $(seq 1 50 300)
          do
            gmic -input $1 -hardsketchbw $i","$w","$x","$y","$z" -output hardsketchbw"$i"_"$w"_"$x"_"$y"_"$z".png"
            gmic -input $1 -rodilius $i","$w","$x","$y","$z" -output rodilius"$i"_"$w"_"$x"_"$y"_"$z".png"
            gmic -input $1 smooth $i","$w","$x","$y","$z -output smooth_$i"_"$w"_"$x"_"$y"_"$z".png"
            gmic -input $1 shift $i"%,"$w"%,"$x","$y","$z  -output "fft_complex2polar5.jpg"

          done
        done
      done
    done
  done

}

function sinvalor() {
  #statements
  gmic -input $1 cosh -output "cosh.jpg"
  gmic -input $1 tan -output "tan.jpg"
  gmic -input $1 resize2dy -output "resize2dy.jpg"
  gmic -input $1 xor 128 -output "xor_128.jpg"
  gmic -input $1 -gradient_norm -output gradient_norm.jpg
  gmic -input $1 -sqr -output sqr.jpg
  gmic -input $1 hsv2rgb -output hsv2rgb.jpg
  gmic -input $1 map_clut analogfx_soft_sepia_ii -output mapeado_sepia.jpg
  gmic -input $1 -negative -output negative.jpg
  gmic -input $1 split c reverse blend[0-2] average -output union_split_c_reverse.jpg
  gmic -input $1 -to_rgb -luminance -- {iM/2} -abs -negate -n 0,255 -output torgblumince.jpg
}

function tresvalores() {
  #statements
  for x in $(seq 1 10 100)
  do
    for y in $(seq 1 10 100)
    do
      for z in $(seq 1 10 100)
      do
        gmic -input $1 -index $x","$y","$z -output "index_"$x"_"$y"_"$z".jpg"
        gmic -input $1 -colormap $x","$y","$z -output colormap_$x"_"$y"_"$z".jpg"
        gmic -input $1 -gradient_norm -b $x -n $y","$z" -output gradientblur_"$x"_"$y"_"$z".jpg"


      done
    done
  done

  gmic -input $1  -index 6,1,1 -output index_6161.jpg
}

function rangos_mul() {
  #statements
  for i in $(seq 0 30 300)
  do
    gmic -input $1 mul $i "-output mul_"$i".jpg"
  done

  for i in $(seq 0 99)
  do
    gmic -input $1" -mul 0."$i" -output mul_0_"$i".jpg"
  done
}

function recortar() {
  #statements
  gmic $image  -crop 5%,5%,95%,95% -output crop.jpg
}



function tresvaloresconnegativos() {
  #statements

  for x in $(seq -100 10 100)
  do
    for y in $(seq -100 10 100)
    do
      for z in $(seq -100 10 100)
      do
        gmic -input $1 -adjust_colors $x","$y","$z -output "adjust_colors_"$x"_"$y"_"$z".jpg"

      done
    done
  done
}


function cuatrovalores() {
  #statements
  for i in $(seq 1 10 100)
  do
    for x in $(seq 1 10 100)
    do
      for y in $(seq 1 30 500)
      do
        for z in $(seq 1 10 100)
        do
          gmic -input $1 rodilius $i","$x","$y","$z -output "rodilius_"$i"_"$x"_"$y"_"$z".jpg"
          gmic -input $1 -emboss_image $i","$x","$y","$z" -output emboss_image"$i"_"$x"_"$y"_"$z".jpg"
        done
      done
    done
  done
}

function grados() {
  #statements
  for z in $(seq 1 10 100)
  do
    gmic -input $1 -rotate $z -output "rotate-"$z".jpg"

  done


}



imagen=$1


espejos $imagen
unporcentaje $imagen
efecto_acordeon $imagen
reverse_10 $imagen
unvalor $imagen
dosvalores $imagen
tresvalores $imagen
tresvaloresconnegativos $imagen
cincovalores $imagen
sinvalor $imagen
grados $imagen
rangos_mul $imagen
alteraciones_de_canal $imagen
modificaciones_de_canal $imagen
unporcentaje $imagen
efecto_acordeon $imagen
reverse_10 $imagen
multiefectos $imagen
valoresaleatorios $imagen
recortar $imagen
