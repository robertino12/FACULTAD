.data
dir_control: .word32 0x10000
dir_data: .word32 0x10008
A: .word 0
B: .word 0
C: .word 0
res: .word 0
.code
daddi $t0,$0,8 ;cod pra ingresar num
lwu $s0,dir_control($0)
lwu $s1,dir_data($0)
sd $t0,0($s0)
ld $a1,0($s1)
sd $a1,A($0)

sd $t0,0($s0)
ld $a2,0($s1)
sd $a2,B($0)

sd $t0,0($s0)
ld $a3,0($s1)
sd $a3,C($s0)
jal calculo
sd $v0,res($0)
daddi $t3,$0,2
sd $v0,0($s1)
sd $t3,0($s0)
halt


calculo: daddi $v0,$0,1 ;este registro lo vamos a usar para guardar el valor q va a res
	 beqz $a3,fin ;si $a3 es 0 saltar c $v0 valiendo uno ya q cualq numero elevado a la 0 es uno
	 dsub $t1,$a1,$a2
   loop: dmul $v0,$v0,$t1
	 daddi $a3,$a3,-1
	 beqz $a3,loop
    fin: jr $ra	 