.data
m: .word 4
tabla: .word 1,3,8,6,7
cant: .word 5
cantMayores: .word 0
.code
daddi $sp,$sp,0x400
daddi $t2,r0,0;para ir desplazando en los elementos 
ld $a0,m(r0);los almaceno en estos registros xq son los d argumento d subrutina
ld $a2,cant(r0)
jal mayoresQueM
sd $v0,cantMayores(r0)
halt

mayoresQueM: daddi $sp,$sp,-8;restamos sp xq hacemos un push
	     sd $ra,0($sp);guardamos direc d retorno en la pila 
	     daddi $t5,r0,0;lo usamos para comparar
             loop: ld $t4,tabla($t2)
		   slt $t0,$a0,$t4;si 4 es menor al elemento actual, osea el elem mayor a 4, da 1 sino 0 
		   jal sumarCant
		   daddi $a2,$a2,-1;restamos uno a cant elem
		   daddi $t2,$t2,8;pasamos al sig elem
		   bnez $a2,loop;sino es 0 saltar loop
	    ld $ra,0($sp)
	    daddi $sp,$sp,8;popeamos 
	    jr $ra
sumarCant: beq $t0,$t5,fin;si es igual a 0 q no sume, xq si $a0 es 0 es xq el elem no es mayor a 4
	   daddi $v0,$v0,1
      fin: jr $ra