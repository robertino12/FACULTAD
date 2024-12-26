program ej4;
const
	dimf=3;
type
	rango=1..dimf;
	str20=string[20];
	infoalumno=record
		nro:integer;
		apellido:str20;
		nombre:str20;
		cantasis:integer;
	end;
	vector = array [rango] of infoalumno;
procedure leervector(var v:vector;diml:integer);
begin
	writeln('escribir el numero del alumno');
	readln(v[diml].nro);
	writeln('escribir el apellido del alumno');
	readln(v[diml].apellido);
	writeln('escribir el nombre del alumno');
	readln(v[diml].nombre);
	writeln('escribir la cantidad de asistencias del alumno');
	readln(v[diml].cantasis);
end;
procedure ordenar (var v:vector;diml:integer);
var
	i,j,p,item:integer;
begin
	for i:= 1 to diml -1 do begin
		p:=i;
		for j:=i+1 to diml do
			if (v[j].nro < v[p].nro) then
				p:=j;
		item:=v[p].nro;
		v[p].nro:=v[i].nro;
		v[i].nro:=item;
	end;	
end;
procedure imprimirvector(v:vector;diml:integer);
var i:rango;
begin
	for i:=1 to diml do
		writeln('en la posicion: ',i);
		writeln(v[i].nro);
		writeln(v[i].apellido);
		writeln(v[i].nombre);
		writeln(v[i].cantasis);
end;
var
	vec:vector;
	dimlogic:integer;
begin
	dimlogic:=1;
	leervector(vec,dimlogic);
	while(dimlogic<dimf) do begin
		leervector(vec,dimlogic);
		dimlogic:=dimlogic+1;
	end;
	ordenar(vec,dimlogic);
	imprimirvector(vec,dimlogic);
end.
{NO ES ASI NO SE COMO SE HACE}
