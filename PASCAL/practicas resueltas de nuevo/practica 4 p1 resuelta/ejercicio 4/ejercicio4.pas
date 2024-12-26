program ej4;
const
	dimF=10;
type
	vector=array [1..dimF] of integer;

procedure cargarVec (var v:vector; var dimL:integer);
var
	num:integer;
begin 
	write('escribir numero: ');
	readln(num);
	while(dimL<dimF)and (num<>0)do begin
		dimL:=dimL+1;
		v[dimL]:=num;
		write('escribir numero: ');
		readln(num);
	end;
end;

procedure posicion (v:vector;dl:integer;var pos:integer);
var
	x,i:integer;
	cumple:boolean;
begin
	cumple:=false;
	i:=0;
	write('escribir numero para encontrar pos: ');
	readln(x);
	while(i<dl)and(cumple=false)do begin
		i:=i+1;
		if(v[i]=x)then begin
			cumple:=true;
			pos:=i;
		end;
	end;
	if(cumple=false)then 
		pos:=-1;
end;

procedure imprimir (v:vector;dl:integer);
var
	i:integer;
begin
	for i:= 1 to dl do begin
		writeln('el elemento en la posicion: ',i, ' es: ',v[i]);
	end;
end;

procedure intercambio (var v:vector; x,y:integer);
var
	ant:integer;
begin
	ant:=v[x];
	v[x]:=v[y];
	v[y]:=ant;
end;

function sumaVector (v:vector;dl:integer):integer;
var
	i,suma:integer;
begin
	suma:=0;
	for i:=1 to dl do begin
		suma:=suma+v[i];
	end;
	sumaVector:=suma;
end;

function promedio (v:vector;dl:integer):integer;
var
	i,suma:integer;
begin
	suma:=0;
	for i:=1 to dl do begin
		suma:=suma+v[i];
	end;
	promedio:=suma div dl;
end;

function elementoMaximo (v:vector;dl:integer):integer;
var
	max,i,posMax:integer;
begin
	max:=-1;
	for i:=1 to dl do begin
		if (v[i]>max) then begin
			max:=v[i];
			posMax:=i;
		end;
	end;
	elementoMaximo:=posMax;
end;

function elementoMinimo (v:vector;dl:integer):integer;
var
	min,i,posMin:integer;
begin
	min:=10000;
	for i:=1 to dl do begin
		if (v[i]<min) then begin
			min:=v[i];
			posMin:=i;
		end;
	end;
	elementoMinimo:=posMin;
end;
var
	vec:vector;
	dimL,pos:integer;
	x,y:integer;
begin
	dimL:=0;
	pos:=0;
	cargarVec(vec,dimL);
	{posicion(vec,dimL,pos);
	writeln('la pos del numero buscado es: ',pos);}
	{write('escribir el valor de x: ');
	readln(x);
	write('escribir el valor de y: ');
	readln(y);
	imprimir(vec,dimL);
	intercambio(vec,x,y);
	imprimir(vec,dimL);
	writeln('la suma de todos los elementos del vector es: ',sumaVector(vec,dimL));}
	//writeln('el promedio del vector es: ',promedio(vec,dimL));
	writeln('la posicion del elemento mas grande es: ',elementoMaximo(vec,dimL));
	writeln('la posicion del elemento mas chico es: ',elementoMinimo(vec,dimL));
end. 
