.data; osea tengo q recorrer dos cadenas e ir preguntando si los elementos d los cadenas son iguales, si difieren avisar x una subrutina
cadena1: .asciiz "hola"
cadena2: .asciiz "hila"
posicionDif: .word 0;sino difieren poner -1 ak
.code
daddi $sp,$0,0x400
daddi $a0,$0,cadena1 ;guardamos en $a0 el valor del primer elemento d la cadena1
daddi $a1,$0,cadena2 ;guardamos en $a1 el valor del primer elemento d la candena2
jal recorrerCadenas
sd $v0,posicionDif(r0)
halt

recorrerCadenas: daddi $sp,$sp,-8
		 sd $ra, 0($sp) ;pusheo
		 daddi $sp,$sp,-8
		 sd $s0, 0($sp) ;pusheo s0
		 daddi $sp,$sp,-8
		 sd $s1, 0($sp) ;pusheo s1
		 dadd $s0,$a0,r0 ;pongo en s0 el valor del primer elem d la cadena1
		 dadd $s1,$a1,r0
		 daddi $t1,r0,0 ;inicio en 0 el d las posiciones
	   loop: lbu $a0,0($s0) ;cargo en $a0 el valor del primer elemento
		 lbu $a1,0($s1)
		 daddi $t1,$t1,1 ;voy guardando en q posicion van
		 dadd $t2,$a0,$a1 ;si esta suma da 0 quiere decir q los llegaron al final
		 beqz $t2,fin2 ;si t2 es 0 q salte a fin2
		 bne $a0,$a1,diferentes
		 daddi $s0,$s0,1 ;pasamos sig elem
		 daddi $s1,$s1,1
		 j loop
	   diferentes: jal subRDiferentes
	   fin: ld $s1,0($sp)
		daddi $sp,$sp,8
		ld $s0,0($s0)
		daddi $sp,$sp,8
		ld $ra,0($sp)
		daddi $ra,$ra,8
		ld $ra,0($sp)
		j fin3
	  fin2: daddi $v0,r0,-1
	  fin3: jr $ra

subRDiferentes: dadd $v0,r0,$t1
		jr $ra