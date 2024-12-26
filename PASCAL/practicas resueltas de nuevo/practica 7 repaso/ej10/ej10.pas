program ej10;
const
	dimF=4;
type
	rango=1..4;
	cultivo=record
		tipo:string;
		cantHect:integer;
		cantMeses:integer;
	end;
	vector=array[rango]of cultivo;
	empresa=record
		cod:integer;
		nombre:string;
		queEs:string;
		nombreCiudad:string;
		cultivos:vector;
		dl:integer;
	end;
	lista=^nodo;
	nodo=record
		dato:empresa;
		sig:lista;
	end;
procedure leerCultivo (var c:cultivo);
begin
	write('ingresar cantidad de hectareas: ');
	readln(c.cantHect);
	if(c.cantHect<>0)then begin
		write('escribir tipo de cultivo: ');
		readln(c.tipo);
		write('escribir cantidad de meses del cultivo: ');
		readln(c.cantMeses);
	end;
	writeln('--------------------------');
end;
procedure cargarVec (var v:vector;var dl:integer);
var
	c:cultivo;
begin
	leerCultivo(c);
	while(dl<dimF)and(c.cantHect<>0)do begin
		dl:=dl+1;
		v[dl]:=c;
		leerCultivo(c);
	end;
end;
procedure leerEmpresa (var e:empresa);
begin
	write('escribir cod de empresa: ');
	readln(e.cod);
	if(e.cod<>-1)then begin
		write('escribir nombre de empresa: ');
		readln(e.nombre);
		write('escribir si es estatal o privada: ');
		readln(e.queEs);
		write('escribir nombre ciudad donde esta la empresa: ');
		readln(e.nombreCiudad);
		write('escribir los cultivos que realiza: ');
		cargarVec(e.cultivos,e.dl);
	end;
	writeln('----------------------------');
end;
procedure agregarAtras(var l:lista;var ult:lista; e:empresa);
var
	nue:lista;
begin
	new(nue);
	nue^.dato:=e;
	nue^.sig:=nil;
	if(l=nil)then 
		l:=nue
	else
		ult^.sig:=nue;
	ult:=nue;
end;
procedure cargarLista (var l:lista);
var
	e:empresa;
	ult:lista;
begin
	leerEmpresa(e);
	while(e.cod<>-1)do begin
		agregarAtras(l,ult,e);
		leerEmpresa(e);
	end;
end;

//RECORRER LISTA
function esTrigo (v:vector;dl:integer):boolean;
var
	i:integer;
	cumple:boolean;
begin
	cumple:=true;
	i:=1;
	while(i<=dl)and(cumple)do begin
		if(v[i].tipo<>'trigo')then
			cumple:=false;
		i:=i+1;
	end;
	esTrigo:=cumple;
end;
function alMenos (cod:integer):boolean;
var
	dig:integer;
	cantCeros:integer;
	aux:boolean;
begin
	cantCeros:=0;
	while(cod<>0)do begin
		dig:=cod mod 10;
		if(dig = 0)then
			cantCeros:=cantCeros+1;
		cod:=cod div 10;
	end;
	if(cantCeros>=2)then
		aux:=true
	else
		aux:=false;
	alMenos:=aux;
end;
procedure maximo (nombre:string; tiempo:integer; var tiempoMax:integer; var nombreMax:string);
begin
	if(tiempo>tiempoMax)then begin
		tiempoMax:=tiempo;
		nombreMax:=nombre;
	end;
end;
procedure recorrerLista (l:lista);
var
	i,cantHectSoja,cantTotalHect:integer;
	cantTiempo,tiempoMax:integer;
	nombreMax:string;
begin
	cantHectSoja:=0;
	cantTotalHect:=0;
	tiempoMax:=-1;
	nombreMax:=' ';
	while(l<>nil)do begin
			cantTiempo:=0;
			if(l^.dato.nombreCiudad='san miguel')and(esTrigo(l^.dato.cultivos,l^.dato.dl))and(alMenos(l^.dato.cod))then
				writeln('el nombre de la empresa que respeta condiciones es: ',l^.dato.nombre);
			for i:=1 to l^.dato.dl do begin
				if(l^.dato.queEs='privada')and(l^.dato.cultivos[i].tipo='girasol')and(l^.dato.cultivos[i].cantHect<5)then
					l^.dato.cultivos[i].cantMeses:=l^.dato.cultivos[i].cantMeses+1;
				if(l^.dato.cultivos[i].tipo='soja')then
					cantHectSoja:=cantHectSoja+l^.dato.cultivos[i].cantHect;
				cantTotalHect:=cantTotalHect+l^.dato.cultivos[i].cantHect;
				if(l^.dato.cultivos[i].tipo='maiz')then
					cantTiempo:=cantTiempo+l^.dato.cultivos[i].cantMeses;
			end;
			maximo(l^.dato.nombre,cantTiempo,tiempoMax,nombreMax);
		l:=l^.sig;
	end;
	writeln('la cantidad de hectareas dedicadasa la soja es: ',cantHectSoja);
	writeln('el procentaje que representa la cant de hect de soja con respecto a la total es: ',(cantHectSoja*100) div cantTotalHect,'%'); 
	writeln('la empresa que dedica mas tiempo al cultivo de maiz es: ',nombreMax);
end;
var
	l:lista;
begin
	l:=nil;
	cargarLista(l);
	recorrerLista(l);
end.
