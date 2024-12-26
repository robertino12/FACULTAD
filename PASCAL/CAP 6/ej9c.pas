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
procedure sublista (L:lista;var l2:lista; a,b:integer);
var
	nue:lista;
begin
	while(L<>nil) do begin
		if(L^.dato>a) and (L^.dato<b) then begin
			new(nue);
			nue^.dato := l^.dato;
			nue^.sig := l2;
			l2 := nue;{literlamente se esta creando una lista solo q apartir de las condiciones de los ifs}
		end;
		l := l^.sig;
	end;
end;
procedure imprimir (l2:lista);
begin
	while(l2<>nil) do begin
		writeln(l2^.dato);
		l2:=l2^.sig;
	end;
end;
var
	pri : lista;
	l2:lista;
begin
	pri := nil;
	l2:=nil;
	cargarLista(pri);
	sublista(pri,l2,2,5);
	imprimir(l2);{imprime 3 y 4 xq son los numeros d la lista l q estan entre el 2 y el 5}
end.
