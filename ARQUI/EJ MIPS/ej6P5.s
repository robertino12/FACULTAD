.data
valor1: .word 16
valor2: .word 4
result: .word 0
.text
ld $a0, valor1($zero);argumento pasado a la sub, donde se guarda 16 en $a0
ld $a1, valor2($zero);otro argumento se guarda 4 en $a1
jal a_la_potencia
sd $v0, result($zero);se guarda en result el valor de $v0 1048576 o 100000 en hexa
halt

a_la_potencia: daddi $v0, $zero, 1;parametro d retorno d la sub, guarda en $v0 1
lazo: slt $t1, $a1, $zero;compara si $a1 es menor a 0, y en $t1 se guarda 1 cuando $a1 valga -1 sino da 0
bnez $t1, terminar;sino es 0 ir a terminar
daddi $a1, $a1, -1;resta uno a al valor2 q es 4 al principio
dmul $v0, $v0, $a0;se multplica lo q valga $v0x16 5 veces se hace el loop
j lazo
terminar: jr $ra;vuelve al ppl