procedure ej13;
const
	dimF=4;
type
	mediciones=record
		anio:integer;
		temp:integer;
		puntoPlaneta:integer;
	end;
	vector=array[1..dimF]of mediciones;
procedure cargarReg (var m:mediciones);
begin
	write('escribir anio de la medicion: ');
	readln(m.anio);
	write('escribir temperatura de la medicion: ');
	readln(m.temp);
	write('escribir el punto del planeta donde se hizo la medicion: ');
	readln(m.puntoPlaneta);
	writeln('-----------');
end;
procedure maximo(anio:integer;prom:real;var anioMax:integer;var promMax:real);
begin
	if(prom>promMax)then begin
		promMax:=prom;
		anioMax:=anio;
	end;
end;
procedure maxTemp (anio,temp,punto:integer;var anioMax,tempMax,puntoMax:integer);
begin
	if(temp>tempMax)then begin
		tempMax:=temp;
		anioMax:=anio;
		puntoMax:=punto;
	end;
end;
procedure cargarVector (var v:vector);
var
	i:integer;
	m:mediciones;
	anioAct,puntoActual:integer;
	sumaTemp:integer;
	cantTempMismoAnio:integer;
	promedio,promedioMax:real;
	anioMax,anioMax2,tempMax,puntoMax:integer;
begin
	i:=0;
	promedioMax:=-1;
	anioMax:=-1;
	tempMax:=-1;
	anioMax2:=-1;
	puntoMax:=-1;
	cargarReg(m);
	while(i<dimF) do begin
		anioAct:=m.anio;
		cantTempMismoAnio:=0;
		sumaTemp:=0;
		while(m.anio=anioAct)do begin
			puntoActual:=m.puntoPlaneta;
			while(m.puntoPlaneta=puntoActual)do begin
				i:=i+1;
				v[i]:=m;
				cantTempMismoAnio:=cantTempMismoAnio+1;
				sumaTemp:=sumaTemp+v[i].temp;
				maxTemp(anioAct,v[i].temp,v[i].puntoPlaneta,anioMax2,tempMax,puntoMax);
				cargarReg(m);
			end;
		end;
		promedio:=sumaTemp / cantTempMismoAnio;
		maximo(anioAct,promedio,anioMax,promedioMax);
	end;
	writeln('el anio con mayor temperatura promedio a nivel mundial es: ',anioMax);
	writeln('el anio con la mayort temperatura detectada en el punto del planeta: ',puntoMax,' es: ',anioMax2);
end;	
var
	vec:vector;
begin
	cargarVector(vec);
end. 
