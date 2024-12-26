.data
dir_control: .word32 0x10000
dir_data: .word32 0x10008
base: .double 2.5
exponente: .word 3;ME TIRA ERRORES EN SEGUNDA PASADA
.code
ld $t0,dir_control($0)
ld $t1,dir_data($0)
daddi $t2,$0,3 ;codigo
ld $f0,base($0)
ld $a0,exponente($0)
jal a_la_potencia
sd $f4,0($t1) ;pasar el res a data
sd $t2,0($t0) ;pasar codigo a control
halt
a_la_potencia: ld $t3,exponente($0)
	       mtc1 $t3,$f2
	       cvt.d.l $f2,$f2
	       daddi $t4,$0,2
	       ld $f4,base($0)
	 loop: mul.d $f4,$f4,$f0
	       daddi $t4,$t4,-1
	       bnez $t4,loop
	       jr $ra