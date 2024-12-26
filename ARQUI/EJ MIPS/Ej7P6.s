.data
coorX: .byte 0
coorY: .byte 0
CONTROL: .word32 0x10000
DATA: .word32 0x10008
color: .byte 255,255,255,0
OCHO: .byte 0,0,0,0,0,1,1,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,1,1,1,0,0,0,0,1,0,1,0,0,0,0,1,1,1,0,0,1,1,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0						

.text
lwu $s0, CONTROL($0)
lwu $s1, DATA($0)

daddi $t9, $0, 7
sd $t9, 0($s0) ;# Limpio la pantalla gráfica (En caso de que haya algo almacenado con anterioridad)

daddi $t9, $0, 64 ;# Contador de puntos restantes
lb $t0, coorX($0) ;# X
lb $t1, coorY($0) ;# Y
daddi $t7, $0, 0 ;# Desplazamientos
lb $t8, OCHO($t7) ;# Tabla con 1/0

loop: daddi $t2, $t8, -1
daddi $t7, $t7, 1
lb $t8, OCHO($t7)
bnez $t2, no_pintar

;# En caso de que sea 1, pinto:
lbu $s2, coorX($0)
sb $s2, 5($s1)
lbu $s3, coorY($0)
sb $s3, 4($s1)
lbu $s4, color($s0)
sw $s4, 0($s1)
daddi $t3, $0, 5
sd $t3, 0($s0)

;# En caso de que sea 0 / Ya haya terminado de pintar:
no_pintar: daddi $t9, $t9, -1
daddi $t0, $t0, 1
sb $t0, coorX($0) ;# Actualizo X
daddi $t6, $t0, -7
bnez $t6, salto
;# Si llego al límite de la cuadrícula (7x9):
daddi $t1, $t1, 1
sb $t1, coorY($0) ;# Actualizo Y
daddi $t0, $0, 0
sb $t0, coorX($0) ;# Actualizo X
daddi $t6, $t1, -
beqz $t6, salir
salto: bnez $t9, loop

salir: halt
