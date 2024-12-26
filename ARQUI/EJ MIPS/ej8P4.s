.data;se hace 7 veces el bucle y en un registro se va guardando d a 4, estaria haciendo como 3x8
num1: .word 4;este para sumar
num2: .word 7;este pra bucle
res: .word 0
.code
ld r1,num1(r0);guarda 4
ld r2,num2(r0);guarda 7
daddi r3, r0, 0;guarda 0 en r3
loop: dadd r3,r3,r1;suma 4 a r3
      daddi r2,r2,-1;resta 1 a r2
      bnez r2,loop;lupear si r2 no es 0
      sd r3,res(r0);guardar en res lo q esta en r3
halt