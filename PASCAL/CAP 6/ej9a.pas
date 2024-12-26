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
function esOrdenada(L:lista):boolean;
var
	nue:lista;
	aux:boolean;
begin
	aux:=true;
	nue:=L;
	nue:=nue^.sig;
	while((nue<>nil)and (aux=true)) do begin			
		if(L^.dato>nue^.dato)then{comparas el dato actual de L con el anterior que tiene nue}
			aux:=false;
		nue:=nue^.sig;
		L:=L^.sig;
	end;
	esOrdenada:=aux;
end;
{si pones en la terminal, 1,2,3,4 t va a decir q la lista no esta ordenada xq se carga de adelante, osea seria 4321 y si esta asi aux es falso}
procedure imprimir(L:lista);
begin
		if(esOrdenada(L)=true) then		
			writeln('la lista esta ordenada')
		else 
		if(esOrdenada(L)=false) then
			writeln('la lista no esta ordenada');
end;
var
	pri : lista;
begin
	pri := nil;
	cargarLista(pri);
	imprimir(pri);
end.
