.data
tabla: .word 1,2,3,4,5,6,0
cant: .word 7
cantImpares: .word 0
.code
daddi $sp,$0,0x400
ld $a0,tabla(r0)
ld $a1,cant(r0)
jal cantImpares
sd $v0,cantImpares(r0)
halt

cantImpares: daddi $sp,$sp,-8
	     sd $ra, 0($sp)
	     daddi $t0,r0,0
	     daddi $t2,r0,1
       loop: ld $a0,tabla($t0)
             jal es_impar
	     beq $t3,$t2,sumarCant
     volver: daddi $a1,$a1,-1
             daddi $t0,$t0,8
	     j fin2
  sumarCant: daddi $v0,$v0,1
	     j volver
       fin2: bnez $a1,loop
	     ld $ra,0($sp)
	     daddi $sp,$sp,8
	     jr $ra 
es_impar: andi $t1,$a0,0001
	  bnez $t1,devolver
	  daddi $t3,r0,0
	  j fin
devolver: daddi $t3,r0,1
      fin: jr $ra	