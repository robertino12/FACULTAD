{14. La biblioteca de la Universidad Nacional de La Plata necesita un programa para administrar
información de préstamos de libros efectuados en marzo de 2020. Para ello, se debe leer la información
de los préstamos realizados. De cada préstamo se lee: nro. de préstamo, ISBN del libro prestado, nro. de
socio al que se prestó el libro, día del préstamo (1..31). La información de los préstamos se lee de manera
ordenada por ISBN y finaliza cuando se ingresa el ISBN -1 (que no debe procesarse).
Se pide:
A) Generar una estructura que contenga, para cada ISBN de libro, la cantidad de veces que fue prestado.
Esta estructura debe quedar ordenada por ISBN de libro.
B) Calcular e informar el día del mes en que se realizaron menos préstamos.
C) Calcular e informar el porcentaje de préstamos que poseen nro. de préstamo impar y nro. de socio
par.}
program title;
const
	dimf=31;
type
	subrango=1..dimf;
	vDiaPrestamo=array[subrango]of integer;
	prestamos=record
		nroPrestamo:integer;
		ISBN:integer;
		nroSocio:integer;
		diaPrestamo:subrango;
	end;
//EL REGISTRO NO LO PIDE COMO UNA LISTA QUE SE LEA Y ALMACENE, EN EL PUNTO A PIDE GENERAR UNA LISTA
	nuevaEstructura=record
		nueISBN:integer;
		cantPrest:integer;
	end;
	lista=^nodo;
	nodo=record
		dato:nuevaEstructura;
		sig:lista;
	end;
	
//PORCESOS PARA INFORMAR
procedure minimo (v:vDiaPrestamo;var min:integer;var diaMin:integer);//INCISO B
var
	i:subrango;
begin
	for i:=1 to dimf do begin
		if(v[i]<min) then begin
			min:=v[i];
			diaMin:=i;
		end;
	end;
end;
function todoImpar (nroPrestamo:integer):boolean;
var
	dig:integer;
	pares:integer;
	impares:integer;
begin
	impares:=0;
	pares:=0;
	while(nroPrestamo<>0) do begin
		dig:=nroPrestamo mod 10;
		if(dig mod 2=1) then 
			impares:=impares+1
		else
			pares:=pares+1;
	nroPrestamo:=nroPrestamo div 10;
	end;
	todoImpar:=(pares=0)and(impares>=1);
end;
function todoPar (nroSocio:integer):boolean;
var
	dig:integer;
	pares:integer;
	impares:integer;
begin
	impares:=0;
	pares:=0;
	while(nroSocio<>0) do begin
		dig:=nroSocio mod 10;
		if(dig mod 2=1) then 
			impares:=impares+1
		else
			pares:=pares+1;
	nroSocio:=nroSocio div 10;
	end;
	todoPar:=(impares=0)and(pares>=1);
end;

//PROCESOS DE CARGA
procedure darValorInfoNuevaEstructura (var n:nuevaEstructura;nuevoISBN:integer;cantPrest:integer);
begin
	n.nueISBN:=nuevoISBN;
	n.cantPrest:=cantPrest;
end;
procedure inicializarVectorEn0 (var v:vDiaPrestamo);
var
	i:subrango;
begin
	for i:=1 to dimf do begin
		v[i]:=0;
	end;
end;
procedure leerInfoPrestamos (var p:prestamos);
begin
	write('esrcibir el ISBN del libro prestado: ');
	readln(p.ISBN);
	if(p.ISBN<>-1) then begin
		write('escribir el nro de prestamo: ');
		readln(p.nroPrestamo);
		write('escribir el numero de socio al que se le presto el libro: ');
		readln(p.nroSocio);
		write('escribir el dia del prestamo: ');
		readln(p.diaPrestamo);
	end;
	writeln('----------------------------');
end;
procedure agregarAdelante (var l:lista; n:nuevaEstructura);
var
	nue:lista;
begin
	new(nue);
	nue^.dato:=n;
	nue^.sig:=l;
	l:=nue;
end;

//PROGRAMA PRINCIPAL
var
	l:lista;
	ISBNActual:integer;
	v:vDiaPrestamo;
	p:prestamos;
	n:nuevaEstructura;
	cantPrest:integer;
	min,diaMin:integer;
	prestParImpar:integer;
	cantPrestTotal:integer;
begin
	prestParImpar:=0;
	cantPrestTotal:=0;
	min:=100;
	diaMin:=32;
	inicializarVectorEn0(v);
	l:=nil;
	leerInfoPrestamos(p);
	while(p.ISBN<>-1) do begin
		cantPrest:=0;
		ISBNActual:=p.ISBN;
		while(p.ISBN<>-1) and (p.ISBN=ISBNActual)do begin
			cantPrest:=cantPrest+1;
			v[p.diaPrestamo]:=v[p.diaPrestamo]+1;
			if(todoImpar(p.nroPrestamo))and(todoPar(p.nroSocio))then
				prestParImpar:=prestParImpar+1;
			cantPrestTotal:=cantPrestTotal+1;
			leerInfoPrestamos(p);
		end;
		darValorInfoNuevaEstructura(n,ISBNActual,cantPrest);//ME FALTA ENTENDER LO Q DICE EL INCISO A D Q ESTA ESTRUCTURA DEBE ESTAR ORDENANDA POR ISBN DE LIBRO
		agregarAdelante(l,n);//CON EL PROCESO DE DARVALOR Y AGREGARADELANTE CREAMOS LA NUEVA ESTRUCTURA OSEA LA LSITA
	end;
	minimo(v,min,diaMin);//SI ALGUNO NO TIENE PRESTAMOS COMO EL VECTOR ESTA INICIALIZADO EN 0 EL MENOR VA A SER CONSIDERADO EL Q NO TENGA PRESTAMOS Y NO SE SI ESTA BIEN, SALVO Q SI O SI TODOS LOS DIAS TENGAN Q TENER UN NUMERO DE PRESTAMOS DIFERENTE
	writeln('el dia del mes en que se realizaron menos prestamos es: ',diaMin);
	writeln('el porcentaje de prestamos que poseen nro de prestamo impar y nro de socio par es de: ',prestParImpar*100/cantPrestTotal:1:2);
end.
