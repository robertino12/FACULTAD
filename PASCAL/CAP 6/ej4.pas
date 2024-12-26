program JugamosConListas;
type
	lista = ^nodo;
	nodo = record
		num : integer;
		sig : lista;
	end;
procedure armarNodo(var L: lista; v: integer);
var
	aux : lista;
begin
	new(aux);
	aux^.num := v;
	aux^.sig := L;
	L := aux;
end;
procedure cargarLista(var L:lista;v:integer);
begin
	while(v<>0) do begin
		armarNodo(L,v);
		writeln('Ingresar numero');
		readln(v);
	end;
end;
procedure imprimir(L:lista);
begin
	while(L<>nil) do begin
		writeln('------------------');
		writeln(L^.num);
		L:=L^.sig;
	end;
end;
procedure maximo(L:lista;var max:integer);
begin
	while(L<>nil) do begin
		if(L^.num>max) then
			max:=L^.num;
		L:=L^.sig;
	end;
	writeln('el elemento de la lista de valor maximo es: ',max);
end;
procedure minimo (L:lista;min:integer);
begin
	while(L<>nil) do begin
		if(L^.num<min) then
			min:=L^.num;
		L:=L^.sig;
	end;
	writeln('el elemento de la lista de valor minimo es: ',min);
end;
procedure multiplos (L:lista;multi:integer);
var
	cant:integer;
begin
	cant:=0;
	while(L<>nil) do begin
		if(L^.num mod multi=0)then
			cant:=cant+1;
		L:=L^.sig;
	end;
	writeln('La cantidad de elementos que son multiplos de',multi,' es de: ',cant);
end; 
var
	pri : lista;
	valor : integer;
	max,min:integer;
	multi:integer;
begin
	max:=-1;
	min:=100;
	pri := nil;
	writeln('Ingrese un numero');
	readln(valor);
	cargarLista(pri,valor);
	imprimir(pri);
	maximo(pri,max);
	minimo(pri,min);
	writeln('escribir el numero para calcular sus multiplos');
	readln(multi);
	multiplos(pri,multi);
end.

