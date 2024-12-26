program ej2;
const
	dimf=500;
type
	str20=string[20];
	rango=1..dimf;
	vector=array[rango]of str20;
procedure cargarvector (var v:vector; var diml:integer);
begin
	writeln('en la pos: ',diml,' escribir el nombre del alumno');
	readln(v[diml]);
	writeln('-------------------------------------');
end;
procedure insertar (var v:vector;diml:integer);
var
	i:rango;
	n:string;
begin
	writeln('escribir un nombre para insertar en la pos4');
	readln(n);
	for i:=1 to diml do
		if(i=4) then
			v[i]:=n;
end;
procedure imprimir (v:vector;diml:integer);
var
	i:rango;
begin
	for i:=1 to diml do
		writeln(v[i],' en la posicion: ',i);
end;
procedure imprimirinsertar(v:vector;diml:integer);
var
	i:rango;
begin
	for i:=1 to diml do
		writeln(v[i],' en la posicion: ',i);
end;
procedure eliminar (var v:vector;diml:integer);
var
	i:rango;
	n:str20;
begin
	writeln('escribir el nombre que se vaya a eliminar');
	readln(n);
	for i:=1 to diml do
		if(v[i]=n) then
			v[i]:='';
end;
procedure imprimireliminar (v:vector;diml:integer);
var 
	i:rango;
begin
	for i:=1 to diml do
		writeln(v[i],'en la posicion: ',i);
end;
procedure agregar (var v:vector;var diml:integer);
var
	n:str20;
begin
	writeln('escribir el nombre el cual se va a agregar al vector');
	readln(n);
	if(diml<dimf) then begin
		diml:=diml+1;
		v[diml]:=n;
	end
	else
		writeln('la dimension fisica esta llena');
end;
procedure imprimiragregar(v:vector;diml:integer);
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
	while(vec[dimlogic]<>'zzz') do begin
		dimlogic:=dimlogic+1;
		cargarvector(vec,dimlogic);
	end;
	imprimir(vec,dimlogic);
	eliminar(vec,dimlogic);
	imprimireliminar(vec,dimlogic);
	insertar(vec,dimlogic);
	imprimirinsertar(vec,dimlogic);
	agregar(vec,dimlogic);
	imprimiragregar(vec,dimlogic);
end.
