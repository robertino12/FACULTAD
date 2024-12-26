program title;
const
	dimF=7;
type
	str=string[30];
	vector=array[1..dimF]of integer;
	sonda=record
		nombre:str;
		duracion:integer;
		costoCons:integer;
		costoMan:integer;
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

function financiado (l:lista):boolean;
begin
	financiado:=(l^.dato.costoCons>l^.dato.costoMan) and (l^.dato.rango>1) ;
end;

procedure doslistas(l:lista;var cumple:lista;var nocumple:lista);
begin
	if (financiado(l)) then 
		cargarAdelante(cumple,l^.dato)
	else
		cargarAdelante(nocumple,l^.dato);
end;

procedure imprimir(cumple:lista;nocumple:lista);
begin
	writeln('Proyectos que cumplen: ');
	while(cumple<>nil) do begin
		writeln(cumple^.dato.nombre);
		cumple:=cumple^.sig;
	end;
	writeln('Proyectos que no cumplen: ');
	while(nocumple<>nil) do begin
		writeln(nocumple^.dato.nombre);
		nocumple:=nocumple^.sig;
	end;
end;
procedure noSeranFinanciados(nocumple:lista);
var
	cant,costoTotal:integer;
begin
	cant:=0;
	while(nocumple<>nil)do begin
		costoTotal:=0;
		cant:=cant+1;
		costoTotal:=nocumple^.dato.costoCons+nocumple^.dato.costoMan;
		writeln('el costo total del proyecto: ',nocumple^.dato.nombre,' que no sera financiados es de : ',costoTotal);
		nocumple:=nocumple^.sig;
	end;
	writeln('la cantidad de proyectos que no seran financiados es de: ',cant);
		
end;
var
	L,cumple,nocumple:lista;
begin
	L:=nil; cumple:=nil; nocumple:=nil;
	cargarLista(L);
	while (L<>nil) do begin
		doslistas(L,cumple,nocumple);
		L:=L^.sig;
	end;
	imprimir(cumple,nocumple);
	noSeranFinanciados(nocumple);
end.
