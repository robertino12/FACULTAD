program ej4;
const
	dimF=1000;
type
	alumno=record
		nro:integer;
		nombre:string;
		cantAsis:integer;
	end;
	vector=array[1..dimF]of alumno;
procedure cargarReg (var a:alumno);
begin
	write('escribir nro alumno: ');
	readln(a.nro);
	if(a.nro<>0)then begin
		write('escribir nombre alumno: ');
		readln(a.nombre);
		write('escribir asistencias alumno: ');
		readln(a.cantAsis);
	end;
	writeln('--------------------------');
end;
procedure cargarVec (var v:vector;var dl:integer);
var
	a:alumno;
begin
	cargarReg(a);
	while(dl<dimF)and(a.nro<>0)do begin
		dl:=dl+1;
		v[dl]:=a;
		cargarReg(a);
	end;
end;
procedure buscar (v:vector;dl:integer;var pos:integer;nro:integer);
var
	i:integer;
	encontre:boolean;
begin
	i:=1;
	encontre:=false;
	while(v[i].nro<=nro)and(encontre=false)do begin
		if(v[i].nro=nro)then begin
			encontre:=true;
			pos:=i;
		end
		else
			i:=i+1;
	end;
	if(encontre)then
		writeln('existe y su pos es: ',pos)
	else
	writeln('no existe');
end;
procedure insertar (var v:vector;var dl:integer; a:alumno);
var
	pos,i:integer;
begin
	pos:=3;
	if(pos>=1)and(pos<=dl)and((dl+1)<=dimF)then begin
		for i:= dl downto pos do 
			v[i+1]:=v[i];
		v[pos]:=a;
		dl:=dl+1;
	end;
end;
procedure eliminarPos (var v:vector; var dl:integer; pos:integer);
var
	i:integer;
begin
	if(pos>=1)and(pos<=dl)then begin
		for i:=pos to (dl-1)do
			v[i]:=v[i+1];
		dl:=dl-1;
	end;
end;
procedure eliminarNro (var v:vector; var dl:integer; nro:integer);
var
	i,m:integer;
	encontre:boolean;
begin
	m:=1;
	encontre:=false;
	while(m<=dl)and(encontre=false)do begin
		if(v[m].nro=nro)then begin
			for i:=m to (dl-1)do
				v[i]:=v[i+1];
			dl:=dl-1;
		end
		else
			m:=m+1;
	end;
end;
procedure eliminarTodas (var v:vector;var dl:integer);
var
	i,m:integer;
begin
	i:=1;
	while(i<=dl)do begin
		if(v[i].cantAsis=0)then begin
			for m:=i to (dl-1) do
				v[m]:=v[m+1];
			dl:=dl-1;
		end
		else
			i:=i+1;//solo incrementa i sino eliminast un elemento
			//xq si eliminast, movist pra la izq osea ya tenes al sig en i
		writeln('dl: ',dl);
	end;
end;
procedure imprimir(v:vector;dl:integer);
var
	i:integer;
begin
	for i:=1 to dl do 
		writeln('el nro de alumno es: ',v[i].nro);
end;

var
	v:vector;
	dl:integer;
	pos,nroAl:integer;
	a:alumno;
	posEl:integer;
begin
	dl:=0;
	pos:=0;
	cargarVec(v,dl);
	write('escribir nro alumno pra encontrar posicion: ');
	readln(nroAl);
	buscar(v,dl,pos,nroAl);
	imprimir(v,dl);
	writeln('escribir datos para insertar');
	write('escribir nro alumno: ');
	readln(a.nro);
	write('escribir nombre alumno: ');
	readln(a.nombre);
	write('escribir asistencias alumno: ');
	readln(a.cantAsis);
	insertar(v,dl,a);
	imprimir(v,dl);
	eliminarTodas(v,dl);
	write('escribir pos a eliminar: ');
	readln(posEl);
	eliminarPos(v,dl,posEl);
	eliminarNro(v,dl,nroAl);
	imprimir(v,dl);
end.
