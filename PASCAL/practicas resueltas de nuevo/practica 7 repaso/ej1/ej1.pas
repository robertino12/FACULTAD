program ej1;
type
	rango=1..5;
	persona=record
		dni:integer;
		nombre:string;
		edad:integer;
		codGenero:rango;
	end;
	lista=^nodo;
	nodo=record
		dato:persona;
		sig:lista;
	end;
	vecCont=array[rango]of integer;
procedure leerReg (var p:persona);
begin
	write('escribir dni de la persona: ');
	readln(p.dni);
	write('escribir nombre de la persona: ');
	readln(p.nombre);
	write('escribir edad de la persona: ');
	readln(p.edad);
	write('escribir el codigo de genero de actuacion: ');
	readln(p.codGenero);
	writeln('----------------------');
end;
procedure agregarAdelante (var l:lista;p:persona);
var
	nue:lista;
begin
	new(nue);
	nue^.dato:=p;
	nue^.sig:=l;
	l:=nue;
end;
procedure cargarLista (var l:lista);
var
	p:persona;
begin
	repeat
		leerReg(p);
		agregarAdelante(l,p);
	until(p.dni=33);
end;
function masPares (dni:integer):boolean;
var
	dig,pares,impares:integer;
	bulian:boolean;
begin
	pares:=0;
	impares:=0;
	while(dni<>0)do begin
		dig:=dni mod 10;
		if(dig mod 2=0)then
			pares:=pares+1
		else
			impares:=impares+1;
		dni:=dni div 10;
	end;
	if(pares>impares)then
		bulian:=true
	else
		bulian:=false;
	masPares:=bulian;
end;
procedure cargarVc ( var vC:vecCont);
var
	i:integer;
begin
	for i:=1 to 5 do
		vC[i]:=0;
end;
procedure maximo (personas,codigo:integer;var codMax,codMax2,cantMax,cantMax2:integer);
begin
	if(personas>cantMax)then begin
		cantMax2:=cantMax;
		codMax2:=codMax;
		cantMax:=personas;
		codMax:=codigo;
	end
	else
		if(personas>cantMax2)then begin
			cantMax2:=personas;
			codMax2:=codigo;
		end;
end;
procedure eliminar (var l:lista;dni:integer);
var
	ant,act:lista;
begin
	act:=l;
	while(act<>nil)and(act^.dato.dni<>dni)do begin
		ant:=act;
		act:=act^.sig;
	end;
	if(act<>nil)then begin
		if(act=l)then
			l:=act^.sig
		else
			ant^.sig:=act^.sig;
		dispose(act);
	end;
	writeln('exito');
end;
procedure imprimirLista (l:lista);
begin
	while(l<>nil)do begin
		writeln('dni: ',l^.dato.dni);
		l:=l^.sig;
	end;
end;
var
	l:lista;
	vC:vecCont;
	cantPers,i,dni:integer;
	codMax,codMax2,cantMax,cantMax2:integer;
begin
	codMax:=-1;
	codMax2:=-1;
	cantMax:=-1;
	cantMax2:=-1;
	cantPers:=0;
	l:=nil;
	cargarLista(l);
	cargarVc(vC);
	while(l<>nil)do begin
		if(masPares(l^.dato.dni))then
			cantPers:=cantPers+1;
		vC[l^.dato.codGenero]:=vC[l^.dato.codGenero]+1;
		l:=l^.sig;
	end;
	writeln('la cantidad de personas cuyo dni mas pares es: ',cantPers);
	for i:=1 to 5 do 
		maximo(vC[i],i,codMax,codMax2,cantMax,cantMax2);
	writeln('el codigo de genero mas elegido es: ',codMax,' y el segundo mas elegido es: ',codMax2);
	imprimirLista(l);
	writeln('----------------------');
	write('escribir dni a eliminar: ');
	readln(dni);
	eliminar(l,dni);
	imprimirLista(l);
end.
