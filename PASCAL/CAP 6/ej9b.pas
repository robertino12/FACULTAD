program JugamosConListas;
type
	lista = ^nodo;
	nodo = record
		dato : integer;
		sig : lista;
	end;
procedure armarNodo(var L: lista; v: integer);
var
	aux : lista;
begin
	new(aux);
	aux^.dato := v;
	aux^.sig := L;
	L := aux;
end;
procedure cargarLista(var L:lista);
var
	v:integer;
begin
	writeln('Ingrese un numero');
	readln(v);
	while(v<>0) do begin
		armarNodo(L,v);
		writeln('Ingrese un numero');
		readln(v);
	end;
end;
procedure eliminar (var L:lista;var num:integer);
var
	act,ant:lista;
begin
	act:=L;
	while(act<>nil)and(act^.dato<>num) do begin
		ant:=act;
		act:=act^.sig;
	end;
	if(act<>nil) then 
		if(act=L) then begin
			L:=L^.sig;
			dispose(act);
		end
	else begin
		ant^.sig:=act^.sig;
		dispose(act);
	end;
end;
var
	pri : lista;
	num:integer;
begin
	pri := nil;
	cargarLista(pri);
	writeln('Ingresar el numero para eliminar');
	readln(num);
	eliminar(pri,num);
	while(pri<>nil) do begin
		writeln(pri^.dato);
		pri:=pri^.sig;
	end;
end.
