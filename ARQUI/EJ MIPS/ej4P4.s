.data
tabla: .word 20, 1, 14, 3, 2, 58, 18, 7, 12, 11
num: .word 7
long: .word 10
.code
ld r1, long(r0);carga cant d elem del vector
ld r2, num(r0);carga el numero a comparar
dadd r3, r0, r0
dadd r10, r0, r0
loop: ld r4, tabla(r3);carga en r4 el elemento del vector
beq r4, r2, listo;compara si son iguales salta a listo
daddi r1, r1, -1;resta elemento
daddi r3, r3, 8;;pasa al sig elemento
bnez r1, loop;sino es 0 ir a loop
j fin;si sale del loop es xq no encontro numero y salta fin
listo: daddi r10, r0, 1;guarda 1 en r10
fin: halt