program title;
const
	dimf=4;
type
	str=string[30];
	subrango=1..dimf;
	vCostoMens=array[subrango]of integer;//CONTIENE EL COSTO MENSUAL DE CADA TIPO DE SUSCRIPCION Y YA SE DISPONE
	vSuscripcion=array[subrango]of integer;
	clientes=record
		nombre:str;
		dni:integer;
		edad:integer;
		tipoSuscrip:subrango;
	end;
	lista=^nodo;
	nodo=record
		dato:clientes;
		sig:lista;
	end;
	//LISTA NUEVA
	clienteNuevo=record
		nombre:str;
		dni:integer;
	end;
	listaNueva=^nodoNuevo;
	nodoNuevo=record
		dato:clienteNuevo;
		sig:listaNueva;
	end;
	

//PROCESOS PARA INFORMAR	
procedure maximos (v:vSuscripcion;var max1,max2:integer;var suscripMax1,suscripMax2:integer);
var
	i:subrango;
begin
	for i:=1 to dimf do begin
		if(v[i]>max1)then begin
			max2:=max1;
			max1:=v[i];
			suscripMax2:=suscripMax1;
			suscripMax1:=i;
		end
		else
			if(v[i]>max2)then begin
				max2:=v[i];
				suscripMax2:=i;
		end;
	end;
end;


//PROCESOS PARA CARGAR
procedure inicializarVectorEn0 (var v:vSuscripcion);
var
	i:subrango;
begin
	for i:=1 to dimf do begin
		v[i]:=0;
	end;
end;
procedure leerCliente (var c:clientes);
begin
	write('escribir el nombre del cliente: ');
	readln(c.nombre);
	write('escribir el dni del cliente: ');
	readln(c.dni);
	if(c.dni<>0) then begin
		write('escribir la edad del cliente: ');
		readln(c.edad);
		write('escribir el tipo de suscripcion del cliente: ');
		readln(c.tipoSuscrip);
	end;
	writeln('----------------------------');
end;
procedure agregarAdelante (var l:lista;c:clientes);
var
	nue:lista;
begin
	new(nue);
	nue^.dato:=c;
	nue^.sig:=l;
	l:=nue;
end;
procedure cargarLista (var l:lista);
var
	c:clientes;
begin
	leerCliente(c);
	while(c.dni<>0) do begin
		agregarAdelante(l,c);
		leerCliente(c);
	end;
end;
procedure darValor(var cN:clienteNuevo;nombre:str;dni:integer);
begin
	cN.nombre:=nombre;
	cN.dni:=dni;
end;
//PORCESO PARA IMPRIMIR LISTA NUEVA Y VER SI ANDA,ANDA
procedure imprimirListaNueva (nL:listaNueva;cN:clienteNuevo);
begin
	while(nL<>nil) do begin
		writeln('la lista nueva de clientes de mas de 40 años suscritos a crossfit o todas las clases es la siguiente: ');
		writeln(nL^.dato.nombre);
		writeln(nL^.dato.dni);
		nL:=nL^.sig;
	end;
end;
//PROCESOS PARA CAGRAR LISTA NUEVA
procedure agregarAdelanteNuevaLista(var nL:listaNueva;cN:clienteNuevo);
var
	nue:listaNueva;
begin
	new(nue);
	nue^.dato:=cN;
	nue^.sig:=nL;
	nL:=nue;
end;


//PROGRAMA PRINCIPAL
var
	l:lista;
	nL:listaNueva;
	cN:clienteNuevo;
	v:vSuscripcion;
	vCosto:vCostoMens;
	gananciaTotal:integer;
	max1,max2:integer;
	suscripMax1:integer;
	suscripMax2:integer;
	dniActual:integer;
begin
	max1:=-1;
	max2:=-1;
	suscripMax1:=0;
	suscripMax2:=0;
	gananciaTotal:=0;
	vCosto[1]:=100;//ESTE VECTOR SE DISPONE PERO LO CARGO PARA VER SI DA BIEN Y DA BIEN
	vCosto[2]:=200;
	vCosto[3]:=300;
	vCosto[4]:=400;
	l:=nil;nL:=nil;
	cargarLista(l);
	inicializarVectorEn0(v);
	while(l<>nil) do begin
		v[l^.dato.tipoSuscrip]:=v[l^.dato.tipoSuscrip]+1;
		gananciaTotal:=gananciaTotal+vCosto[l^.dato.tipoSuscrip];//COMO LOS DOS VECTORES VAN DEL 1 AL 4 PUEDEN USARSE EN COMUN, YA QUE CUANDO SE LEE EL CLIENTE SE LEE Q PAGA LA SUSCRIP UNO VA A PAGAR LO Q ESTA CARGADO EN LA POS UNO DEL OTRO VECTOR
		dniActual:=l^.dato.dni;
		while(l<>nil) and (l^.dato.dni=dniActual)do begin
			if((l^.dato.edad>40) and ((l^.dato.tipoSuscrip=3) or (l^.dato.tipoSuscrip=4)))then begin
				darValor(cN,l^.dato.nombre,l^.dato.dni);
				agregarAdelanteNuevaLista(nL,cN);//DAR VALOR Y AGREGARADELANTE ES COMO EL PROCESO DE CREAR LISTA, SE CREA ESTA NUEVA LSITA A PARTIR DE LOS VALORES DADOS POR LA ANTERIOR, UNA VEZ CARGADA LA PODEMOS IMPRIMIR RECORRIENDOLA NORMAL COMO HICIMOS EN EL PROCESO DE IMPRIMIR LISTA
			end;
			l:=l^.sig;
		end;
	end;
	maximos(v,max1,max2,suscripMax1,suscripMax2);//SE PONE ACA XQ EL VECTOR YA ESTARIA CARGADO SI SALE DEL WHILE, OSEA CADA SUSCRIP TENDRIA SU CANTIDAD CARGADA
	writeln('la ganancia total de fortacos es de: ',gananciaTotal,'$');
	writeln('la suscripcion con mas clientes es: ',suscripMax1,' y la segunda suscripcion con mas clientes es: ',suscripMax2);
	imprimirListaNueva(nL,cN);
end.
