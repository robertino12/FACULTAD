program title1;
const
	dimF=5;
type
	rango=1..5;
	vector=array[1..dimF]of integer;
	str=string[20];
	persona=record
		dni:integer;
		apellido:str;
		nombre:str;
		edad:integer;
		codigo:rango;
	end;
	lista=^nodo;
	nodo=record
		dato:persona;
		sig:lista;
	end;
procedure cargarVector (var v:vector);
var
	i:integer;
begin
	for i:=1 to dimF do 
		v[i]:=0;
end;
procedure leerRegistro (var p:persona);
begin
	writeln('escribe el dni de la persona');
	readln(p.dni);
	writeln('escribe el apellido de la persona');
	readln(p.apellido);
	writeln('escribe el nombre de la persona');
	readln(p.nombre);
	writeln('escribe la edad de la persona');
	readln(p.edad);
	writeln('escribe el codigo de genero de actuacion que prefiere la persona');
	readln(p.codigo);
end;	
procedure agregarAdelante (var L:lista;p:persona);
var
	nue:lista;
begin
	new(nue);
	nue^.dato:=p;
	nue^.sig:=L;
	L:=nue;
end;
procedure cargarLista(var L:lista);
var
	p:persona;
begin
	repeat	
		leerRegistro(p);
		agregarAdelante(L,p);
	until(p.dni=3355);
end;
procedure descomponer (L:lista;var cantPares,cantImpares:integer);
var
	dig:integer;
begin
	while(L^.dato.dni<>0) do begin
		dig:=L^.dato.dni mod 10;
		if(dig mod 2=0) then
			cantPares:=cantPares+1
		else
			cantImpares:=cantImpares+1;
		L^.dato.dni:=L^.dato.dni div 10;
	end;
end;
procedure personasMasPares (L:lista;cantPares,cantImpares:integer;var cantPers:integer);
begin	
	if(cantPares>cantImpares) then
		cantPers:=cantPers+1;
end;
procedure rellenoVector (var v:vector;L:lista);
begin
	v[L^.dato.codigo]:=v[L^.dato.codigo]+1;
end;
procedure maximos(v:vector;codigo:integer;var max1,max2:integer; var cod1,cod2:integer);
var
	i:integer;
begin
	for i:=1 to dimF do begin
		if(v[i]>max1) then begin
			max2:=max1;
			max1:=v[i];
			cod2:=cod1;
			cod1:=codigo;
		end
		else
		if(v[i]>max2) then begin
			max2:=v[i];
			cod2:=codigo;
		end;
	end;
end;

var
	L:lista;
	cantPares,cantImpares,cantPers,max1,max2,cod1,cod2:integer;
	v:vector;
begin
	max1:=-1;
	max2:=-1;
	cod1:=-1;
	cod2:=-1;
	L:=nil;
	cantPers:=0;
	cargarVector(v);
	cargarLista(L);
	while(L<>nil) do begin
		cantImpares:=0;
		cantPares:=0;
		descomponer(L,cantPares,cantImpares);
		personasMasPares(L,cantPares,cantImpares,cantPers);
		rellenoVector(v,L);
		maximos(v,L^.dato.codigo,max1,max2,cod1,cod2);
		L:=L^.sig;
	end;
	writeln('la cantidad de personas cuyo dni contiene mas digitos pares que impares es de: ',cantPers);
	writeln('el codgio de genero mas elegido es: ',cod1,' y el segundo codgio de genero mas elegido es: ',cod2);
end.
