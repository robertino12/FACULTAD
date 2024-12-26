program ej7;
const
	dimF=4;
type
	rango=1..dimF;
	vector=array[rango]of integer;
	alumno=record
		num:integer;
		nombre:string;
		ingreso:integer;
		egreso:integer;
		notas:vector;
	end;
	lista=^nodo;
	nodo=record
		dato:alumno;
		sig:lista;
	end;
procedure cargarNotas(var v:vector);
var
	i,nota:integer;
begin
	for i:=1 to dimF do begin
		write('materia: ',i,' nota: ');
		readln(nota);
		v[i]:=nota;
	end;
end;
procedure ordenarDescendente (var v:vector);
var
	i,j,p,item:integer;
begin
	for i:=1 to dimF-1 do begin
		p:=i;
		for j:=i+1 to dimF do
			if(v[j]>v[p])then
				p:=j;
		item:=v[p];
		v[p]:=v[i];
		v[i]:=item;
	end;
end;
procedure leerAlumno (var a:alumno);
begin
	write('escribir numero de alumno: ');
	readln(a.num);
	if(a.num<>-1)then begin
		write('escribir nombre de alumno: ');
		readln(a.nombre);
		write('escribir anio ingreso de alumno: ');
		readln(a.ingreso);
		write('escribir anio egreso de alumno: ');
		readln(a.egreso);
		write('ESCRIBIR NOTAS ALUMNO: ');
		cargarNotas(a.notas);
	end;
	ordenarDescendente(a.notas);
	writeln('----------------------------');
end;
procedure agregarAtras(var l:lista;var ult:lista; a:alumno);
var
	nue:lista;
begin
	new(nue);
	nue^.dato:=a;
	nue^.sig:=nil;
	if(l=nil)then 
		l:=nue
	else
		ult^.sig:=nue;
	ult:=nue;
end;
procedure cargarLista (var l:lista);
var
	a:alumno;
	ult:lista;
begin
	leerAlumno(a);
	while(a.num<>-1)do begin
		agregarAtras(l,ult,a);
		leerAlumno(a);
	end;
end;
function numImpares(num:integer):boolean;
var
	dig:integer;
	aux:boolean;
begin
	aux:=true;
	while(num<>0)and(aux)do begin
		dig:=num mod 10;
		if(dig mod 2=0)then
			aux:=false;
		num:=num div 10;
	end;
	numImpares:=aux;
end;
procedure minimo (anios:integer;nombre:string;var minAnio,minAnio2:integer;var minNombre,minNombre2:string);
begin
	if(anios<minAnio)then begin
		minAnio2:=minAnio;
		minNombre2:=minNombre;
		minAnio:=anios;
		minNombre:=nombre;
	end
	else
		if(anios<minAnio2)then begin
			minAnio2:=anios;
			minNombre:=nombre;
		end;
end;
procedure imprimir (l:lista);
begin
	while(l<>nil)do begin
		writeln('nombre: ',l^.dato.nombre);
		l:=l^.sig;
	end;
end;
procedure eliminar (var l:lista;num:integer);
var
	ant,act:lista;
begin
	act:=l;
	while(act<>nil)and(act^.dato.num<>num)do begin
		ant:=act;
		act:=act^.sig;
	end;
	if(act<>nil)then begin
		if(act=l)then
			l:=act^.sig
		else
			ant^.sig:=act^.sig;
		dispose(act);
	end;
	writeln('exito');
end;
var
	l:lista;
	suma,i:integer;
	cantAlumnos:integer;
	anios:integer;
	minAnio,minAnio2:integer;
	minNombre,minNombre2:string;
	num:integer;
begin
	write('escribir numero alumno a eliminar: ');
	readln(num);
	minAnio:=10000;
	minAnio2:=10000;
	minNombre:=' ';
	minNombre2:=' ';
	l:=nil;
	cargarLista(l);
	imprimir(l);
	eliminar(l,num);
	imprimir(l);
	cantAlumnos:=0;
	while(l<>nil)do begin
		anios:=0;
		suma:=0;
		for i:=1 to dimF do
			suma:=suma+l^.dato.notas[i];
		writeln('el promedio de las notas obtenidas por el alumno: ',l^.dato.nombre,' es: ',suma/dimF:1:2);
		if(l^.dato.ingreso=2012)and(numImpares(l^.dato.num))then
			cantAlumnos:=cantAlumnos+1;
		anios:=l^.dato.egreso-l^.dato.ingreso;
		minimo(anios,l^.dato.nombre,minAnio,minAnio2,minNombre,minNombre2);
		l:=l^.sig;
	end;
	writeln('la cantidad de alumnos ingresantes con condiciones es: ',cantAlumnos);
	writeln('el nombre del alumno q se recibio mas rapido es: ',minNombre,' y el seg es: ',minNombre2);
end.
