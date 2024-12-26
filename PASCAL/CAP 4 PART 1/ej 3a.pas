program Vectores;
const
dimF=10;
type
 vectardo= array[1..dimF] of integer;
procedure leerVector(var p:vectardo);
var
i:integer;
begin
  for i:= 1 to dimF do begin
    writeln('Ingresar un numero');
    read(p[i]);
  end;
end;
procedure imprimirVector(var p:vectardo);
var
i:integer;
begin
  for i:= 1 to dimF do begin
    write(p[i],'-');
  end;
end;
var
vector:vectardo;
begin
leerVector(vector);
imprimirVector(vector);
end.
