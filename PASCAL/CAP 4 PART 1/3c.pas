program Vectores;
const
  dimF=10;
type
 vectardo= array[1..10] of integer;
procedure leerVector(var p:vectardo;var dimL:integer);
var
i:integer;
begin
  for i:= 1 to dimF do begin
    writeln('Ingresar un numero');
    read(p[i]);
    dimL:=dimL+1;
  end;
end;
procedure imprimirVector(p:vectardo;dimL:integer);
var
i:integer;
dimLdiv2:integer;
begin
dimLdiv2:=(dimL DIV 2);
  for i:= 1 to dimLdiv2 do begin
    writeln('Los numeros que van de la mitad para atras son: ',p[dimLdiv2]);
    dimLdiv2:=dimLdiv2-1;
  end;
end;
procedure imprimirVectorSuma (p:vectardo;dimL:integer);
var
i:integer;
dimLdiv2suma:integer;
begin
dimLdiv2suma:=(dimL DIV 2)+1;
  for i:= dimLdiv2suma to dimF do begin
    writeln('Los numeros que van de la mitad mas uno para adelante son: ',p[i]);
  end;
end;
var
dimlogic:integer;
vector:vectardo;
begin
dimlogic:=0;
leerVector(vector,dimlogic);
imprimirVector(vector,dimlogic);
imprimirVectorSuma(vector,dimlogic);
end.
