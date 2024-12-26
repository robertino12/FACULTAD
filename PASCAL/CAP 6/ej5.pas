program title;
type
	str=string[50];
	super=record
		codigo:integer;
		desc:str;
		stokA:integer;
		stokM:integer;
		precio:real;
	end;
	lista=^nodo;
	nodo=record
		dato:super;
		sig:lista;
	end;
procedure leerSuper(var s:super);
begin
	writeln('escribir el codigo del producto');
	readln(s.codigo);
	if(s.codigo<>-1) then begin
		writeln('escribir la descripcion del producto');
		readln(s.desc);
		writeln('escribir el stock actual del producto');
		readln(s.stokA);
		writeln('escribir el stock minimo del producto');
		readln(s.stokM);
		writeln('escribir el precio del producto');
		readln(s.precio);
	end;
	writeln('--------------------------');
end;
procedure stocks (L:lista);
var
	cant,cantP:integer;
begin
	cant:=0;
	cantP:=0;
	while(L<>nil)do begin
		if(L^.dato.stokA<L^.dato.stokM) then
			cant:=cant+1;
		cantP:=cantP+1;
		L:=L^.sig;
	end;
	writeln('El procentaje de productos con stock actual por debajo del stock minimo es: ',(cant*100)/cantP:1:2,'%');
end;
procedure desc (L:lista;var cantPares:integer);
var
	num,dig:integer;
begin
	num:=L^.dato.codigo;
	while(num<>0) do begin
		dig:=num mod 10;
		if(dig mod 2=0) then
			cantPares:=cantPares+1;
		num:=num div 10;
	end;
end;
procedure imprimirdesc(L:lista);
var
	cantPares:integer;
begin
	while(L<>nil) do begin
		cantPares:=0;
		desc(L,cantPares);
		if(cantPares>=3) then
			writeln('la descripcion de aquellos productos con codigo compuesto por al menos tres digitos pares es: ',L^.dato.desc);
		L:=L^.sig;
	end;
end;
procedure minimos (L:lista;var min1,min2:real; var codigo1,codigo2:integer);
begin
	while(L<>nil) do begin
		if(L^.dato.precio<min1) then begin
			min2:=min1;
			min1:=L^.dato.precio;
			codigo2:=codigo1;
			codigo1:=L^.dato.codigo
		end
		else
		if(L^.dato.precio<min2) then begin
			min2:=L^.dato.precio;
			codigo2:=L^.dato.codigo;
		end;
		L:=L^.sig;
	end;
	writeln('el codigo del producto mas economico es: ',codigo1,' y el codigo del segundo producto mas barato es: ',codigo2);
end;
procedure cargarAtras( var L,ult:lista;s:super);
var
	nue:lista;
begin
	new(nue);
	nue^.dato:=s;
	nue^.sig:=nil;
	if(L=nil) then
		L:=nue
	else
		ult^.sig:=nue;
	ult:=nue;
end;
procedure cargarLista(var L:lista);
var
	ult:lista;
	s:super;
begin
	leerSuper(s);
	while(s.codigo<>-1) do begin
		cargarAtras(L,ult,s);
		leerSuper(s);
	end;
end;
var
	L:lista;
	min1,min2:real;
	codigo1,codigo2:integer;
begin
	min1:=1000;
	min2:=1000;
	codigo1:=1000;
	codigo2:=1000;
	L:=nil;
	cargarLista(L);
	stocks(L);
	imprimirdesc(L);
	minimos(L,min1,min2,codigo1,codigo2);
end.

{procedure imprimirLista(L:lista);
begin
	while(L<>nil) do begin
		writeln('-----------------------------');
		writeln(L^.dato);
		L:=L^.sig;
	end;
end;}
{function digpares (L:lista):integer;
var
	dig:integer;
	cantPares:integer;
begin
	cantPares:=0;
	while(L^.dato.codigo<>0) do begin
		dig:=L^.dato.codigo mod 10;
		if(dig mod 2=0) then
			cantPares:=cantPares+1;
		dig:=dig div 10;
	end;
	digpares:=cantPares;
end;
procedure desc (L:lista);
begin
	while(L<>nil) do begin
		if(digpares(L)>=3) then
			writeln('la descripcion de aquellos productos con codigo compuesto por al menos tres digitos pares es: ',L^.dato.desc);
		L:=L^.sig;
	end;
end;}
