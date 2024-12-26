program title;
const
	dimf=10;
type
	subrango=4..dimf;
	subrangoDos=1..4;
	str=string[50];
	vAsistencia=array[1..12]of integer;
	infoAlumno=record
		dni:integer;
		nombre:str;
		apellido:str;
		notaObtenidaCursoIngreso:subrango;
		turno:subrangoDos;
		asistencia:vAsistencia;
	end;
	lista=^nodo;//SE DISPONE
	nodo=record
		dato:infoAlumno;
		sig:lista;
	end;
	nuevaLista=^nodoNuevo;
	infoAlumnoNuevaLista=record
		dni:integer;
		nombre:str;
		apellido:str;
		notaObtenidaCursoIngreso:subrango;
		turno:subrangoDos;
		asistencia:integer;
	end;
	nodoNuevo=record
		dato:infoAlumnoNuevaLista;
		sig:nuevaLista;
	end;
//---------------------------------------------------------------------------
procedure darValorNuevaLista (var info:infoAlumnoNuevaLista;dni:integer;nombre,apellido:str;notaObtenidaCursoIngreso:subrango;turno:subrangoDos;cantAsistencias:integer);
begin
	info.dni:=dni;
	info.nombre:=nombre;
	info.apellido:=apellido;
	info.notaObtenidaCursoIngreso:=notaObtenidaCursoIngreso;
	info.turno:=turno;
	info.asistencia:=cantAsistencias;
end;
procedure agregarAdelanteNuevaLista (var newL:nuevaLista;info:infoAlumnoNuevaLista);
var
	nue:nuevaLista;
begin
	new(nue);
	nue^.dato:=info;
	nue^.sig:=newL;
	newL:=nue;
end;
procedure cargarVector (var v:vAsistencia;var cantAsistencias:integer);
var
	i:integer;
	asistencia:integer;
begin
	cantAsistencias:=0;
	for i:=1 to 12 do begin
		writeln('escribir uno si el alumno asistio a la clase: ',i);
		readln(asistencia);
		v[i]:=asistencia;
		if(v[i]=1)then
			cantAsistencias:=cantAsistencias+1;
	end;
end;
procedure recorrerEInformar (l:lista;v:vAsistencia;var newL:nuevaLista);
var
	cantAsistencias:integer;
	info:infoAlumnoNuevaLista;
begin
	while(l<>nil) do begin
		cargarVector(v,cantAsistencias);
		if(cantAsistencias>=8) then
			darValorNuevaLista(info,l^.dato.dni,l^.dato.nombre,l^.dato.apellido,l^.dato.notaObtenidaCursoIngreso,l^.dato.turno,cantAsistencias);
			agregarAdelanteNuevaLista(newL,info);
		l:=l^.sig;
	end;
end;
procedure recorrerEInformarNuevaLista (newL:nuevaLista);
begin
	while(newL<>nil) do begin
		newL:=newL^.sig;
	end;
end;
procedure leerInfoAlumno (var i:infoAlumno)//SE DISPONE
begin
end;
procedure agregarAdelante( var l:lista;i:infoAlumno);//SE DISPONE
begin
end;
procedure cargarLista(var l:lista);//se dispone
begin
end;


var
	l:lista;
	newL:nuevaLista;
	v:vAsistencia;
begin
	l:=nil;
	newL:=nil;
	cargarLista(l);//SE DISPONE
	recorrerEInformar(l,v,newL);
end.
