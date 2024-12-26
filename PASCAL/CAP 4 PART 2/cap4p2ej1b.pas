program ej1b;
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
procedure ordenar (var v:vector;diml:integer);
var
	i,j,p,item:integer;
begin
	for i:= 1 to diml -1 do begin
		p:=i;
		for j:=i+1 to diml do
			if (v[j] < v[p]) then
				p:=j;
		item:=v[p];
		v[p]:=v[i];
		v[i]:=item;
	end;	
end;
procedure imprimirnuevo (v:vector;diml:integer);
var
	i:rango;
begin
	for i:=1 to diml do 
		writeln(v[i],'en la posicion: ',i);
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
	ordenar(vec,dimlogic);	
	imprimirnuevo(vec,dimlogic);
	imprimir(vec,dimlogic);	
end.
