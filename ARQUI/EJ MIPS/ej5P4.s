.data
cant: .word 8
datos: .word 1, 2, 3, 4, 5, 6, 7, 8
res: .word 0
.code
dadd r1, r0, r0;guarda 0 en r1
ld r2, cant(r0);r2 guarda 8
loop: ld r3, datos(r1);guarda el primer elemento en r3
daddi r2, r2, -1;resta un elemento
dsll r3, r3, 1;multpiplica x2 el elemento q tiene r3
sd r3, res(r1);guarda en res el numero multplicado x dos
bnez r2, loop;salta si r2 no es 0
daddi r1, r1, 8;pasa al sig elemento
halt