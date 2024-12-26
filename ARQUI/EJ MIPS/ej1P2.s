.data
n1: .double 9.13
n2: .double 6.58
res1: .double 0.0
res2: .double 0.0
.code
l.d f1, n1(r0);carga en el registro f1 el valor 9.13
l.d f2, n2(r0);carga en f2 6.58
nop
add.d f3, f2, f1;suma f3 con f1 y guarda en f3
mul.d f1,f2,f1
mul.d f4, f2, f1;multiplica f2 con f1 y guarda en f4
s.d f3, res1(r0);guarda en res1 f3
s.d f4, res2(r0);guarda en res2 f4
halt