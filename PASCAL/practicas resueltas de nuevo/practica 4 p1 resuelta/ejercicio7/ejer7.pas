program ejer7;
const
	dimF=15;
type
	vector=array [1..dimF] of integer;
	vecContador=array [0..9] of integer;
procedure cargarVec (var v:vector;var dimL:integer);
var
	num:integer;
begin
	write('escribir un numero: ');
	readln(num);
	while(dimL<dimF)and(num<>-1)do begin
		dimL:=dimL+1;
		v[dimL]:=num;
		write('escribir un numero: ');
		readln(num);
	end;
end;
procedure cantOcurrencias (v:vector;var vC:vecContador);
var
	i:integer;
	dig:integer;
begin
	for i:=0 to 9 do begin
		while (v[i] <> 0) do begin
			dig:=v[i] mod 10;
			vC[dig]:=vC[dig]+1;
			v[i]:=v[i] div 10;
		end;
	end;
end;
var
	vec:vector;
	vC:vecContador;
	dimL:integer;
	i:integer;
	max,posMax:integer;
begin
	max:=-1;
	posMax:=-1;
	dimL:=0;
	cargarVec(vec,dimL);
	cantOcurrencias(vec,vC);
	for i:=0 to 9 do begin
		writeln('numero: ',i, ': ',vC[i], ' veces');
		if(vC[i]>max)then begin
			max:=vC[i];
			posMax:=i;
		end;
		if(vC[i]=0)then 
			writeln('el digito: ',i,' no tuvo ocurrencias');
	end;
	writeln('el digito mas leido fue el: ',posMax);
end.
