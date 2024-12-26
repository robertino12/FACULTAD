program ej1a;
const
dimf=500;
type
	rango=1..dimf;
	vector= array [rango] of integer;
procedure cargarvector (var v:vector;var diml:integer);
begin
	writeln('escribir un numero en la pos: ',diml);
	readln(v[diml]);
	writeln('----------------------');
end;
procedure imprimir (v:vector;diml:integer);
var
	n:integer;
	i:rango;
	aux:integer;
begin
	aux:=0;
	writeln('escribir el numero que desea encontrar en el vector');
	readln(n);
	for i:=1 to diml do
		if(v[i]=n) then 
			aux:=i;
	if(aux<>0) then
		writeln('el valor: ',n,' ',' se encuentra en el vector, en la posicion: ',aux)
	else
		writeln('el valor que busca no se encuentra en el vector');
end;
var
	vec:vector;
	dimlogic:integer;
begin
	dimlogic:=1;
	cargarvector(vec,dimlogic);
	while(vec[dimlogic]<>0) do begin
		dimlogic:=dimlogic+1;
		cargarvector(vec,dimlogic);
	end;
	imprimir(vec,dimlogic);	
end.
