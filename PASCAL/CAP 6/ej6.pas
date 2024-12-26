program titlte;
const
	dimF=7;
type
	str=string[30];
	vector=array[1..dimF]of integer;
	sonda=record
		nombre:str;
		duracion:integer;
		costoCons:real;
		costoMan:real;
		rango:1..7;
	end;
	lista=^nodo;
	nodo=record
		dato:sonda;
		sig:lista;
	end;
procedure leerSonda(var s:sonda);
begin
	writeln('escribir el nombre de la sonda');
	readln(s.nombre);
	writeln('escribir la duracion estimada de la mision');
	readln(s.duracion);
	writeln('escribir el costo de construccion');
	readln(s.costoCons);
	writeln('escribir el costo de mantenimiento mensual');
	readln(s.costoMan);
	writeln('escribir el rango del espectro electromagnetico sobre el que realizara estudios');
	readln(s.rango);
	writeln('-----------------------------------------------');
end;
procedure incializarV (var v:vector);
var
	i:integer;
begin
	for i:= 1 to dimF do begin
		v[i]:=0;
	end;
end;
procedure vectorsito(var v:vector;L:lista);
var 
	i:integer;
begin
	for i:=1 to dimF do begin
		if(L^.dato.rango=i) then
			v[i]:=v[i]+1;
	end;
end;
procedure maximos (L:lista;var mascaro:str;var maxA:real);
var
	calcularcostototal:real;
begin
	calcularcostototal:=L^.dato.costoCons + (L^.dato.costoMan*L^.dato.duracion);
	if(calcularcostototal>maxA) then begin
		maxA:=calcularcostototal;
		mascaro:=L^.dato.nombre;
	end;
end;
procedure duracionProm (L:lista;var promedio:real);
var
	cantD,cantS:integer;
begin
	cantD:=0;
	cantS:=0;
	while(L<>nil) do begin
		cantD:=cantD+L^.dato.duracion;
		cantS:=cantS+1;
		L:=L^.sig;
	end;
	promedio:=cantD/cantS;
end;
procedure costoProm (L:lista;var prom2:real);
var
	cant1:integer;
	cant2:real;
begin
	cant1:=0;
	cant2:=0;
	while(L<>nil) do begin
		cant1:=cant1+1;
		cant2:=cant2+L^.dato.costoCons;
		L:=L^.sig;
	end;
	prom2:=cant2/cant1;
end;
procedure imprimirCostoProm(L:lista;prom2:real);
begin
	if(L^.dato.costoCons>prom2) then
		writeln('el costo de produccion de la sonda ',L^.dato.nombre,' supera el costo promedio entre todas las sondas'); 
end;
procedure cargarAdelante (var L:lista;s:sonda);
var
	nue:lista;
begin
	new(nue);
	nue^.dato:=s;
	nue^.sig:=L;
	L:=nue;
end;
procedure cargarLista (var L:lista);
var
	s:sonda;
begin
	repeat
	leerSonda(s);
	cargarAdelante(L,s);
	until(s.nombre='gaia');
end;
var
	L:lista;
	mascaro:str;
	cant:integer;
	maxA:real;
	promedio:real;
	promedio2:real;
	v:vector;
	i:integer;
begin
	promedio2:=0;
	promedio:=0;
	maxA:=-1;
	L:=nil;
	mascaro:=' ';
	cant:=0;
	cargarLista(L);
	duracionProm(L,promedio);
	costoProm(L,promedio2);
	while(L<>nil) do begin
		maximos(L,mascaro,maxA);
		vectorsito(v,L);
		if(L^.dato.duracion>promedio)then
			cant:=cant+1; 
		imprimirCostoProm(L,promedio2);
		L:=L^.sig;
	end;
	writeln('El nombre de la sonda mas costosa es: ',mascaro);
	for i:=1 to dimF do 
		writeln('La cantidad de sondas que realizaran estudios en el rango: ',i,' es de: ',v[i]);
	writeln('La cantidad de sondas cuya duracion estimada supera la duracion promedio de todas las sondas es: ',cant);
end.
