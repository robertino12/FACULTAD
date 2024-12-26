program ej12;
const
	dimF=6;
type
	rango=1..dimF;
	str=string[20];
	infogalaxia=record
		nombre:str;
		tipo:str;
		masa:integer;
		parsecs:real;
	end;
	vector=array [rango] of infogalaxia;
procedure leerRegistro(var i:infogalaxia);
begin
	writeln('Escribir el nombre de la galaxia');
	readln(i.nombre);
	writeln('Escribir el tipo de la galaxia');
	readln(i.tipo);
	writeln('Escribir la masa de la galaxia');
	readln(i.masa);
	writeln('Escribir la distancia medida desde la tierra de la galaxia');
	readln(i.parsecs);
end;
procedure cargarVector (var v:vector);
var
	i:integer;
begin
	for i:=1 to dimF do begin
	writeln('en la posicion: ',i);
	writeln('Escribir la informacion de la galaxia');
	leerRegistro(v[i]);
	writeln('--------------------------------');
	end;
end;
procedure cantGalaxias (v:vector);
var
	i:rango;
	cantelip,cantespi,cantlenti,cantirre:integer;
begin
	cantelip:=0;
	cantespi:=0;
	cantlenti:=0;
	cantirre:=0;
	for i:=1 to dimF do begin
		if(v[i].tipo='eliptica') then
			cantelip:=cantelip+1
		else
		if(v[i].tipo='espiral') then
			cantespi:=cantespi+1
		else
		if(v[i].tipo='lenticular') then
			cantlenti:=cantlenti+1
		else
		if(v[i].tipo='irregular') then
			cantirre:=cantirre+1;
	end;
	writeln('La cantidad de galaxias del tipo elipticas es de: ',cantelip);
	writeln('La cantidad de galaxias del tipo espiral es de: ',cantespi);
	writeln('La cantidad de galaxias del tipo lenticular es de: ',cantlenti);
	writeln('La cantidad de galaxias del tipo irregular es de: ',cantirre);
end;
function masaTodas(v:vector):integer;
var
	i:rango;
	contenedormasa:integer;
begin
	contenedormasa:=0;
	for i:=1 to dimF do 
		contenedormasa:=contenedormasa+v[i].masa;
	masaTodas:=contenedormasa;
end;
function masaTotal3(v:vector):integer;
var
	i:rango;
	masaAcumulada:integer;
begin
	masaAcumulada:=0;
	for i:=1 to dimF do begin
		if(v[i].nombre='la via lactea') then
			masaAcumulada:=masaAcumulada+v[i].masa
		else
		if(v[i].nombre='andromeda') then
			masaAcumulada:=masaAcumulada+v[i].masa
		else
		if(v[i].nombre='triangulo') then
			masaAcumulada:=masaAcumulada+v[i].masa;
	end;
	masaTotal3:=masaAcumulada;
end;
function porcentaje (v:vector):real;
var
	porcentajito:real;
begin
	porcentajito:=(masaTotal3(v)*100)/masaTodas(v);
	porcentaje:=porcentajito;
end;
function noIrregulares (v:vector):integer;
var
	i:rango;
	cant:integer;
begin
	cant:=0;
	for i:=1 to dimF do
		if(v[i].tipo<>'irregular')and(v[i].parsecs<1000) then
			cant:=cant+1;
	noIrregulares:=cant;
end;
procedure maxYmin(v:vector;var nombremax1,nombremax2,nombremin1,nombremin2:str; var max1,max2,min1,min2:integer); 
var
	i:rango;
begin
	for i:=1 to dimF do begin
		if(v[i].masa>max1)then begin
			max2:=max1;
			max1:=v[i].masa;
			nombremax2:=nombremax1;
			nombremax1:=v[i].nombre;
		end
		else
		if(v[i].masa>max2)then begin
			max2:=v[i].masa;
			nombremax2:=v[i].nombre;
		end;
		if(v[i].masa<min1) then begin
			min2:=min1;
			min1:=v[i].masa;
			nombremin2:=nombremin1;
			nombremin1:=v[i].nombre;
		end
		else
		if(v[i].masa<min2) then begin
			min2:=v[i].masa;
			nombremin2:=v[i].nombre;
		end;
	end;		
end;
var
	vec:vector;
	namemax1,namemax2,namemin1,namemin2:str;
	maximo1,maximo2,minimo1,minimo2:integer;
begin
	namemax1:='';
	namemax2:='';
	namemin1:='';
	namemin2:='';
	maximo1:=-1;
	maximo2:=-1;
	minimo1:=1000;
	minimo2:=1000;
	cargarVector(vec);
	cantGalaxias(vec);
	writeln('El porcentaje que representa la masa total acumulada de las 3 galaxias respecto a la masa de todas las galaxias es de: ',porcentaje(vec):1:2,'%');
	writeln('La cantidad de galaxias no irregulares que se encuentran a menos de 1000pc es de: ',noIrregulares(vec));
	maxYmin(vec,namemax1,namemax2,namemin1,namemin2,maximo1,maximo2,minimo1,minimo2);
	writeln('El nombre de la galaxia con mayor masa es: ',namemax1,' ',' y el nombre de la segunda galaxia con mayor masa es: ',namemax2);
	writeln('El nombre de la galaxia con menor masa es: ',namemin1,' ',' y el nombre de la segunda galaxia con menor masa es: ',namemin2);
end.

