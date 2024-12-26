program ejer3;
const
	dimF=10;
type
	vector= array [1..10] of integer;
	
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

procedure imprimir (v:vector;dl:integer);
var
	i:integer;
begin
	for i:= 1 to dl do begin
		writeln('el elemento en la posicion: ',i, ' es: ',v[i]);
	end;
end;

procedure imprimirAlReves (v:vector;dl:integer);
var
	i:integer;
begin
	for i:= dl downto 1 do begin
		writeln('el elemento en la posicion: ',i, ' es: ',v[i]);
	end;
end;

procedure imprimirDividido (v:vector;dl:integer);
var
	i,j,division:integer;
begin
	division:=dl div 2;
	for i:=division downto 1 do begin
		writeln('el elemento en la posicion: ',i, ' es: ',v[i]);
	end;
	for j:=division+1 to dl do begin
		writeln('el elemento en la posicion: ',j, ' es: ',v[j]);
	end;
end;

procedure recorrerXy (v:vector; x,y:integer);
var
	i:integer;
begin
	if(y<x)then begin
		for i:=x downto y do begin
			writeln('el elemento en la posicion: ',i, ' es: ',v[i]);
		end;
	end
	else begin
		for i:=x to y do begin
			writeln('el elemento en la posicion: ',i, ' es: ',v[i]);
		end;
	end;
end;

var
	vec:vector;
	dimL,x,y:integer;
begin
	dimL:=0;
	cargarVec(vec,dimL);
	//imprimir(vec,dimL);
	//imprimirAlReves(vec,dimL);
	//imprimirDividido(vec,dimL);
	write('escribir posicion x: ');
	readln(x);
	write('escribir posicion y: ');
	readln(y);
	recorrerXy(vec,x,y);
end.
