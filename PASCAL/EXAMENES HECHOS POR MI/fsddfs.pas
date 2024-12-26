program title;
const
	dimf=3;		//ANDA COMO 1:30 HORAS ESTUVE
type
	str=string[30];
	subrango=1..dimf;
	vCantEntradasVendidas=array[subrango]of integer;
	venta=record
		codigoPartido:subrango;
		codCliente:integer;
		cantEntradasVendidas:integer;
	end;
	lista=^nodo;//SE DISPONE
	nodo=record
		dato:venta;
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
		codPartidoNuevo:subrango;
	end;
	nuevaLista=^nodoNuevo;
	nodoNuevo=record
		dato:infoNuevaLista;
		sig:nuevaLista;
	end;
//---------------------------------------------------------------------------


//PROCESOS PARA CARGAR NUEVA LISTA
procedure agregarAdelanteNewL (var newL:nuevaLista;i:infoNuevaLista);
var
	nue:nuevaLista;
begin
	new(nue);
	nue^.dato:=i;
	nue^.sig:=newL;
	newL:=nue;
end;
procedure darValorInfoNuevaLista (var i:infoNuevaLista;codigo:integer);
begin
	i.codPartidoNuevo:=codigo;
end;
procedure imprimirNuevaLista (newL:nuevaLista);
begin
	while(newL<>nil) do begin
		writeln('el partido con codigo: ',newL^.dato.codPartidoNuevo,'tiene todas las entradas vendidas');
		newL:=newL^.sig;
	end;
end;


//PROCESOS PARA INFORMAR
function descomponerCodCliente (codCliente:integer):boolean;
var
	dig:integer;
	cumple:boolean;
begin
	dig:=codCliente mod 10;
	if(dig=0)then begin
		codCliente:=codCliente div 10;
		dig:=codCliente mod 10;
		if(dig=1)then
			cumple:=true
		else
		if(dig=2)then
			cumple:=true
		else
			cumple:=false;
	end;
	descomponerCodCliente:=cumple;
end;


//PROCESO PARA RECORRER LISTA E INFORMAR TODO
procedure recorrerEInformar(l:lista;v:vInfoPartido;var newL:nuevaLista;var vec:vCantEntradasVendidas);
var
	i:infoNuevaLista;
	cantVentas:integer;
	todasEntradasVendidas:integer;
begin
	todasEntradasVendidas:=0;
	cantVentas:=0;
	while(l<>nil) do begin
		if(l^.dato.codigoPartido<>v[l^.dato.codigoPartido].codPartido)then
			todasEntradasVendidas:=0;
		if(l^.dato.codigoPartido=v[l^.dato.codigoPartido].codPartido)then
			vec[l^.dato.codigoPartido]:=vec[l^.dato.codigoPartido]+l^.dato.cantEntradasVendidas;
		todasEntradasVendidas:=v[l^.dato.codigoPartido].capacidadMaxEstadio - vec[l^.dato.codigoPartido];
		if(todasEntradasVendidas=0)then begin
			darValorInfoNuevaLista(i,v[l^.dato.codigoPartido].codPartido);
			agregarAdelanteNewL(newL,i);//CON ESTOS DOS INCISOS GENERO UNA NUEVA LISTA
		end;
		if(descomponerCodCliente(l^.dato.codCliente)=true)and (l^.dato.cantEntradasVendidas>5)then
			cantVentas:=cantVentas+1;
		l:=l^.sig;
	end;
	imprimirNuevaLista(newL);
	writeln('la cantidad de ventas de mas de 5 entradas cuyo codigo del cliente termina en 10 o 20 es: ',cantVentas);
end;


//PROCESOS DE CARGA DE VECTOR DE LOS PARTIDOS
procedure leerInfoPartido (var info:infoPartido);
begin
	write('escribir el codigo del partido: ');
	readln(info.codPartido);
	write('escribir el nombre del estadio: ');
	readln(info.nombreEstadio);
	write('escribir la capacidad maxima del estadio: ');
	readln(info.capacidadMaxEstadio);
	write('escribir la hora de inicio del partido: ');
	readln(info.horaInicio);
	writeln('--------------------------------');
end;
procedure cargarVectorConInfoPartidos(var v:vInfoPartido);
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
procedure cargarVectorEn0 (var vec:vCantEntradasVendidas);
var
	i:integer;
begin
	for i:=1 to dimf do
		vec[i]:=0;
end;

//PROCESOS DE CARGA DE LISTA QUE SE DISPONE PERO LO HAGO IGUAL PARA VER SI ANDA
procedure leerInfoVentaEntradas(var v:venta);
begin
	writeln('escribir la informacion de las ventas de entradas');
	write('escribir el codigo de partido: ');
	readln(v.codigoPartido);
	write('escribir el codigo del cliente: ');
	readln(v.codCliente);
	if(v.codCliente<>-1) then begin
		write('escribir la cantidad de entradas vendidas: ');
		readln(v.cantEntradasVendidas);
	end;
	writeln('--------------------------------');
end;
procedure agregarAdelante (var l:lista;v:venta);
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
	v:venta;
begin
	leerInfoVentaEntradas(v);
	while(v.codCliente<>-1) do begin
		agregarAdelante(l,v);
		leerInfoVentaEntradas(v);
	end;
end;


//PROGRAMA PRINCIPAL
var
	l:lista;
	v:vInfoPartido;
	newL:nuevaLista;
	vec:vCantEntradasVendidas;
begin
	newL:=nil;
	l:=nil;
	cargarLista(l);
	cargarVectorEn0(vec);
	cargarVectorConInfoPartidos(v);
	recorrerEInformar(l,v,newL,vec);
end.
