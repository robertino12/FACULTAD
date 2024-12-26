.data
dir_control: .word32 0x10000
dir_data: .word32 0x10008
texto1: .asciiz "bienvenido"
texto2: .asciiz "error"
clave: .asciiz "capo"
claveNueva: .asciiz "...."
.code
daddi $sp,$0,0x400
lwu $t0,dir_control($0)
lwu $t1,dir_data($0)
daddi $t2,$0,9 ;cod leer carac
daddi $t3,$0,0 ;desplazamiento
daddi $t4,$0,4 ;cant elem
loop: jal char
      sd $v0,claveNueva($t3) ;guardamos el carac en claveNueva
      daddi $t3,$t3,8
      daddi $t4,$t4,-1
      bnez $t4, loop
daddi $a1,$0,clave
daddi $a2,$0,claveNueva
jal respuesta
halt
char: sd $t2,0($t0) ;cargar el cod en control, escribimos carac
      lbu $v0,0($t1) ;cargar el valor escrito en $v0
      jr $ra

respuesta: daddi $sp,$sp,-8
	   sd $s0,0($sp)
	   daddi $sp,$sp,-8
	   sd $s1,0($sp)
	   daddi $sp,$sp,-8
	   sd $s2,0($sp)
	   daddi $s1,$0,texto1
	   daddi $s2,$0,texto2
	   daddi $s0,$0,4 ;codigo para imprimir string
	   beq $a1,$a2,iguales
	   sd $s2,0($t1)
	   sd $s0,0($t0)
	   j fin
  iguales: sd $s1,0($t1) ;pasamos texto 1 a data
	   sd $s0,0($t0) ;pasamos codigo a control e imprime
     fin:  ld $s2,0($sp) ;popeamos
	   daddi $sp,$sp,8
	   ld $s1,0($sp)
	   daddi $sp,$sp,8
           ld $s0,0($sp)
	   daddi $sp,$sp,8
           jr $ra