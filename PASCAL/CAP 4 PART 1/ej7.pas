program ej7;
const
	dimF=9;
type
	rango=1..dimF;
	vector=array [rango] of integer;
procedure inicializar (var v:vector;var dimL:integer);
begin
	while(dimL<>dimF) do begin
		v[dimL]:=0;
		writeln(v[dimL],'en la posicion: ',dimL);
		dimL:=dimL+1;
	end;
end;
procedure descomponer(var v:vector;num:integer);
var
	dig:rango;
begin
	while(num<>0) do begin
		dig:=num mod 10;
		v[dig]:=v[dig]+1;
		num:=num div 10;
	end;
end;
function digMax (v:vector;dimL:integer):rango;
var
	i:integer;
	elemMax:integer;
	posMax:integer;
begin
	elemMax:=-1;
	for i:= 1 to dimL do
		if(v[i]>elemMax)then begin
			elemMax:=v[i];
			posMax:=i;
		end;
	digMax:=posMax;
end;
procedure informar (v:vector;dimL:integer);
var
	i:rango;
begin
	for i:=1 to dimL do
		if(v[i]=0) then
			writeln('El digito: ',i,' no tuvo concurrencias')
		else
		if(v[i]<>0) then
		writeln('La cantidad de ocurrencias del digito: ',i,' es de: ',v[i]);
end;
var
	vec:vector;
	dimlogic,n:integer;
begin
	dimlogic:=1;
	inicializar(vec,dimlogic);
	writeln('Escribir un numero');
	readln(n);
	while(n<>-1) do begin
		descomponer(vec,n);
		readln(n);
	end;
	informar(vec,dimlogic);
	writeln('El digito mas leido es: ',digMax(vec,dimlogic));
end.
