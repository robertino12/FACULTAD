program Pr6Ej12;
Type
	android = record
		version:real;
		tamano:integer;
		memoria:integer;
	end;
	
	lista = ^nodo;
	
	nodo = record
		dato:android;
		sig:lista;
	end;
	
Procedure leerandroid(var a:android);
begin
	write('Ingrese la version de android: ');
	readln(a.version);
	if(a.version <> 0)then begin
		write('Ingrese el tamano de la pantalla: ');
		readln(a.tamano);
		write('Ingrese la cantidad de memoria ram: ');
		readln(a.memoria);
	end;
	writeln('------------------------');
end;

Procedure armarnodo(var l:lista;a:android);
var
	nue:lista;
begin
	new(nue);
	nue^.dato:= a;
	nue^.sig:= l;
	l:= nue;
end;

Procedure cargarlista(var l:lista);
var
	a:android;
begin
	leerandroid(a);
	while(a.version <> 0)do begin
		armarnodo(l,a);
		leerandroid(a);
	end;
end;

Procedure procesoandroid(l:lista);
var
	cant,masdetres,cantotal,sumadepantallas:integer;
	versionactual,promedio:real;
begin
	masdetres:= 0;
	cantotal:= 0;
	sumadepantallas:= 0;
	while(l <> nil)do begin
		cant:= 0;
		versionactual:= l^.dato.version;
		while((l <> nil)and (l^.dato.version = versionactual))do begin
			cant:= cant + 1;
			if((l^.dato.memoria > 3)and(l^.dato.tamano<=5))then
				masdetres:= masdetres + 1;
			cantotal:= cantotal + 1;
			sumadepantallas:= sumadepantallas + l^.dato.tamano;
			l:= l^.sig;
		end;
		writeln('La version de android ',versionactual,' esta instalada en ',cant,' dispositivos');
	end;
	promedio:= sumadepantallas/cantotal;
	writeln('El tamano promedio de pantalla es ',promedio:0:2);
	writeln('La cantidad dispositivos que cumplen el inciso 2 son ',masdetres);
end;

Var
	l:lista;
BEGIN
	cargarlista(l);
	procesoandroid(l);
END.
