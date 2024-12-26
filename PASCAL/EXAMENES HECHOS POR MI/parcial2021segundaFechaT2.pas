program title;
const
	dimf=3;			//ANDA
type
	str=string[30];
	subrango=1..dimf;
	ventas=record
		codPartido:subrango;
		codCliente:integer;
		cantEntradasVendidas:integer;
	end;
	lista=^nodo;//SE DISPONE
	nodo=record
		dato:ventas;
		sig:lista;
	end;
	infoPartido=record
		codParti:subrango;
		nombreEstadio:str;
		capacidadMaxEst:integer;
		horaInicio:integer;
	end;
	vPartido=array[subrango]of infoPartido;
	infoNuevaLista=record
		nuevoCodPartido:subrango;
	end;
	nuevaLista=^nodoNuevo;
	nodoNuevo=record
		dato:infoNuevaLista;
		sig:nuevaLista;
	end;
//--------------------------------------------------------------------------
//PROCESO PARA CREAR NUEVA LISTA
procedure darValorInfoNuevaLista (var i:infoNuevaLista;codPartido:subrango);
begin
	i.nuevoCodPartido:=codPartido;
end;
procedure agregarAdelanteNuevaLista (var newL:nuevaLista;i:infoNuevaLista);
var
	nue:nuevaLista;
begin
	new(nue);
	nue^.dato:=i;
	nue^.sig:=newL;
	newL:=nue;
end;
procedure imprimirNuevaLista (newL:nuevaLista);
begin
	while(newL<>nil)do begin
		writeln('el partido con codigo: ',newL^.dato.nuevoCodPartido,' supera el 50% de la capacidad del estadio');
		newL:=newL^.sig;
	end;
end;


//PROCESOS PARA INFORMAR
function descomponerCodigoCliente (codCliente:integer):boolean;
var
	dig:integer;
	cumple:boolean;
begin
	dig:=codCliente mod 10;
	if(dig>=0) and (dig<=9) then
		cumple:=true
	else
		cumple:=false;
	if(cumple=true)then begin
		codCliente:=codCliente div 10;
		dig:=dig mod 10;
		if(dig=3)then
			cumple:=true;
	end;
	descomponerCodigoCliente:=cumple;		
end;

//PROCESO PARA RECORRER E INFORMAR
procedure recorrerEInformar (l:lista;v:vPartido;var newL:nuevaLista);
var
	i:infoNuevaLista;
	cantVentas:integer;
	porcentaje:integer;
begin
	cantVentas:=0;
	while(l<>nil) do begin
		porcentaje:=0;
		porcentaje:=v[l^.dato.codPartido].capacidadMaxEst div 2;
		if(l^.dato.cantEntradasVendidas>porcentaje)then begin
			darValorInfoNuevaLista(i,v[l^.dato.codPartido].codParti);
			agregarAdelanteNuevaLista(newL,i);
		end;
		if(descomponerCodigoCliente(l^.dato.codCliente)=true)and(l^.dato.cantEntradasVendidas<5)then
			cantVentas:=cantVentas+1;
		l:=l^.sig;
	end;
	imprimirNuevaLista(newL);
	writeln('la cantidad de ventas de menos de 5 entradas cuyo codigo del cliente termina entre 30 y 39 es: ',cantVentas);
end;

//PROCESOS PARA CARGAR VECTOR
procedure leerInfoPartido (var info:infoPartido);
begin
	write('escribir el codigo del partido: ');
	readln(info.codParti);
	write('escribir el nombre del estadio: ');
	readln(info.nombreEstadio);
	write('escribir la capacidad maxima del estadio: ');
	readln(info.capacidadMaxEst);
	write('escribir la hora de inicio del partido: ');
	readln(info.horaInicio);
	writeln('--------------------------------');
end;
procedure cargarVectorConInfoPartido(var v:vPartido);
var
	i:integer;
	info:infoPartido;
begin
	for i:=1 to dimf do begin
		writeln('escribir la informacion del partido: ',i);
		leerInfoPartido(info);
		v[i]:=info;
	end;
end;


//PROCESOS PARA CARGAR LISTA QUE SE DISPONE
procedure leerInfoVentasEntradas(var v:ventas);
begin
	writeln('escribir la informacion de las ventas de entradas');
	write('escribir el codigo de partido: ');
	readln(v.codPartido);
	write('escribir el codigo del cliente: ');
	readln(v.codCliente);
	if(v.codCliente<>-1) then begin
		write('escribir la cantidad de entradas vendidas: ');
		readln(v.cantEntradasVendidas);
	end;
	writeln('--------------------------------');
end;
procedure agregarAdelante(var l:lista;v:ventas);
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
	v:ventas;
begin
	leerInfoVentasEntradas(v);
	while(v.codCliente<>-1) do begin
		agregarAdelante(l,v);
		leerInfoVentasEntradas(v);
	end;
end;


//PROGRAMA PRINCIPAL
var
	l:lista;
	v:vPartido;
	newL:nuevaLista;
begin
	newL:=nil;
	l:=nil;
	cargarLista(l);
	cargarVectorConInfoPartido(v);
	recorrerEInformar(l,v,newL);
end.
