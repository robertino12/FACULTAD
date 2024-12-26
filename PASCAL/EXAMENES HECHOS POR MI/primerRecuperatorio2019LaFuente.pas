program title;
const
	dimf=3;
type
	str=string[50];
	subrango=1..dimf;
	tipoBecas=record
		codigo:subrango;
		denominacion:str;
		montoMensual:integer;
	end;
	vBecas=array[subrango]of tipoBecas;//SE DISPONE
	infoBecas=record
		dniAlumno:integer;
		codBeca:subrango;
		facultadEstudia:str;
		ciudadAlumno:str;
	end;
	lista=^nodo;
	nodo=record
		dato:infoBecas;
		sig:lista;
	end;
	vMontoTotal=array[subrango]of integer;
//---------------------------------------------------------------------------------
//PROCESOS PARA INFORMAR
procedure cantTotalDinero (codigoBeca:integer;v:vBecas;var cantTotal:integer);
var
	i:integer;
begin
	cantTotal:=0;
	for i:=1 to dimf do begin
		if(v[i].codigo=codigoBeca)then
			cantTotal:=12*v[i].montoMensual;
	end;
end;//ME TIRA BIEN SOLO LA CANTIDAD DEL ULTIMO QUE PONGO LOS DEMAS M DAN NEGATIVO, VOY A AHCER CON UN VECTOR CONTADOR QUE SERIA MAS FACIL
function descomponer (dni:integer):boolean;
var
	dig:integer;
	cantPares:integer;
	cumple:boolean;
begin
	cantPares:=0;
	while(dni<>0) do begin
		dig:=dni mod 10;
		if(dig mod 2=0) then
			cantPares:=cantPares+1;
		dni:=dni div 10;
	end;
	if(cantPares<=3)then
		cumple:=true;
	descomponer:=cumple;
end;
//PROCESO PARA RECORRER E INFORMAR 
procedure recorrerEInformar (l:lista;v:vBecas{;var vec:vMontoTotal});
var
	{i:integer;}
	cantTotal:integer;
	cantBecasAsignadas:integer;
	cantAlumnos:integer;
begin
	cantAlumnos:=0;
	cantBecasAsignadas:=0;
	while(l<>nil) do begin//cada nodo es uma beca otorgada
		cantTotalDinero(l^.dato.codBeca,v,cantTotal);
		writeln('la cantidad total de dinero otorgado a la beca de tipo: ',l^.dato.codBeca,' es de: ',cantTotal);
		{vec[l^.dato.codBeca]:=v[l^.dato.codBeca].montoMensual*12;}//ME DA LO MISMO QUE COMO LO HICE ARRIBA, ME DA UNA BIEN Y LOS OTROS CON VALORES NEGATIVOS
		if(l^.dato.facultadEstudia='informatica')and(l^.dato.ciudadAlumno='la plata')or(l^.dato.ciudadAlumno='beriso')or(l^.dato.ciudadAlumno='ensenada')then
			cantBecasAsignadas:=cantBecasAsignadas+1;
		if(descomponer(l^.dato.dniAlumno)=true)then
			cantAlumnos:=cantAlumnos+1;
		l:=l^.sig;//se dan por mes y dice q es durante el año 2019 osea x cada mes se otorga una beca
	end;
	{for i:=1 to dimf do 
		writeln('la cantidad total de dinero otorgado a la beca de tipo: ',i,' es de: ',vec[i]);}
	writeln('la cantidad de becas asignadas a alumnos con ciertas condiciones es: ',cantBecasAsignadas);
	writeln('la cantidad de alumnos cuyo dni... es de: ',cantAlumnos);
end;
//PRROCESO PARA CARGAR VECTOR
procedure leerTipoBecas (var t:tipoBecas);
begin
	write('escribir el codigo de beca: ');
	readln(t.codigo);
	write('escribir la denominacion de la beca: ');
	readln(t.denominacion);
	write('escribir el monto mensual de la beca: ');
	readln(t.montoMensual);
	writeln('---------------------');
end;
procedure cargarVector (var v:vBecas);
var
	i:integer;
	t:tipoBecas;
begin
	for i:=1 to dimf do begin
		writeln('escribir el tipo de beca en la posicion: ',i);
		leerTipoBecas(t);
		v[i]:=t;
	end;
end;
procedure vectorQurContieneMontoTotal (var vec:vMontoTotal);
var
	i:integer;
begin
	for i:=1 to dimf do 
		vec[i]:=0;
end;

//PROCESO PARA CARGAR LA LISTA
procedure leerInfoBecas (var i:infoBecas);
begin
	write('escribir el dni del alumno: ');
	readln(i.dniAlumno);
	write('escribir el codigo de beca: ');
	readln(i.codBeca);
	write('escribir la facultad en la que estudia el alumno: ');
	readln(i.facultadEstudia);
	write('escribir la ciudad del alumno: ');
	readln(i.ciudadAlumno);
	writeln('----------------------------------------------');
end;
procedure agregarAdelante (var l:lista;i:infoBecas);
var
	nue:lista;
begin
	new(nue);
	nue^.dato:=i;
	nue^.sig:=l;
	l:=nue;
end;
procedure cargarLista (var l:lista);
var
	i:infoBecas;
begin
	repeat
		leerInfoBecas(i);
		agregarAdelante(l,i);
	until(i.dniAlumno=290);
end;


//PROGRAMA PRINCIPAL
var
	l:lista;
	v:vBecas;
	{vec:vMontoTotal;}
begin
	l:=nil;
	cargarLista(l);
	cargarVector(v);
	{vectorQurContieneMontoTotal(vec);}
	recorrerEInformar(l,v{,vec});
end.
