{ME FALTA EL INCISO DE LOS MAXIMOS}
program Registros3;
type
  escuela=record
    codigo:integer;
    nombre:string;
    cantidadDocentes:integer;
    cantidadAlumnos:integer;
    localidad:string;
end;
procedure leer (var escu:escuela);
begin
  writeln('Escribir el codigo unico del establecimiento');
  readln(escu.codigo);
  writeln('Escribir el nombre del establecimiento');
  readln(escu.nombre);
  writeln('Escribir la cantidad de docentes en el establecimiento');
  readln(escu.cantidadDocentes);
  writeln('Escribir la cantidad de alumnos en el establecimiento');
  readln(escu.cantidadAlumnos);
  writeln('Escribir la localidad de la escuela');
  readln(escu.localidad);
  writeln('---------------------------');
end;
procedure relacionAlumnosDocentes (cantAlumnos:integer;cantDocentes:integer;var relacion:real);
begin
  relacion:=(cantAlumnos DIV cantDocentes);
end;
function esLaPlata (escu:escuela):boolean;
begin
esLaPlata:=(escu.localidad='La Plata');
end;
procedure maxRelacionDocenteAlumno(relacion:real;CUE:integer;name:string; var CUEmax1,CUEmax2:integer; var namemax1,namemax2:string);
begin
  if(relacion<23.435) then begin
    namemax2:=namemax1;
    namemax1:=name;
    CUEmax2:=CUEmax1;
    CUEmax1:=CUE;
  end
  else 
  if(relacion<23.435) then begin
    namemax2:=name;
    CUEmax2:=CUE;
  end;
end;
{ESTA MAL ESTE PROCESO}
var
relacionAD:real;
e:escuela;
i,cantEscuLp:integer;
codigomax1,codigomax2:integer;
nombremax1,nombremax2:string;
begin
cantEscuLp:=0;
relacionAD:=0;
codigomax1:=-1;
codigomax2:=-1;
nombremax1:=' ';
nombremax2:=' ';
for i:= 1 to 6{va 2400 en realidad} do begin
leer(e);
relacionAlumnosDocentes(e.cantidadAlumnos,e.cantidadDocentes,relacionAD);
maxRelacionDocenteAlumno(relacionAD,e.codigo,e.nombre,codigomax1,codigomax2,nombremax1,nombremax2);
if(relacionAD>23.435) and (esLaPlata(e)) then 
cantEscuLp:=cantEscuLp+1;
end;
writeln('La cantidad de escuelas de La Plata con una relacion de alumnos por docnete superior a la sugerida por UNESCO es de: ', cantEscuLp);
writeln('La escuela con mejor relacion docentes alumnos se llama: ',nombremax1,' ',' y tiene un codigo unico de establecimiento con los siguientes numeros: ', codigomax1);
writeln('La escuela con segunda mejor relacion doncetes alumnos se llama: ',nombremax2,' ','y tiene un codigo unico de establecimiento con los siguientes numeros: ', codigomax2);
end.
