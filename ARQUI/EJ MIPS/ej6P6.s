.data
coorX: .byte 0 ; coordenada X de un punto
coorY: .byte 0 ; coordenada Y de un punto
color: .byte 0, 0, 0, 0 ; color: máximo rojo 
CONTROL: .word32 0x10000
DATA: .word32 0x10008
.text
lwu $s6, CONTROL($zero) ; $s6 = dirección de CONTROL
lwu $s7, DATA($zero) ; $s7 = dirección de DATA
daddi $t0, $zero, 7 ; $t0 = 7 -> función 7: limpiar pantalla gráfica
sd $t0, 0($s6) ; CONTROL recibe 7 y limpia la pantalla gráfica
daddi $t1,$0,8 ;codigo escribir numero
sd $t1,0($s6) ;mandamos a control pra escribir num
ld $t2,0($s7) ;guardamos en t2 el numero
dadd $s0,$t2,$0 ; $s0 = valor de coordenada X
sb $s0, 5($s7) ; DATA+5 recibe el valor de coordenada X
sd $t1,0($s6)
sd $t3,0($s7)
dadd $s1,$0,$t3 ; $s1 = valor de coordenada Y
sb $s1, 4($s7) ; DATA+4 recibe el valor de coordenada Y
daddi $t5,$0,0 ;desplzamiento
daddi $t6,$0,4 ;cant
loop: sd $t1,0($s6) ;guardamos codigo en control
      ld $t4,0($s7) ;cargamos el numero en t4
      sd $t4,color($t5) ; el numero lo ponemos en el vector
      daddi $t5,$t5,1 ;pasamos al sig elem
      daddi $t6,$t6,-1 ;restamos elemento
      bnez $t6,loop
daddi $s2,$0,color
sw $s2, 0($s7) ; DATA recibe el valor del color a pintar
daddi $t0, $zero, 5 ; $t0 = 5 -> función 5: salida gráfica
sd $t0, 0($s6) ; CONTROL recibe 5 y produce el dibujo del punto
halt