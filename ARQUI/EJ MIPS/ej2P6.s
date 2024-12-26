.data
dir_control: .word32 0x10000
dir_data: .word32 0x10008
numero: .ascii 0
.code
daddi $t5,$0,57
lwu $t0,dir_control($0)
lwu $t1,dir_data($0)
daddi $t2,$0,9 ;cargamos codigo para escribir
daddi $t3,$0,0
jal ingreso
sd $v0,numero($0)
halt
ingreso: sd $t2,0($t0) ;paso el codigo a control
	 lbu $t3,0($t1) ;paso el numero d escribimos a t3
	 slti $t4,$t3,48;sino el num ingresado es menor a 48, no es digito
	 bnez $t4,noDigito
	 slt $t4,$t5,$t3;si el num ingresado es mayor q 57 no es digito
	 bnez $t4,noDigito
	 dadd $v0,r0,$t3 ;si en v0 se guarda el numero es xq es digito
	 j fin
noDigito: daddi $v0,r0,0 
	 fin: jr $ra
