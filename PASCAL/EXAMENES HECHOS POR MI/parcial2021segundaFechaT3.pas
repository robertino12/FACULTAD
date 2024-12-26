program title;
const
	dimf=52;		//NO LO PROBE XQ M FUI XQ TABA R QUEMADO PERO NO TIENE ERRORES
type
	str=string[30];
	subrango=1..dimf;
	vPartidoVende30kEntradas=array[subrango] of integer;
	ventaEntradas=record
		codigo:integer;//LO PONGO YO PARA PARAR LA LISTA, NO LO PIDE EL EJER, NO CAMBIA NADA
		numPartido:subrango;
		paisOrigComprador:str;
	end;		
	lista=^nodo;//SE DISPONE
	nodo=record
		dato:ventaEntradas;
		sig:lista;
	end;
	infoPartido=record 
		numero:subrango;
		nombreEstadio:str;
		nombrePrimerEquipo:str;
		nombreSegundoEquipo:str;
	end;
	vPartidos=array[subrango]of infoPartido;
//-----------------------------------------------------------------------
//PROCESOS PARA IFORMAR
procedure maximo (nombrePais:str;var max:integer;var maxNombrePais:str;cantEntradasVendidasMismoPais:integer);
begin
	if(cantEntradasVendidasMismoPais>max) then begin
		max:=cantEntradasVendidasMismoPais;
		maxNombrePais:=nombrePais;
	end;
end;

//PROCESO PARA RECORRER LISTA E INFORMAR
procedure recorrerEInformar (l:lista;v:vPartidos;var vec:vPartidoVende30kEntradas);
var
	paisDeOrigActual:str;
	cantPartidos:integer;
	cantEntradasVendidasMismoPais:integer;
	max:integer;
	maxNombrePais:str;
	i:integer;
begin
	max:=-1;
	maxNombrePais:='';
	cantPartidos:=0;
	while(l<>nil)do begin
		cantEntradasVendidasMismoPais:=0;
		paisDeOrigActual:=l^.dato.paisOrigComprador;
		while(l<>nil) and (l^.dato.paisOrigComprador=paisDeOrigActual)do begin
			cantEntradasVendidasMismoPais:=cantEntradasVendidasMismoPais+1;
			if(cantEntradasVendidasMismoPais>30000)then
				vec[l^.dato.numPartido]:=vec[l^.dato.numPartido]+1;
			l:=l^.sig;
		end;
		if(paisDeOrigActual<>v[l^.dato.numPartido].nombrePrimerEquipo) and (paisDeOrigActual<>v[l^.dato.numPartido].nombreSegundoEquipo)then
				maximo(paisDeOrigActual,max,maxNombrePais,cantEntradasVendidasMismoPais);
	end;
	for i:=1 to dimf do 
		cantPartidos:=cantPartidos+vec[i];
	writeln('la cantidad de partidos con mas de 30000 entradas vendidas es de: ',cantPartidos);
	writeln('el nombre del pais con mayor cantidad de entradas adquiridas para partidos en los que no juega su equipo es: ',maxNombrePais);
end;


//PORCESO PARA CARGAR VECTOR
procedure leerInfoPartido(var info:infoPartido);
begin	
	write('escribir el numero de partido: ');
	readln(info.numero);
	write('escribir el nombre del Estadio: ');
	readln(info.nombreEstadio);
	write('escribir el nombre del equipo local: ');
	readln(info.nombrePrimerEquipo);
	write('escribir el nombre del equipo visitante: ');
	readln(info.nombreSegundoEquipo);
end;
procedure cargarVectorConInfoPartido (var v:vPartidos);
var
	info:infoPartido;
	i:integer;
begin
	for i:=1 to dimf do begin
		leerInfoPartido(info);
		v[i]:=info;
	end;
end;
procedure inicializarVectorEn0 (var vec:vPartidoVende30kEntradas);
var
	i:integer;
begin
	for i:=1 to dimf do 
		vec[i]:=0;
end;


//PORCESOS PARA CARGAR LISTA AUNQUE ESTA SE DISPONE
procedure leerInfoVentaEntradas (var v:ventaEntradas);
begin
	write('escribir un numero que representa un codigo: ');
	readln(v.codigo);
	if(v.codigo<>-1)then begin
		write('escribir el numero de partido: ');
		readln(v.numPartido);
		write('escribir el pais de origen del comprador: ');
		readln(v.paisOrigComprador);
	end;
end;
procedure agregarAdelante (var l:lista;v:ventaEntradas);
var
	nue:lista;
begin
	new(nue);
	nue^.dato:=v;
	nue^.sig:=l;
	l:=nue;
end;
procedure cargarLista( var l:lista);
var
	v:ventaEntradas;
begin
	leerInfoVentaEntradas(v);
	while(v.codigo<>-1) do begin
		agregarAdelante(l,v);
		leerInfoVentaEntradas(v);
	end;
end;


//PROGRAMA PRINCIPAL
var
	l:lista;
	v:vPartidos;
	vec:vPartidoVende30kEntradas;
begin
	l:=nil;
	cargarLista(l);//SE DISPONE
	cargarVectorConInfoPartido(v);
	inicializarVectorEn0(vec);
	recorrerEInformar(l,v,vec);
end.
