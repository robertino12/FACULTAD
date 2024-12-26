program ej9;
const
	dimF=5;
type
	str=string[20];
	alumnos=record
		nroIns:integer;
		DNI:integer;
		apellido:str;
		nombre:str;
		anoNaci:integer;
	end;
	rango=1..dimF;
	vector=array [rango] of alumnos;
procedure leerRegistro (var a:alumnos);
begin
	writeln('Escribir el nro de inscripcion del alumno');
	readln(a.nroIns);
	writeln('Escribir el dni del alumno');
	readln(a.DNI);
	if(a.DNI<>-1) then begin
		writeln('Escribir el apellido del alumno');
		readln(a.apellido);
		writeln('Escribir el nombre del alumno');
		readln(a.nombre);
		writeln('Escribir el año de nacimiento del alumno');
		readln(a.anoNaci);
	end;
	writeln('---------------------------');
end;
procedure leerVector( var v:vector;var dimL:integer);
begin
	leerRegistro(v[dimL]);
	writeln('en la posicion',dimL);
	writeln('----------------------------------');
	while(dimL<>dimF) and (v[dimL].DNI<>-1) do begin
		dimL:=dimL+1;
		leerRegistro(v[dimL]);
		writeln('en la posicion',dimL);
		writeln('----------------------------------');
	end;
end;
procedure porcentaje (v:vector;var porcentaje:real;dimL:integer);
var
	i,dig:rango;
	cant:integer;
begin
	cant:=0;
	for i:=1 to dimL do begin
		while(v[i].DNI<>0) do begin
			dig:=v[i].DNI mod 10;
			if(dig mod 2=0) then				
				v[i].DNI:=v[i].DNI div 10;
		end;
		cant:=cant+1;
	end;
	porcentaje:= (cant*100)/dimL;
end;
procedure maximos (v:vector;var apellidomax1,apellidomax2:str;var nombremax1,nombremax2:str;var maxedad,maxedad2:integer;dimL:integer);
var
	i:rango;
begin
	for i:=1 to dimL do begin
		if(v[i].anoNaci<maxedad) then begin
			maxedad2:=maxedad;
			nombremax2:=nombremax1;
			apellidomax2:=apellidomax1;
			maxedad:=v[i].anoNaci;
			nombremax1:=v[i].nombre;
			apellidomax1:=v[i].apellido;
		end
		else 
		if(v[i].anoNaci<maxedad2) then begin
			maxedad2:=v[i].anoNaci;
			nombremax2:=v[i].nombre;
			apellidomax2:=v[i].apellido;
		end;
	end;
end;
var
	vec:vector;
	dimlogic:integer;
	porcen:real;
	maxage,maxage2:integer;
	apellmax1,apellmax2,namemax1,namemax2:str;
begin
	dimlogic:=1;
	apellmax1:=' ';
	apellmax2:=' ';
	namemax1:=' ';
	namemax2:=' ';
	maxage:=3000;
	maxage2:=3000;
	porcen:=0;
	leerVector(vec,dimlogic);
	porcentaje(vec,porcen,dimlogic);
	writeln('El porcentaje de alumnos con DNI compuesto solo por digitos pares es: ',porcen);
	maximos(vec,apellmax1,apellmax2,namemax1,namemax2,maxage,maxage2,dimlogic);
	writeln('El apellido y nombre del alumno con mayor edad es: ',apellmax1,namemax1,' y el apellido y nombre del segundo alumno con mayor edad es: ',apellmax2,namemax2);
end.
