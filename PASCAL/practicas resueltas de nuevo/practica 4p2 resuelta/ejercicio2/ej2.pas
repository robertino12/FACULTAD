program ej2;
const
	dimF=500;
type
	vector=array[1..dimF]of string;
	
procedure cargarVec (var v:vector; var dl:integer);
var
	nombre:string;
begin
	write('escribir nombre: ');
	readln(nombre);
	while(dl<dimF)and(nombre<>'ZZZ')do begin
		dl:=dl+1;
		v[dl]:=nombre;
		write('escribir nombre: ');
		readln(nombre);
	end;
end;
procedure incisoB (var v:vector;var dl:integer);
var
	nombre:string;
	i,m:integer;
	encontro:boolean;
begin
	write('escribir nombre a buscar: ');
	readln(nombre);
	i:=0;
	encontro:=false;
	while(i<dl)and(encontro=false)do begin
		i:=i+1;
		if(v[i]=nombre)then begin
			for m:= i to (dl-1)do
				v[m]:=v[m+1];
			encontro:=true;
			dl:=dl-1;
		end;
	end;
end;
procedure insertar (var v:vector;var dl:integer;pos:integer);
var
	nombre:string;
	i:integer;
begin
	write('escribir nombre a insertar: ');
	readln(nombre);
	if((dl+1)<=dimF)and(pos>=1)and(pos<=dl)then begin
		for i:=dl downto pos do 
			v[i+1]:=v[i];
		v[pos]:=nombre;
		dl:=dl+1;
	end;
end;
procedure agregar (var v:vector; var dl:integer);
var
	nombre:string;
begin
	write('escribir el nombre a agregar: ');
	readln(nombre);
	if((dl+1)<=dimF)then begin
		dl:=dl+1;
		v[dl]:=nombre;
	end;
end;
procedure imprimir (v:vector;dl:integer);
var
	i:integer;
begin
	for i:=1 to dl do
		writeln('el elemento del vector es: ',v[i]);
end;
var
	dl,pos:integer;
	v:vector;
begin
	dl:=0;
	pos:=4;
	cargarVec(v,dl);
	imprimir(v,dl);
	incisoB(v,dl);
	imprimir(v,dl);
	insertar(v,dl,pos);
	imprimir(v,dl);
	agregar(v,dl);
	imprimir(v,dl);
end. 
