program ej6;
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
procedure maximoYminimo (v:vector;var elemMax:integer; var posmax:integer;dimL:integer;var elemMin,posmin:integer);
var
	i:rango;
begin
	for i:=1 to dimL do begin
		if(v[i]>elemMax) then begin
			elemMax:=v[i];
			posmax:=i;
		end;
		if(v[i]<elemMin) then begin
			elemMin:=v[i];
			posmin:=i;
		end;
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
	maximoYminimo(vec,elementoMax,posicionMax,dimlogic,elementoMin,posicionMin);
	intercambio(vec,elementoMax,posicionMax,elementoMin,posicionMin,dimlogic);
end.
