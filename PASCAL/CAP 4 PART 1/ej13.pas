program ej13;
const
	dimF=4;
type
	puntos=1..100;
	anos=1..dimF;
	ipcc=record
		ano:integer;
		temp:real;
		puntosPlaneta:puntos;
	end;
	vector=array [anos] of ipcc;
procedure leerRegistro(var i:ipcc);
begin
	writeln('Escrbibir el ano en el cual fue hecha la medicion de temperatura');
	readln(i.ano);
	writeln('Escribir la medicion de temperatura de este año');
	readln(i.temp); 
	writeln('Escribir el punto del planeta donde se realizo la medicion de temperatura');
	readln(i.puntosPlaneta);
end;
procedure leerVector (var v:vector;var dimL:integer);
var
	promedioanual:real;
	anoActual:integer;
	puntoActual:integer;
	cant:integer;
	suma:real;
begin
	{realiza todos los años mediciones d temperaturas en 100 puntos diferentes del planeta, para cada punto obtiene un promedio anual de las mediciones de temp}
	cant:=0;
	suma:=0;
	writeln('en el año: ',dimL);
	leerRegistro(v[dimL]);
	writeln('--------------------------------------------');
	while(dimL<=dimF) do begin
		anoActual:=v[dimL].ano;
		while(v[dimL].ano=anoActual) do begin
			promedioanual:=0;
			puntoActual:=v[dimL].puntosPlaneta;
			while(v[dimL].puntosPlaneta=puntoActual) do begin
				suma:=suma+v[dimL].temp;
				cant:=cant+1;
				dimL:=dimL+1;
				writeln('en el año: ',dimL);
				leerRegistro(v[dimL]);
				writeln('--------------------------------------------');
			end;
			promedioanual:=suma/cant;
			writeln('El promedio obtenido en el punto del planeta: ',puntoActual,' ','es de: ',promedioanual:1:2);
		end;
	end;	
end;
var
	vec:vector;
	dimlogic:integer;
begin
	dimlogic:=1;
	leerVector(vec,dimlogic);
end.
{puede realizar muchas mediciones d temp en un mismo año, d ahi se saca el promedio y ademas x eso se lee x año}
{si yo leo x localidad, para sacar un promedio anual d ese lugar, tengo que sumar las temperaturas d ese punto y dividirilas x la cant d veces}
