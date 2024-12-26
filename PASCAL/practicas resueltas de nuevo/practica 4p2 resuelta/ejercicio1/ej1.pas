program ej1;
const
	dimF=500;
type
	vector=array[1..dimF] of integer;
procedure cargarVec (var v:vector; var dl:integer);
var
	num:integer;
begin
	write('escribir num: ');
	readln(num);
	while(dl<dimF)and(num<>-1)do begin
		dl:=dl+1;
		v[dl]:=num;
		write('escribir num: ');
		readln(num);
	end;
end;
function incisoA(v:vector;dl:integer;n:integer):boolean;
var 
	i:integer;
	encontro:boolean;
begin
	i:=0;
	encontro:=false;
	while(i<dl)and(encontro=false)do begin
		i:=i+1;
		if(v[i]=n)then
			encontro:=true;
	end;
	incisoA:=encontro;
end;

function incisoB(v:vector;dl:integer;n:integer):boolean;
var 
	i:integer;
	encontro:boolean;
begin
	i:=1;
	encontro:=false;
	while(n<v[i])and(i<=dl)and(encontro=false)do begin
		if(v[i]=n)then
			encontro:=true;
		i:=i+1;
	end;
	incisoB:=encontro;
end;
var
	dl,n:integer;
	v:vector;
begin
	dl:=0;
	cargarVec(v,dl);
	write('escribir un numero: ');
	readln(n);
	{if(incisoA(v,dl,n))then
		writeln('el numero existe en el vector')
	else
		writeln('no existe');}
	if(incisoB(v,dl,n))then
		writeln('el numero existe en el vector ordenado')
	else
		writeln('no existe');
end. 
