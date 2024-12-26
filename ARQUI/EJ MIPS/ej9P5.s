.data
carac: .asciiz "e"
vectorVocales: .asciiz "aAeEiIoOuU"
resultado: .word 3 ;lo inicializo en 3 xq pide q el res sea 1 o 0
.code
daddi $sp,$0,0x400
daddi $a0,$0,vectorVocales
daddi $a1,$0,carac
jal es_vocal
sd $v0,resultado(r0)
halt

es_vocal: daddi $sp,$sp,-8
	  sd $s0, 0($sp) ;pusheo s0
          dadd $s0,$a0,r0
	  daddi $t0,r0,0
    loop: lbu $a0,0($s0)
	  beq $a0,$a1,iguales
	  beq $a0,$t0,noIguales
	  daddi $s0,$s0,1 ;pasamos sig elem
	  j loop
noIguales: daddi $v0,r0,0
	   j fin
 iguales: daddi $v0,r0,1
     fin: ld $s0, 0($sp)
	  daddi $sp,$sp,8
	  jr $ra