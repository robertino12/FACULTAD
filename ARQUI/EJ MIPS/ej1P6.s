.data
CONTROL: .word32 0x10000
DATA: .word32 0x10008
texto: .asciiz "...."
.text
lwu $s0, DATA($zero) ; $s0 = dirección de DATA
lwu $s1, CONTROL($zero) ; $s1 = dirección de CONTROL
daddi $t1,$0,9 ;le pasamos el cod pra leer carac
daddi $t2,$0,4 ;le pasamos cant d elem
daddi $t3,$0,0 ;desplazamiento
loop: sb $t1,0($s1) ;guardamos en control el codigo para poder poner un carac
      lbu $t4,0($s0) ;guardamos en $t4 el carac q hayamos escrito q esta en data
      sb $t1,texto($t3) ;guardamos en texto el caracter en la primer pos
      daddi $t3,$t3,1 ;pasar al sig elem
      daddi $t2,$t2,-1 ;restar cant
      bnez $t2,loop
daddi $t0, $zero, texto ; $t0 = dirección del mensaje a mostrar
sd $t0,0($s0)
daddi $t5, $zero, 4 ; $t0 = 4 -> función 4: salida de una cadena ASCII
sd $t5, 0($s1) ; CONTROL recibe 4 y produce la salida del mensaje
halt