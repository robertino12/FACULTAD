program ej7;
const
	dimf=5;
type
	str=string[30];
	vNotas=array[1..dimf]of integer;
	alumno=record
		numero:integer;
		apellido:str;
		nombre:str;
		correoElec:str;
		anioIngreso:integer;
		anioEgreso:integer;
		notas:vNotas;
	end;
	lista=^nodo;
	nodo=record
		dato:alumno;
		sig:lista;
	end;
	
//PROCESOS PARA INFORMAR
procedure promedioAlumnos (v:vNotas;var promedio:real);
var
	sumaNotas:integer;
	i:integer;
begin
	sumaNotas:=0;
	for i:= 1 to dimf do begin
		sumaNotas:=sumaNotas+v[i];
	end;
	promedio:=sumaNotas/dimf;
end;

function descomponer (numAl:integer):boolean;
var
	dig:integer;
	aux:boolean;
begin
	aux:=true;
	while(aux=true)and(numAl<>0) do begin
		dig:=numAl mod 10;
		if(dig mod 2=1) then
			numAl:=numAl div 10
		else
		aux:=false;
	end;
	descomponer:=aux;
end;

procedure masRapidoRecibida (apellido,nombre,correo:str;anioEgreso,anioIngreso:integer;var min1,min2:integer;var apellidoMin1,apellidoMin2,nombreMin1,nombreMin2,correoMin1,correoMin2:str);
var
	cantAniosRecibir:integer;
begin
	cantAniosRecibir:=0;
	cantAniosRecibir:=anioEgreso-anioIngreso;
	if(cantAniosRecibir<min1)then begin
		min2:=min1;
		min1:=cantAniosRecibir;
		apellidoMin2:=apellidoMin1;
		nombreMin2:=nombreMin1;
		correoMin2:=correomin1;
		apellidoMin1:=apellido;
		nombreMin1:=nombre;
		correoMin1:=correo;
	end
	else
		if(cantAniosRecibir<min2) then begin
			min2:=cantAniosRecibir;
			apellidoMin2:=apellido;
			nombreMin2:=nombre;
			correoMin2:=correo;
	end;
end;

Procedure eliminarElementoLista (var l : lista; nuevoNum : integer; var aux : boolean);
var
  act,ant : lista;
begin
  act := l;
  while (act <> nil) and (act^.dato.numero <> nuevoNum) do begin
    ant := act;
    act := act^.sig;
  end;
  if (act <> nil) then begin
    if (act = l) then
      l := l^.sig
    else
      ant^.sig := act^.sig;
    dispose(act);
    aux := true;
  end;
end;

//PROCESOS DE CARGA
procedure leerNotas (var v:vNotas);
var
	i:integer;
	nota:integer;
begin
	for i:=1 to dimf do begin
		writeln('nota de la materia: ',i);
		readln(nota);
		v[i]:=nota;
	end;
end;

procedure VectorDescendente (var v:vNotas);
var
  i,j,p,item : integer;
Begin
  for i := 1 to dimf-1 do begin
    p := i;
    for j := i + 1 to dimf do
      if (v[j] < v[p]) then
        p := j;
    item := v[p];
    v[p] := v[i];
    v[i] := item;
  end;
end;

procedure leerAlumno (var a:alumno);
begin
	write('escribir el numero del alumno: ');
	readln(a.numero);
	if(a.numero<>-1) then begin
		write('escribir el apellido del alumno: ');
		readln(a.apellido);
		write('escribir el nombre del alumno: ');
		readln(a.nombre);
		write('escribir el correo electronico del alumno: ');
		readln(a.correoElec);
		write('escribir el anio del ingreso del alumno: ');
		readln(a.anioIngreso);
		write('escribir el anio de egreso del alumno: ');
		readln(a.anioEgreso);
		writeln('escribir las notas de las ',dimf,' materias del alumno');
		leerNotas(a.notas);
		VectorDescendente(a.notas);
	end;
	writeln('------------------------------');
end;

procedure agregarAdelante(var l:lista;a:alumno);
var
	nue:lista;
begin
	new(nue);
	nue^.dato:=a;
	nue^.sig:=l;
	l:=nue;
end;

procedure cargarLista (var l:lista);
var
	a:alumno;
begin
	leerAlumno(a);
	while(a.numero<>-1)do begin
		agregarAdelante(l,a);
		leerAlumno(a);
	end;
end;


//PROGRAMA PRINCIPAL
var
	l:lista;
	promedio:real;
	cantAl:integer;
	min1,min2:integer;
	apellidoMin1,apellidoMin2,nombreMin1,nombreMin2,correoMin1,correoMin2:str;
	nuevoNum:integer;
	aux:boolean;
begin
	aux:=false;
	min1:=3000;
	min2:=3000;
	apellidoMin1:='';
	apellidoMin2:='';
	nombreMin1:='';
	nombreMin2:='';
	correoMin1:='';
	correoMin2:='';
	cantAl:=0;
	l:=nil;
	cargarLista(l);
	while(l<>nil) do begin
		promedio:=0;
		promedioAlumnos(l^.dato.notas,promedio);
		writeln('el alumno llamado: ',l^.dato.nombre,' tiene un promedio de: ',promedio:1:2);
		if(descomponer(l^.dato.numero)=true)and(l^.dato.anioIngreso=2012)then
			cantAl:=cantAl+1;
		masRapidoRecibida(l^.dato.apellido,l^.dato.nombre,l^.dato.correoElec,l^.dato.anioEgreso,l^.dato.anioIngreso,min1,min2,apellidoMin1,apellidoMin2,nombreMin1,nombreMin2,correoMin1,correoMin2);
		l:=l^.sig;
	end;
	writeln('la cantidad de alumnos ingresante 2012 cuyo numero de alumno compuesto solo por digitos impares es: ',cantAl);
	writeln('el apellido,nombre y correo del alumno que mas rapido se recibio es: ',apellidoMin1,nombreMin1,correoMin1,' y el apellido,nombre y correo del segundo alumno que mas rapido se recibio es: ',apellidoMin2,nombreMin2,correoMin2);
	write('escribir el numero del alumno que desea eliminar: ');
	readln(nuevoNum);
	eliminarElementoLista(l,nuevoNum,aux);
	if(aux=true)then
		writeln('el numero del alumno: ',nuevoNum,' fue eliminado')
	else
		writeln('el numero del alumno no existe');
end.
{ME DICE QUE NUNCA EXISTE EL NUMERO NO SE X Q FALLA}
