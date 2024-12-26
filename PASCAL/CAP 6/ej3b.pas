program title;
type
	lista=^nodo;
	nodo=record
		num:integer;
		sig:lista;
	end;
procedure armarNodoAtras(var L,ult:lista;valor:integer);
var
	nue:lista;
begin
	new(nue);
	nue^.num:=valor;
	nue^.sig:=nil;
	if(L=nil) then
		L:=nue
	else
		ult^.sig:=nue;
	ult:=nue;
end;
procedure cargarLista(var L:lista;valor:integer);
var
	ult:lista;
begin
	while(valor<>0) do begin
		armarNodoAtras(L,ult,valor);
		readln(valor);
	end;
end;
procedure imprimir(L:lista);
begin
	while(L<>nil)do begin
		writeln('-------------------');
		writeln(L^.num);
		L:=L^.sig;
	end;
end;
var
	L:lista;
	valor:integer;
begin
	L:=nil;
	writeln('ingrese un numero');
	readln(valor);
	cargarLista(L,valor);
	imprimir(L);
end.
