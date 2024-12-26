program ej10;
const
	dimF=300;
type
	vector=array[1..dimF] of real;
procedure cargarVector(var v:vector;var dimL:integer);
var
	num:integer;
begin
	write('escribir salario: ');
	readln(num);
	while(dimL<dimF)and(num<>0)do begin
		dimL:=dimL+1;
		v[dimL]:=num;
		write('escribir salario: ');
		readln(num);
	end;
end;
procedure incrementarSalario (var v:vector; num:real; dimL:integer);
var
	i:integer;
begin
	for i:=1 to dimL do begin
		num:=15*v[i]/100;//aca saco el 15% del sueldo del empleado
		v[i]:=v[i]+num;//aca le sumo el 15
	end;
end;
procedure promedio (v:vector;dimL:integer);
var
	i:integer;
	prom,suma:real;
begin
	suma:=0;
	for i:=1 to dimL do begin
		suma:=suma+v[i];
	end;
	prom:=suma/dimL;
	writeln('el sueldo promedio de los empleados es de: ',prom:1:2);
end;
procedure imprimir (v:vector;dimL:integer);
var
	i:integer;
begin
	for i:=1 to dimL do
		writeln('sueldo empleado: ',v[i]:1:2);
end;
var
	vec:vector;
	dimL,num:integer;
begin
	dimL:=0;
	cargarVector(vec,dimL);
	num:=0;
	imprimir(vec,dimL);
	writeln('-----------------');
	incrementarSalario(vec,num,dimL);
	imprimir(vec,dimL);
	writeln('-------------------');
	promedio(vec,dimL);
	
end. 
