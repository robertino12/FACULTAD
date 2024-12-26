program ej10;
const
	dimF=300;
type
	rango=1..dimF;
	vector=array[rango] of real;
procedure cargarVector(var v:vector;var dimL:integer);
var
	n:real;
begin
	writeln('Escribir el salario del empleado');
	readln(n);
	while (n<>0) or (dimL=dimF) do begin
		dimL:=dimL+1;
		v[dimL]:=n;
		writeln(v[dimL]:1:2,'en la posicion: ',dimL);
		writeln('--------------------------------');
		writeln('Escribir el salario del empleado');
		readln(n);
	end;
end;
procedure incrementarSalario (var v:vector;dimL:integer;porcentaje15:real);
var
	i:rango;
begin
	for i:= 1 to dimL do begin
		porcentaje15:=(15*v[i])/100;
		v[i]:=v[i]+porcentaje15;
		writeln(v[i]:1:2,'en la posicion: ',i);
	end;
end;
procedure promedio (v:vector;dimL:integer;var suma:real);
var
	i:rango;
begin
	for i:=1 to dimL do
		suma:=suma+v[i];
	writeln('El sueldo promedio de los empleados es de: ',suma/dimL:1:2);
end;
var
	vec:vector;
	dimlogic:integer;
	sumas:real;
	porcentaje:real;
begin
	sumas:=0;
	dimlogic:=0;
	porcentaje:=0;
	cargarVector(vec,dimlogic);
	incrementarSalario(vec,dimlogic,porcentaje);
	promedio(vec,dimlogic,sumas);
end.
