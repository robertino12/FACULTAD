program ej5;
const
	dimF=10;
type	
	rango= 1..dimF;
	vector= array [rango] of integer;
procedure leervector (var v:vector;var dimL:integer);
var
	n:integer;
begin
	writeln('Escribe un numero');
    readln(n);
	while (dimL<>dimF)and(n<>0) do begin;
		dimL:=dimL+1;
		v[dimL]:=n;
		writeln(v[dimL],'en la posicion',dimL);
		writeln('----------------------------------');
		writeln('Escribe un numero');
		readln(n);	
	end;
end;
procedure maximo (v:vector;var elemMax:integer; var posmax:integer;dimL:integer);
var
	i:rango;
begin
	for i:=1 to dimL do
		if(v[i]>elemMax) then begin
			elemMax:=v[i];
			posmax:=i;
		end;
end;
procedure minimo (v:vector; var elemMin,posmin:integer;dimL:integer);
var
	i:rango;
begin
	for i:=1 to dimL do
		if(v[i]<elemMin) then begin
			elemMin:=v[i];
			posmin:=i;
		end;
end;
procedure intercambio (v:vector;var elemMax:integer;posmax:integer;var elemMin:integer;posmin:integer;dimL:integer);
var
	c:integer;
	aux:integer;
begin
	aux:=v[elemMax];
	v[elemMax]:=v[elemMin];
	v[elemMin]:=aux;
	writeln('El elemento maximo: ',elemMax,'que se encontraba en la posicion: ',posmax,'fue intercambiado con el elemento minimo: ',elemMin,'que se encontraba en la posicion: ',posmin);
	for c:=1 to dimL do
		writeln(v[c],'en la posicion: ',c);
end;
var
	vec:vector;
	dimlogic:integer;
	elementoMax:integer;
	posicionMax:integer;
	elementoMin:integer;
	posicionMin:integer;
begin
	elementoMax:=-1;
	posicionMax:=0;
	dimlogic:=0;
	elementoMin:=100;
	posicionMin:=0;
	leervector(vec,dimlogic);
	maximo(vec,elementoMax,posicionMax,dimlogic);
	minimo(vec,elementoMin,posicionMin,dimlogic);
	intercambio(vec,elementoMax,posicionMax,elementoMin,posicionMin,dimlogic);
end.
{
10 en la pos 1
20 en la pos 2
30 en la pos 3
40 en la pos 4
se realizan los intercambios, 40 vale 10 y 10 vale 40
desp cuando lee el vector deberia dar
40 en la posicion 1
20 en la posicion 2
30 en la posicion 3
10 en la posicion 4}
