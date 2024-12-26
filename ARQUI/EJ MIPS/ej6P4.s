.data
A: .word 2
B: .word 3
C: .word 2
D: .word 0
.code
ld r1,A(r0);carga 2 en r1
ld r2,B(r0);carga 3 en r2
ld r3,C(r0);carga 2 en r3
beq r1,r2,igualesDos;si son iguales saltar
beq r2,r3,iguales;sino salto arriba es xq r1,r2 no son iguales,comprobar si r3 y r2 si
igualesDos: daddi r5,r0,2;guarda en r5 2
	   beq r2,r3,igualesTres;compara si son iguales q salte sino q guarde en D 2
	   sd r5,D(r0);guarda 2 en D
	   j fin;salta a fin
igualesTres: daddi r5,r0,3;pone 3 en r5
	    sd r5,D(r0);guarda 3 en D
	    j fin;salta a fin
iguales: daddi r5,r0,2
	sd r5,D(r0)
fin: halt