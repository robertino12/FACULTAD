program ej6;
const
	dimF=7;
type
	rango=1..dimF;
	objetos=record
		cod:integer;
		cat:rango;
		nombre:string;
		distTierra:integer;
		nombreDescubridor:string;
		anioDescubrimiento:integer;
	end;
	lista=^nodo;
	nodo=record
		dato:objetos;
		sig:lista;
	end;
	vecCont=array[rango]of integer;
procedure cargarContador (var vC:vecCont);
var
	i:integer;
begin
	for i:=1 to dimF do
		vC[i]:=0;
end;
procedure leerObjetos (var o:objetos);
begin
	write('escribir el codigo del objeto: ');
	readln(o.cod);
	if(o.cod<>-1)then begin
		write('escribir categoria del objeto: ');
		readln(o.cat);
		write('escribir nombre del objeto: ');
		readln(o.nombre);
		write('escribir dist a la tierra: ');
		readln(o.distTierra);
		write('escribir nombre del descubridor: ');
		readln(o.nombreDescubridor);
		write('escribir anio del descubrimiento: ');
		readln(o.anioDescubrimiento);
	end;
	writeln('---------------------------');
end;
procedure agregarAtras (var l:lista; var ult:lista;o:objetos);
var
	nue:lista;
begin
	new(nue);
	nue^.dato:=o;
	nue^.sig:=nil;
	if(l=nil)then
		l:=nue
	else
		ult^.sig:=nue;
	ult:=nue;
end;
procedure cargarLista(var l:lista);
var
	o:objetos;
	ult:lista;
begin
	leerObjetos(o);
	while(o.cod<>-1)do begin
		agregarAtras(l,ult,o);
		leerObjetos(o);
	end;
end;
procedure maximo (cod,distTierra:integer;var maxCod,maxDist,maxCod2,maxDist2:integer);
begin
	if(distTierra>maxDist)then begin
		maxDist2:=maxDist;
		maxCod2:=maxCod;
		maxDist:=distTierra;
		maxCod:=cod;
	end
	else
		if(distTierra>maxDist2)then begin
			maxDist2:=distTierra;
			maxCod2:=cod;
		end;
end;
function esDescubridor (nombre:string):boolean;
begin
	esDescubridor:=(nombre='galileo galilei');
end;
function esAntes (anio:integer):boolean;
begin
	esAntes:=(anio<1600);
end;
function masPares (cod:integer):boolean;
var
	impares,pares:integer;
	dig:integer;
	aux:boolean;
begin
	impares:=0;
	pares:=0;
	while(cod<>0)do begin
		dig:=cod mod 10;
		if(dig mod 2=0)then
			pares:=pares+1
		else
			impares:=impares+1;
		cod:=cod div 10;
	end;
	if(pares>impares)then
		aux:=true
	else
		aux:=false;
	masPares:=aux;
end;
var
	l:lista;
	vC:vecCont;
	maxCod,maxDist,maxCod2,maxDist2:integer;
	cantPlanetas:integer;
	i:integer;
begin
	cantPlanetas:=0;
	maxCod:=-1;
	maxDist:=-1;
	maxCod2:=-1;
	maxDist2:=-1;
	l:=nil;
	cargarContador(vC);
	cargarLista(l);
	while(l<>nil)do begin
		maximo(l^.dato.cod,l^.dato.distTierra,maxCod,maxDist,maxCod2,maxDist2);
		if(esDescubridor(l^.dato.nombreDescubridor))and(esAntes(l^.dato.anioDescubrimiento))then
			cantPlanetas:=cantPlanetas+1;
		vC[l^.dato.cat]:=vC[l^.dato.cat]+1;
		if(masPares(l^.dato.cod))then
			writeln('el nombre de la estrella cuyo codigo tiene mas pares es: ',l^.dato.nombre);
		l:=l^.sig;
	end;
	writeln('el codigo del objeto mas lejano de la tierra es: ',maxCod,' y el segundo codigo es: ',maxCod2);
	writeln('la cantidad de planetas descubierto por galileo antes del 1600 es de: ',cantPlanetas);
	for i:=1 to dimF do
		writeln('la cantidad de objetos observados en la categoria: ',i,' es: ',vC[i]);
end. 
