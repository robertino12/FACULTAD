program ej3;
const
	dimf=200;
	dimfranguito=31;
type
	ranguito=1..dimfranguito;
	rango=1..dimf;
	viajes=record
		dia:ranguito;
		montodinero:real;
		distkm:integer;
	end;
	vector=array [rango] of viajes;
procedure cargarvector (var v:vector;diml:integer);
begin
	writeln('escribir la informacion del viaje en la pos: ',diml);
	writeln('escribir la distancia recorrida por el camion');
	readln(v[diml].distkm);
	if(v[diml].distkm<>0) then begin
		writeln('escribir el dia en el que se realizo el viaje');
		readln(v[diml].dia);
		writeln('escribir el monto de dinero transportado');
		readln(v[diml].montodinero);
	end;
	writeln('---------------------------------------------');
end;
procedure montoprom(v:vector;diml:integer;var suma:real;var promedio:real);
var
	aux:real;
begin
	aux:=v[diml].montodinero;
	suma:=suma+aux;
	promedio:=suma/diml;
end;
procedure minimo (v:vector;diml:integer;var min1:real;var distrecor:integer;var diames:ranguito);
begin
		if(v[diml].montodinero<min1) then begin
			min1:=v[diml].montodinero;
			distrecor:=v[diml].distkm;
			diames:=v[diml].dia;
		end;
end;
procedure eliminar(var v:vector;diml:integer);
begin
	if(v[diml].distkm=100) then
		v[diml]:=;		{NO SE Q HAY Q PONER ACA PARA ELIMINARLO}
end;
procedure imprimireliminar(v:vector;diml:integer);
var
	i:rango;
begin
	for i:=1 to diml do 
		writeln('en el viaje ',i,' se lee la siguiente informacion');
end;
var
	vec:vector;
	dimlogic:integer;
	min,sumas,promedios:real;
	distrecorrida:integer;
	diamesuli:ranguito;
begin
	sumas:=0;
	promedios:=0;
	min:=1000;
	distrecorrida:=1000;
	diamesuli:=1;
	dimlogic:=1;
	cargarvector(vec,dimlogic);
	while(dimlogic<dimf) and (vec[dimlogic].distkm<>0) do begin
		montoprom(vec,dimlogic,sumas,promedios);
		minimo(vec,dimlogic,min,distrecorrida,diamesuli);
		eliminar(vec,dimlogic);
		dimlogic:=dimlogic+1;
		cargarvector(vec,dimlogic);
	end;
	imprimireliminar(vec,dimlogic);
	writeln('el monto promedio transportado de los viajes realizados es: ',promedios:1:2);
	writeln('en el viaje que menos dinero se transporto se realizo el dia: ',diamesuli,' y con un distancia recorrida de: ',distrecorrida);
end.

{	vectardo=array[ranguito] of integer;
procedure inicializar (var vectorsito:vectardo);
var
	i:ranguito;
begin
	for i:=1 to dimfranguito do
		v[i]:=0;
end;
procedure cargarvectardo (var vectorsito:vectardo);
var
begin	
end;}
{no se como ahcer el inciso 3b}
