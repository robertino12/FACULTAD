program ej13;
const
	dimF=35;
type
	rango=1..35;
	libro=record                //NO LO ENTIENDO
		titulo:string;
		nombreEditorial:string;
		cantPag:integer;
		anioEdicion:integer;
		cantVentas:integer;
		codTematica:rango;
	end;
	lista=^nodo;
	nodo=record
		dato:libro;
		sig:lista;
	end;
procedure leerLibro (var l:libro);
begin
	write('escribir titulo libro: ');
	readln(l.titulo);
	write('escribir nombre editorial: ');
	readln(l.nombreEditorial);
	write('escribir cant pag libro: ');
	readln(l.cantPag);
	write('escribri anio edicion libro: ');
	readln(l.anioEdicion);
	write('escribir cant ventas libro: ');
	readln(l.cantVentas);
	write('escribir cod tematica libro: ');
	readln(l.codTematica);
	writeln('-----------------------');
end;
procedure agregarAtras (var l:lista; var ult:lista; li:libro);
var
	nue:lista;
begin
	new(nue);
	nue^.dato:=li;
	nue^.sig:=nil;
	if(l=nil)then
		l:=nue
	else
		ult^.sig:=nue;
	ult:=nue;
end;
procedure cargarLista (var l:lista);
var
	ult:lista;
	li:libro;
begin
	repeat
		leerLibro(li);
		agregarAtras(l,ult,li);
	until(li.titulo='relato');
end;
procedure recorrerLista(l:lista;var l2:lista2);
var
	
begin
	while(l<>nil)do begin
		
		l:=l^.sig;
	end;
end;
var 
	l:lista;
begin
	l:=nil;
	cargarLista(l);
end.
