.data
base: .double 5.85
altura: .double 13.47
aux: .double 2.0
superficie: .double 0.0
.code
l.d f3,aux(r0)
l.d f1,base(r0)
l.d f2,altura(r0)
mul.d f4,f1,f2
div.d f5,f4,f3
s.d f5,superficie(r0)
halt