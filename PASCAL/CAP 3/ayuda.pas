program ejercicio7;
type
  centro=record
    nombre:string;
    universidad:string;
    cantinvestig:integer;
    cantbecarios:integer;
end;
procedure leerDatos(var c:centro);
begin
  writeln('Ingresar el nombre del centro');
  readln(c.nombre);
  writeln('Ingresar a la universidad a la que pertenece');
  readln(c.universidad);
  writeln('Ingresar la cantidad de investigdores');
  readln(c.cantinvestig);
  if (c.cantinvestig<>0) then begin
  writeln('Ingresar la cantidad de becarios');
  readln(c.cantbecarios);
  end;
  writeln('--------------------------------------------------');
end;
procedure maxUni (nameuni:string;cantinvest:integer;var contenedor:integer;var max1:integer; var maxnameuni:string);
begin
  contenedor:=contenedor+cantinvest;
  if(contenedor>max1) then begin
    max1:=contenedor;
    maxnameUni:=nameuni;
  end;
end;
procedure minBec (namecentro:string;cantbec:integer;var minbec1,minbec2:integer; var minNameCentro1,minNameCentro2:string);
begin 
  if(cantbec<minbec1) then begin
  minbec2:=minbec1;
  minbec1:=cantbec;
  minNameCentro2:=minNameCentro1;
  minNameCentro1:=namecentro;
  end
  else
  if(cantbec<minbec2) then begin
  minbec2:=cantbec;
  minNameCentro2:=namecentro;
  end;
end;
var
center:centro;
uniActual,maxNombreUni:string;
cantTotal,contenedorsito,maximo1:integer;
minimobec1,minimobec2:integer;
minimoNombreCentro1,minimoNombreCentro2:string;
BEGIN	
minimobec1:=1000;
minimobec2:=1000;
minimoNombreCentro1:=' ';
minimoNombreCentro2:=' ';
maximo1:=-1;
maxNombreUni:=' ';
leerDatos(center);
while(center.cantinvestig<>0) do begin
  contenedorsito:=0;
  cantTotal:=0;
  uniActual:=center.universidad;
  while(center.universidad=uniActual)and(center.cantinvestig<>0) do begin
    cantTotal:=cantTotal+1;
    maxUni(center.universidad,center.cantinvestig,contenedorsito,maximo1,maxNombreUni);
    minBec(center.nombre,center.cantbecarios,minimobec1,minimobec2,minimoNombreCentro1,minimoNombreCentro2);
    leerDatos(center);
  end;
  writeln('La cantidad de centros para',uniActual,' ','es de: ',cantTotal);
end;
  writeln('La universidad con mayor cantidad de investigadores en sus centros es: ',maxNombreUni);
  writeln('El centro con menor cantidad de becarios es: ',minimoNombreCentro1,' ','y el segundo centro con menor cantidad de becarios es: ',minimoNombreCentro2);
END.

{contenedor:=contenedor+cantinvestig; 
if contenedor>max1
max1:=contenedor;
maxnameUni:=nameuni}
