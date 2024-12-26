program ejer5;
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

procedure imprimir (v:vector;dl:integer);
var
	i:integer;
begin
	for i:= 1 to dl do begin
		writeln('el elemento en la posicion: ',i, ' es: ',v[i]);
	end;
end;

var
	vec:vector;
	dimL,min,max,antMax,antMin:integer;
begin
	dimL:=0;
	cargarVec(vec,dimL);
	min:=elementoMinimo(vec,dimL);
	max:=elementoMaximo(vec,dimL);
	imprimir(vec,dimL);
	antMax:=vec[max];
	antMin:=vec[min];
	vec[max]:=vec[min];
	vec[min]:=antMax;
	writeln('el elemento maximo: ',antMax, ' que se encontraba en la posicion: ',max, ' fue intercambiado con el elemento minimo: ',antMin,' que se encontraba en la posicion: ',min);
	imprimir(vec,dimL);
end.
