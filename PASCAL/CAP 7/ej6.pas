program untitled6;
const
	dimf=7;
type
	str=string[20];
	subrango=1..dimf;
	vector=array[subrango]of integer;
	objeto=record
		cod:integer;
		cat:subrango;
		nombre:str;
		dist:integer;
		nombreDescubridor:str;
		anioDescubrimiento:integer;
	end;
	lista=^nodo;
	nodo=record
		dato:objeto;
		sig:lista;
	end;
	
	
//PROCESOS PARA INFORMAR
procedure descomponer (codigo:integer;nombre:str);
var
	dig:integer;
	cantPares,cantImpares:integer;
begin
	cantPares:=0;
	cantImpares:=0;
	while(codigo<>0) do begin
		dig:=codigo mod 10;
		if(dig mod 2=0) then
			cantPares:=cantPares+1
		else
			cantImpares:=cantImpares+1;
		codigo:=codigo div 10;
	end;
	if(cantPares>cantImpares) then
		writeln('la estrella',nombre,' posee mas digitos pares que impares');
end;
function esDescubierto (cat:subrango;descubridor:str;anio:integer):boolean;
begin
	esDescubierto:=((cat=2)and(descubridor='galileo galilei')and(anio<1600));
end;
procedure maximos (codigo:integer;var codigomax1,codigomax2:integer;var max1,max2:integer;dist:integer);
begin
	if(dist>max1)then begin
		max2:=max1;
		max1:=dist;
		codigomax2:=codigomax1;
		codigomax1:=codigo;
	end
	else	
		if(dist>max2) then begin
			max2:=dist;
			codigomax2:=codigo;
	end;
end;


//PROCESOS DE CARGA
procedure cargarVector (var v:vector);
var
	i:integer;
begin
	for i:=1 to dimf do begin
		v[i]:=0;
	end;
end;
procedure leerObjeto(var o:objeto);
begin
	write('escribir el codigo del objeto: ');
	readln(o.cod);
	if(o.cod<>-1) then begin
		write('escrbibir la categoria del objeto: ');
		readln(o.cat);
		write('escrbibir el nombre del objeto: ');
		readln(o.nombre);
		write('escribir la distancia a la tierra del objeto: ');
		readln(o.dist);
		write('escribir el nombre del descubridor: ');
		readln(o.nombreDescubridor);
		write('escribir el anio en el que se descubrio el objeto: ');
		readln(o.anioDescubrimiento);
	end;
	writeln('--------------------------------');
end;
procedure agregarAtras (var l:lista;o:objeto;var ult:lista) ;
var
	nue:lista;
begin
	new(nue);
	nue^.dato:=o;
	nue^.sig:=nil;
	if(l=nil) then
		l:=nue
	else
		ult^.sig:=nue;
	ult:=nue;
end;
procedure cargarLista(var l:lista;var ult:lista);
var
	o:objeto;
begin
	leerObjeto(o);
	while(o.cod<>-1) do begin
		agregarAtras(l,o,ult);
		leerObjeto(o);
	end;
end;


//PROGRAMA PRINCIPAL
var
	l,ult:lista;
	v:vector;
	codigomax1,codigomax2,max1,max2:integer;
	i:integer;
	cantPlanetas:integer;
BEGIN	
	codigomax1:=0;
	codigomax2:=0;
	max1:=-1;
	max2:=-1;
	cantPlanetas:=0;
	cargarVector(v);
	l:=nil;
	ult:=nil;
	cargarLista(l,ult);
	while(l<>nil) do begin
		maximos(l^.dato.cod,codigomax1,codigomax2,max1,max2,l^.dato.dist);
		if(esDescubierto(l^.dato.cat,l^.dato.nombreDescubridor,l^.dato.anioDescubrimiento))then
			cantPlanetas:=cantPlanetas+1;
		v[l^.dato.cat]:=v[l^.dato.cat]+1;
		if(l^.dato.cat=1) then
			descomponer(l^.dato.cod,l^.dato.nombre);
		l:=l^.sig;
	end;
	writeln('la cantidad de planetas descubiertos por galileo galilei antes del año 1600 es de: ',cantPlanetas);
	for i:=1 to dimf do begin
		writeln('en la categoria: ',i,' hay: ',v[i],' objetos observados');
	end;
END.
