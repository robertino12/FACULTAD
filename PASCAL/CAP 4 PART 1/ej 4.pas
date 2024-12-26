program ej4a;
const
	dimF=100;
type	
	indice= 1..dimF;
	vector= array [indice] of integer;
procedure leervector (var v:vector;var dimL:integer);
var
i:indice;
begin
	for i:= 1 to dimF do begin
		v[i]:=abs(random(dimF));
		dimL:=dimL+1;
		writeln(v[i],'en la posicion',i);
		writeln('----------------------------------');
	end;
end;
procedure posicion(v:vector);
var
	x:integer;
	aux:integer;
begin
	writeln('Escribir un numero');
	readln(x);
	aux:=1;
	repeat
		aux:=aux+1;
	until(v[aux]=x) or (aux=dimF);
	if(v[aux]=x) then
	  writeln('La posicion del numero',x,' ','es: ',aux)
	else
	  writeln('-1');
end;
procedure intercambio (var v:vector);
var
	x,y,aux,i:integer;
begin
	writeln('Escribir un numero que representara la posicion de x(1-',dimF,')');
	readln(x);
	writeln('Escribir un numero que representara la posicion de y(1-',dimF,')');
	readln(y);
	writeln('------------------------------------------------------');
	aux:=x;
	x:=y;{40}
	y:=aux;{20}
	if(x<y)then{se pone los if debido a que si cambian los valores de las posiciones x e y hay que leer al reves o normal segun quien es mas grande que el otro}
		for i:=x to y do
			writeln(v[i],'en la posicion',i)
	else
	if(x>y) then
		for i:=x downto y do
			writeln(v[i],'en la posicion',i);
	writeln('-----------------------------');
end;
procedure sumarVector (v:vector;var sumas:integer);
var
	i:indice;
begin
	for i:=1 to dimF do
		sumas:=sumas+v[i];
	writeln('El resultado de la suma de todos los elementos del vector es de: ',sumas);
	writeln('------------------------------------------');
end;
procedure promedio (v:vector;sumas:integer);
var
	prom:real;
begin
	prom:=sumas/dimF;
	writeln('El promedio de los elementos del vector es de: ',prom:1:2);
	writeln('-----------------------------------------');
end;
procedure elementoMaximo(v:vector;var elementomax:integer);
var
	i:indice;
	posicion:indice;
begin
	for i:= 1 to dimF do
	  if(v[i]>elementomax) then begin
		elementomax:=v[i];
		posicion:=i;
      end;	
	writeln('El mayor elemento es: ',elementomax,'y su posicion es: ',posicion);
	writeln('---------------------------------------------------------');
end;
procedure elementoMinimo (v:vector; var elementomin:integer);
var
	i:indice;
	posicion:indice;
begin
	for i:=1 to dimF do
		if(v[i]<elementomin) then begin
		  elementomin:=v[i];
		  posicion:=i;
		end;
	writeln('El menor elemento es: ',elementomin,' y su posicion es: ',posicion);
end;
var
	vec:vector;
	dimlogic:integer;
	suma:integer;
	elemax:integer;
	elemin:integer;
begin
	elemin:=1000;
	elemax:=-1;
    suma:=0;
	dimlogic:=0;
	leervector(vec,dimlogic);
	posicion(vec);
	intercambio(vec);
	sumarVector(vec,suma);
	promedio(vec,suma);
	elementoMaximo(vec,elemax);
	elementoMinimo(vec,elemin);
end.
