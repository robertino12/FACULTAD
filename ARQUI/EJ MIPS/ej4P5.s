.data
peso: .double 92.5
altura: .double 1.83
imc: .double 0.0
aux: .double 18.5
estado: .word 0
.code
l.d f1,peso(r0)
l.d f2,altura(r0)
l.d f0,aux(r0)
mul.d f5,f2,f2
div.d f4,f1,f5;en f4 esta el imc
s.d f4,imc(r0) 
daddi $t0,r0,25;pasar los numeros enteros a double
mtc1 $t0,f3
cvt.d.l f6,f3;guarda 25.0 en f6
daddi $t1,r0,30
mtc1 $t0,f3
cvt.d.l f7,f3;guarda 30.0 en f7
daddi $t2,r0,1;ponemos 1 pa infra
c.lt.d f4,f0;hacer comparaciones
bc1t infrapeso
daddi $t2,r0,2
c.lt.d f4,f6
bc1t normal
daddi $t2,r0,3
c.lt.d f4,f7
bc1t sobrepeso
daddi $t2,r0,4
c.le.d f7,f4
bc1t obeso
j fin;no se dio ningun caso
infrapeso: sd $t2,estado(r0);guardamos 1 en estado si imc menos a 18,5
	  j fin;se dio saltar fin
normal: sd $t2,estado(r0);guardamos 2
	j fin 
sobrepeso: sd $t2,estado(r0);guardamos 3
	j fin
obeso: sd $t2,estado(r0);guardamos 4
fin: halt