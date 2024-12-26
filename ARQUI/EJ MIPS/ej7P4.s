.data
tabla: .word 6,8,12,7,4,9,3,2,11,1
x: .word 4
cant: .word 0
res: .word 0
.code
ld r2,x(r0);cargo num a comparar en r2
ld r3,cant(r0);cargo cant en r3
daddi r9,r0,1;aux para comparar si es uno y sumar a cant
daddi r8,r0,0;pongo en 0 para aumentar la direc del vector nuevo
daddi r5,r0,0;desplazamiento
daddi r6,r0,10;cant elementos
daddi r7,r0,0;en r7 guardo elementos nuevos pra el vector nuevo
loop: ld r1,tabla(r5);cargo en r1 los elementos
      slt r7,r2,r1; compara si r2 es menor a r1 deja 1, osea elemento mayor x
      sd r7,res(r8);guarda 1 o 0 en res
      daddi r6,r6,-1;resto cant elem
      daddi r5,r5,8;paso al sig elem
      daddi r8,r8,8;aumenta direc d r8
      beq r7,r9,sumar;compara si son iguales
      bne r7,r9,seguir
      sumar: dadd r3,r3,r7;pone 1 en r3
      sd r3,cant(r0);pone lo d r3 en cant
      seguir: bnez r6,loop
halt