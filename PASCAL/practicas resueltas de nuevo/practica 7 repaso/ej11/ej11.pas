program ej11;
const
	dimF=100;
type
	rango=1..5;
	evento=record
		nombre:string;
		tipo:rango;
		lugar:string;
		cantMaxPers:integer;
		costoEntrada:integer;
	end;
	vector=array[1..dimF]of evento;
	venta=record
		cod:integer;
		numeroEvento:1..100;
		dniComprador:integer;
		cantEntradas:integer;
	end;
	lista=^nodo;
	nodo=record
		dato:venta;
		sig:lista;
	end;
procedure leerEvento (var e:evento);
begin
	write('ingresar nombre evento: ');
	readln(e.nombre);
	write('escribir tipo de evento: ');
	readln(e.tipo);
	write('escribir lugar evento: ');
	readln(e.lugar);
	write('escribir cantMaxPers que acepta el evento: ');
	readln(e.cantMaxPers);
	write('escribir costo entrada del evento: ');
	readln(e.costoEntrada);
	writeln('--------------------------');
end;
procedure cargarVec (var v:vector);
var
	e:evento;
	i:integer;
begin
	for i:=1 to dimF do begin
		leerEvento(e);
		v[i]:=e;
	end;
end;
procedure leerVenta (var v:venta);
begin
	write('escribir cod de venta: ');
	readln(v.cod);
	if(v.cod<>-1)then begin
		write('escribir numero evento: ');
		readln(v.numeroEvento);
		write('escribir dni comprador: ');
		readln(v.dniComprador);
		write('escribir cant entradas vendidas: ');
		readln(v.cantEntradas);
	end;
	writeln('----------------------------');
end;
procedure agregarAtras(var l:lista;var ult:lista; v:venta);
var
	nue:lista;
begin
	new(nue);
	nue^.dato:=v;
	nue^.sig:=nil;
	if(l=nil)then 
		l:=nue
	else
		ult^.sig:=nue;
	ult:=nue;
end;
procedure cargarLista (var l:lista);
var
	v:venta;
	ult:lista;
begin
	leerVenta(v);
	while(v.cod<>-1)do begin
		agregarAtras(l,ult,v);
		leerVenta(v);
	end;
end;

//RECORRER LISTA
procedure minimo (nombre,lugar:string;recaudacion:integer;var minNombre,minLugar:string;var minRecaudacion:integer;var minNombre2,minLugar2:string;var minRecaudacion2:integer);
begin
	if(recaudacion<minRecaudacion)then begin
		minRecaudacion2:=minRecaudacion;
		minNombre2:=minNombre;
		minLugar2:=minLugar;
		minRecaudacion:=recaudacion;
		minNombre:=nombre;
		minLugar:=lugar;
	end
	else
		if(recaudacion<minRecaudacion2)then begin
			minRecaudacion2:=recaudacion;
			minNombre2:=nombre;
			minLugar2:=lugar;
		end;
end;
function masPares (dni:integer):boolean;
var
	dig:integer;
	pares,impares:integer;
	aux:boolean;
begin
	impares:=0;
	pares:=0;
	while(dni<>0)do begin
		dig:=dni mod 10;
		if(dig mod 2=0)then
			pares:=pares+1
		else
			impares:=impares+1;
		dni:=dni div 10;
	end;
	if(pares>impares)then
		aux:=true
	else
		aux:=false;
	masPares:=aux;
end;
procedure recorrerLista (l:lista;v:vector);
var
	recaudacion:integer;
	minNombre,minNombre2,minLugar,minLugar2:string;
	minRecaudacion,minRecaudacion2:integer;
	cantEntradas,cantEntradasVend,cantMax:integer;
begin
	minNombre:=' ';
	minNombre2:=' ';
	minLugar:=' ';
	minLugar2:=' ';
	minRecaudacion:=10000;
	minRecaudacion2:=10000;
	cantEntradas:=0;
	cantEntradasVend:=0;
	cantMax:=0;
	while(l<>nil)do begin
		recaudacion:=0;
		recaudacion:=l^.dato.cantEntradas*v[l^.dato.numeroEvento].costoEntrada;
		minimo(v[l^.dato.numeroEvento].nombre,v[l^.dato.numeroEvento].lugar,recaudacion,minNombre,minLugar,minRecaudacion,minNombre2,minLugar2,minRecaudacion2);
		if(masPares(l^.dato.dniComprador))and(v[l^.dato.numeroEvento].tipo=3)then
			cantEntradas:=cantEntradas+l^.dato.cantEntradas;
		if(l^.dato.numeroEvento=50)then begin
			cantEntradasVend:=cantEntradasVend+l^.dato.cantEntradas;
			cantMax:=v[l^.dato.numeroEvento].cantMaxPers;
		end;
		l:=l^.sig;
	end;
	writeln('el nombre y lugar del evento con menos recaudacion es: ',minNombre,' / ',minLugar);
	writeln('el nombre y lugar del segundo evento con menos recaudacion es: ',minNombre2,' / ',minLugar2);
	if(cantEntradasVend=cantMax)then
		writeln('el evento numero 50 alcanzo la maxima venta de entradas')
	else
		writeln('el evento numero 50 no alcanzo la maxima venta de entradas');
end;
var
	l:lista;
	v:vector;
begin
	l:=nil;
	cargarLista(l);
	cargarVec(v);
	recorrerLista(l,v);
end.
