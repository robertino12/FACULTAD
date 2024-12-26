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
procedure cargarLista1(var L:lista);
var
	ult:lista;
	valor:integer;
begin
	readln(valor);
	while(valor<>0) do begin
		armarNodoAtras(L,ult,valor);
		readln(valor);
	end;
end;
procedure agregarAdelante( var l2:lista;valor2:integer);
var
	nue:lista;
begin
	new(nue);
	nue^.num:=valor2;
	nue^.sig:=l2;
	l2:=nue;
end;
procedure cargarLista2( var l2:lista);
var
	valor2:integer;
begin
	readln(valor2);
	while(valor2<>0)do begin
		agregarAdelante(l2,valor2);
		readln(valor2);
	end;
end;
var
	L:lista;
	L2:lista;
begin
	L:=nil;
	L2:=nil;
	cargarLista1(L);
	cargarLista2(L2);
end.
