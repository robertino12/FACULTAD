program JugamosConListas;
type
	lista = ^nodo;
	nodo = record
		dato : integer;
		sig : lista;
	end;
procedure armarNodoInsertar(var L: lista; v: integer);
var
	nue,ant,act: lista;
begin
	new(nue);
	nue^.dato:=v;
	act:=L;
	ant:=L;
	while(act<>nil) and (v > act^.dato) do begin
		ant:=act;
		act:=act^.sig;
	end;
	if(act=ant) then
		L:=nue
	else
		ant^.sig:=nue;
	nue^.sig:=act;
end;
procedure cargarLista(var L:lista);
var
	v:integer;
begin
	writeln('Ingrese un numero');
	readln(v);
	while(v<>0) do begin
		armarNodoInsertar(L,v);
		writeln('Ingrese un numero');
		readln(v);
	end;
end;
procedure imprimir(L:lista);
begin
	writeln('-------------------------------------');
	writeln(L^.dato);
end;
var
	pri : lista;
begin
	pri := nil;
	cargarLista(pri);
	while (pri<>nil) do begin
		imprimir(pri);
		pri:=pri^.sig;
	end;
end.
