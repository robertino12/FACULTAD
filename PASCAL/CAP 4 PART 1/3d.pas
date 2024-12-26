program Vectores3d;
const
max=10;
type
maxim=1..max;
vdatos = array[maxim] of integer;
procedure cargarVector(var v:vdatos;var dimL : integer);
var
i:integer;
begin
  for i:=1 to max do begin
    read(v[i]);
    dimL:=diml+1;
  end;
end;
procedure posiciones (v:vdatos);
var
x,y,i,c:maxim;
begin
  writeln('Elegir un numero del 1 al 10 que va corresponder con la posicion X del vector');
  readln(x);
  writeln('Elegir un numero del 1 al 10 que va a corresponder con l posicion Y del vector');
  readln(y);  
  if(x<y) then begin
    for i:= x to y do begin
      write(v[i]);
    end;
  end
  else{este else es para cuando x>y}
    for c:= x downto y do begin
      write(v[c]);
    end;
end;    
var
dimlogic:integer;
vec:vdatos;
begin
dimlogic:=0;
cargarVector(vec,dimlogic);
posiciones(vec);
end.ector,dimlogic);
end.
