program titlte;
const
	dimf=4;
type
	str=string[30];
	subrango=1..dimf;
	ventaEntradas=record
		cod:integer;
		codPartido:subrango;
		codCliente:integer;
		cantEntradasVendidas:integer;
	end;
	lista=^nodo;//SE DISPONE
	nodo=record
		dato:ventaEntradas;
		sig:lista;
	end;
	infoPartido=record
		codPartido:subrango;
		nombreEstadio:str;
		capacidadMaxEstadio:integer;
		horaInicio:integer;
	end;
	vInfoPartido=array[subrango]of infoPartido;
	infoNuevaLista=record
		nuevoCodPartido:subrango;
	end;
	listaNueva=^nodoNuevo;
	nodoNuevo=record
		dato:infoNuevaLista;
		sig:listaNueva;
	end;
	vCantEntradasVendidas=array[subrango]of integer;
//-------------------------------------------------------------------------------
//PROCESO PARA CREAR NUEVA LISTA
procedure darValorNuevaInfoLista (var cN:infoNuevaLista;codNuevo:subrango);
begin
	cN.nuevoCodPartido:=codNuevo;
end;
procedure agregarAdelanteNuevaLista (var newL:listaNueva;cN:infoNuevaLista);
var
	nue:listaNueva;
begin
	new(nue);
	nue^.dato:=cN;
	nue^.sig:=newL;
	newL:=nue;
end;
procedure imprimirNuevaLista (newL:listaNueva);
begin
	while(newL<>nil) do begin
		writeln('el codigo de partido que vendio todas las entradas es: ',newL^.dato.nuevoCodPartido);
		newL:=newL^.sig;
	end;
end;
		
//PROCESO PARA RECORRER E INFORMAR
procedure recorrerEInformar (l:lista;v:vInfoPartido;var newL:listaNueva;var vec:vCantEntradasVendidas);
var
	cN:infoNuevaLista;
	todasEntradasVendidas:integer;
begin
	todasEntradasVendidas:=0;
	while(l<>nil) do begin
		{if(l^.dato.codPartido<>v[l^.dato.codPartido].codPartido)then
			todasEntradasVendidas:=0;}//3
		if(l^.dato.codPartido=v[l^.dato.codPartido].codPartido) then
			vec[l^.dato.codPartido]:=vec[l^.dato.codPartido]+l^.dato.cantEntradasVendidas;
		todasEntradasVendidas:=v[l^.dato.codPartido].capacidadMaxEstadio-vec[l^.dato.codPartido];
		if(todasEntradasVendidas=0) then begin
			darValorNuevaInfoLista(cN,l^.dato.codPartido);
			agregarAdelanteNuevaLista(newL,cN);
		end;
		l:=l^.sig;
	end;
	imprimirNuevaLista(newL);
end;


//CARGAR VECTOR
procedure leerInfoPartido (var info:infoPartido);
begin
	write('escribir el codigo de partido: ');
	readln(info.codPartido);
	write('escribir el nombre del estadio: ');
	readln(info.nombreEstadio);
	write('escribir la capacidad maxima del estadio: ');
	readln(info.capacidadMaxEstadio);
	write('escribir la hora de inicio del partido: ');
	readln(info.horaInicio);
end;
procedure cargarVectorConInfoPartido(var v:vInfoPartido);
var
	i:integer;
	info:infoPartido;
begin
	for i:=1 to dimf do begin
		writeln('escribir la info del partido: ',i);
		leerInfoPartido(info);
		v[i]:=info;
	end;
end;
procedure cargarVectorEn0 (var vec:vCantEntradasVendidas);
var
	i:integer;
begin
	for i:=1 to dimf do 
		vec[i]:=0;
end;

//CARGAR LISTA AUNQUE SE DISPONE
procedure leerInfoVentaEntradas (var v:ventaEntradas);
begin
	write('escribir -1 para cortar lista: ');
	readln(v.cod);
	if(v.cod<>-1) then begin
		write('escribir el codigo de partido: ');
		readln(v.codPartido);
		write('escribir el codigo de cliente: ');
		readln(v.codCliente);
		write('escribir la cantidad de entradas vendidas: ');
		readln(v.cantEntradasVendidas);
	end;
	writeln('-------------------------------------------------------------');
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
procedure cargarLista (var l:lista);
var
	v:ventaEntradas;
begin
	leerInfoVentaEntradas(v);
	while(v.cod<>-1)do begin
		agregarAdelante(l,v);
		leerInfoVentaEntradas(v);
	end;
end;


//PROGRAMA PRINCIPAL
var
	l:lista;
	newL:listaNueva;
	v:vInfoPartido;
	vec:vCantEntradasVendidas;
begin
	l:=nil;
	newL:=nil;
	cargarLista(l);
	cargarVectorConInfoPartido(v);
	cargarVectorEn0(vec);
	recorrerEInformar(l,v,newL,vec);
end.
