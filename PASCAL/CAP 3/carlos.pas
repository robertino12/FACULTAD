program ejercicio8; 
type
  infodocente=record
    DNI:integer;
    nombre:string;
    apellido:string;
    email:string;
  end;
  proyecto=record
    anoConvocatoria:integer;
    codigo:integer;
    titulo:string;
    docente:infodocente;
    cantalumnos:integer;
    nombreEs:string;
    localidad:string;
  end;
procedure leerInfoDocente (var i:infodocente);
begin
  writeln('Ingresar el DNI del docente');
  readln(i.DNI);
  writeln('Ingresar el nombre del docente');
  readln(i.nombre);
  writeln('Ingresar el apellido del docente');
  readln(i.apellido);
  writeln('Ingresar el email del docente');
  readln(i.email);
end;
procedure leerProyecto (var p:proyecto);
begin
  writeln('Ingresar el año de la convocatoria');
  readln(p.anoConvocatoria);
  writeln('Ingresar el codigo del proyecto');
  readln(p.codigo);
  if(p.codigo<>-1) then begin
  writeln('Ingresar el titulo del proyecto');
  readln(p.titulo);
  writeln('Ingresar la informacion del docente');
  leerInfoDocente(p.docente);
  writeln('Ingresar la cantidad de alumnos que participan del proyecto');
  readln(p.cantalumnos);
  writeln('Ingresar el nombre de la escuela donde se hace el proyecto');
  readln(p.nombreEs);
  writeln('Ingresar la localidad donde se va a hacer el proyecto');
  readln(p.localidad);
  end;
  writeln('----------------------------------------------------------------------------------');
end;
procedure maximos (namescul:string;cantpendejos:integer;var nameEsmax1,nameEsmax2:string; var maxpendejos1,maxpendejos2:integer);
begin
  if(cantpendejos>maxpendejos1) then begin
    maxpendejos2:=maxpendejos1;
    maxpendejos1:=cantpendejos;
    nameEsmax2:=nameEsmax1;
    nameEsmax1:=namescul;
  end
  else
  if(cantpendejos>maxpendejos2) then begin
    maxpendejos2:=cantpendejos;
    nameEsmax2:=namescul;
  end;
end;
procedure descomponerCodigo(codigo:integer;var cantdigpares,cantdigimpares:integer);
var
dig:integer;
begin
  while(codigo<>0) do begin
    dig:=codigo MOD 10;
    if(dig MOD 2=0) then
      cantdigpares:=cantdigpares+1
    else
      cantdigimpares:=cantdigimpares+1;
    codigo:=codigo DIV 10;
  end;
end;
function esDaireaux(p:proyecto):boolean;
begin
  esDaireaux:=(p.localidad='daireaux');
end;
var
  proyect:proyecto;
  localidadActual:string;
  escuelaActual:string;
  nombreEsmax1,nombreEsmax2:string;
  maxparticipantes1,maxparticipantes2:integer;
  cantEsConv,cantEsLoc,cantdigitospares,cantdigitosimpares:integer;
BEGIN
  nombreEsmax1:=' ';
  nombreEsmax2:=' ';
  maxparticipantes1:=-1;
  maxparticipantes2:=-1;
  cantEsConv:=0;
  cantdigitospares:=0;
  cantdigitosimpares:=0;
  leerProyecto(proyect);	
  while(proyect.codigo<>-1) do begin
    cantEsLoc:=0;
    localidadActual:=proyect.localidad;
    if(proyect.anoConvocatoria=2018) then 
          cantEsConv:=cantEsConv+1;
    while(proyect.localidad=localidadActual)and(proyect.codigo<>-1) do begin
      descomponerCodigo(proyect.codigo,cantdigitospares,cantdigitosimpares);
      if(esDaireaux(proyect))and(cantdigitospares=cantdigitosimpares) then
        writeln('El titulo de los proyectos de la localidad Daireaux cuyo codigo posee igual cantidad de digitos pares e impares es: ',proyect.titulo);
      cantEsLoc:=cantEsloc+1;
      escuelaActual:=proyect.nombreEs;
      while(proyect.nombreEs=escuelaActual)and(proyect.codigo<>-1) do begin
        leerProyecto(proyect);
      end;
      maximos(escuelaActual,proyect.cantalumnos,nombreEsmax1,nombreEsmax2,maxparticipantes1,maxparticipantes2);
    end;
    writeln('La cantidad de escuelas para la localidad: ',localidadActual,' ','es de: ',cantEsloc);
  end;
  writeln('La cantidad de escuelas que participan en la convocatoria 2018 son de: ',cantEsConv);
  writeln('El nombre de la escuela con mayor cantidad de alumnos participantes es: ',nombreEsmax1,' ','y el nombre de la segunda escuela con mayor cantidad de alumnos participantes es: ',nombreEsmax2);
END.

