program title;
const
	dimf=10;
type
	subrango=1..dimf;
	str=string[30];
	fecha=record
		dia:integer;
		mes:integer;
		anio:integer;
	end;
	vPuntos=array[subrango]of integer;
	infoCiclistas=record
		nroInscrip:integer;
		dni:integer;
		apellido:str;
		nombre:str;
		fechaNacimiento:fecha;
		puntos:vPuntos;
	end;
	lista=^nodo;
	nodo=record
		dato:infoCiclistas;
		sig:lista;
	end;
//-----------------------------------------------------------
//CARGAR LISTA
procedure cargarVector (var v:vPuntos);
var
	i:integer;
	puntos:integer;
begin
	for i:=1 to dimf do begin
		write('escribir los puntos que hizo el ciclista en la carrera: ',i);
		readln(puntos);
		v[i]:=puntos;
	end;
end;
procedure leerFechaNaci (var f:fecha);
begin
	write('escribir el dia de nacimiento: ');
	readln(f.dia);
	write('escribir el mes de nacimieto: ');
	readln(f.mes);
	write('escribir el anio de nacimiento: ');
	readln(f.anio);
end;
procedure leerInfoCiclistas (var i:infoCiclistas);
begin
	write('escribir el nro de inscripcion: ');
	readln(i.nroInscrip);
	write('escribir el dni del ciclista: ');
	readln(i.dni);
	write('escribir el apellido del ciclista: ');
	readln(i.apellido);
	write('escribir el nombre del ciclista: ');
	readln(i.nombre);
	write('escribir fecha de nacimiento del ciclista: ');
	leerFechaNaci(i.fechaNacimiento);
	write('escribir los puntos obtenidos en cada una de las 10 carreras del ciclista: ');
	cargarVector(i.puntos);
	writeln('-----------------------------------------------------------');
end;
procedure agregarAdelante (var l:lista; i:infoCiclistas);
var
	nue:lista;
begin
	new(nue);
	nue^.dato:=i;
	nue^.sig:=l;
	l:=nue;
end;
procedure cargarLista (var l:lista);
var
	i:infoCiclistas;
begin
	repeat
		leerInfoCiclistas(i);
		agregarAdelante(l,i);
	until(i.dni=3344);
end;


//PROGRAMA PRINCIPAL
var
	l:lista;
begin
	l:=nil;
	cargarLista(l);
end.
