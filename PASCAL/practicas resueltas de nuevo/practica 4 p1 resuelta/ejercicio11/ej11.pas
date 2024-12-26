program ej11;
const
	dimF=4;
type
	infoFoto=record
		titulo:string;
		autor:string;
		cantMg:integer;
		cantClic:integer;
		cantComen:integer;
	end;
	vector=array[1..dimF]of infoFoto;
procedure cargarReg (var i:infoFoto);
begin
	write('escribir titulo foto: ');
	readln(i.titulo);
	write('escribir autor foto: ');
	readln(i.autor);
	write('escribir cantMg foto: ');
	readln(i.cantMg);
	write('escribir cantClic foto: ');
	readln(i.cantClic);
	write('escribir cantComen foto: ');
	readln(i.cantComen);
end;

procedure fotoMasVista (cantClic:integer;titulo:string;var maxClic:integer; var maxTit:string);
begin
	if(cantClic>maxClic)then begin
		maxClic:=cantClic;
		maxTit:=titulo;
	end;
end;

function esAutor (autor:string):boolean;
begin
	esAutor:=(autor='Art Vandelay');
end;

var
	vec:vector;
	i,maxClic,cantTotMg:integer;
	maxTit:string;
begin
	cantTotMg:=0;
	maxClic:=-1;
	maxTit:=' ';
	for i:=1 to dimF do begin
		cargarReg(vec[i]);
		writeln('----------------------');
		fotoMasVista(vec[i].cantClic,vec[i].titulo,maxClic,maxTit);
		if(esAutor(vec[i].autor))then
			cantTotMg:=cantTotMg+vec[i].cantMg;
		writeln('la cantidad de comentarios de la foto con titulo: ',vec[i].titulo,' es de: ',vec[i].cantComen);
	end;
	writeln('la cantidad total de me gustas a las fotos del autor art vandelay es de: ',cantTotMg);
	writeln('la foto mas vista es: ',maxTit);
end.
