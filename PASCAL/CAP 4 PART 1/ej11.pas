program ej11;
const
	dimF=4;{en realidad son 200 fotos}
type
	rango=1..dimF;
	str=string[20];
	infoFoto=record
		titulo:str;
		autor:str;
		cantMG:integer;
		cantClics:integer;
		cantComen:integer;
		pagina:str;
	end;
	vector=array[rango] of infoFoto;
procedure leerRegistro (var i:infoFoto);
begin
	writeln('Escribir la pagina donde se subio la foto');
	readln(i.pagina);
	writeln('Escribir el titulo de la foto');
	readln(i.titulo);
	writeln('Escribir el autor de la foto');
	readln(i.autor);
	writeln('Escribir la cantidad de me gustas en la foto');
	readln(i.cantMG);
	writeln('Escribir la cantidad de clics en la foto');
	readln(i.cantClics);
	writeln('Escribir la cantidad de comentarios de la foto');
	readln(i.cantComen);
end;
procedure cargarVector(var v:vector);
var
	i:rango;
begin
	for i:=1 to dimF do begin
		writeln('en la posicion : ',i);
		leerRegistro(v[i]);
		writeln('---------------------------');
	end;
end;
procedure max (v:vector;var max1:integer;var maxtitulo:str);
var
	i:rango;
begin
	for i:= 1 to dimF do begin
		if(v[i].cantClics>max1) then begin
			max1:=v[i].cantClics;
			maxtitulo:=v[i].titulo;
		end;
	end;
end;
procedure cantMg (v:vector;var cant:integer);
var
	i:rango;
begin
	for i:=1 to dimF do
		if(v[i].autor='art vandelay') then 
			cant:=cant+v[i].cantMG;
end;
procedure cantCom (v:vector);
var
	i:rango;
begin
	for i:=1 to dimF do
		if(v[i].pagina='facebook') then
		writeln('La cantidad de comentarios recibidos para la foto: ',i,' publicada en facebook es de: ',v[i].cantComen);
end;
var
	vec:vector;
	maximo1:integer;
	maximotitulo:str;
	cantidad:integer;
begin
	cantidad:=0;
	maximotitulo:=' ';
	maximo1:=-1;
	cargarVector(vec);
	max(vec,maximo1,maximotitulo);
	writeln('El titulo de la foto mas vista es: ',maximotitulo);
	cantMg(vec,cantidad);
	writeln('La cantidad total de me gustas recibidas a las fotos cuyo autor es el fotografo art vandelay es de: ',cantidad);
	cantCom(vec);
end.
