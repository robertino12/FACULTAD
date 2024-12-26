program title;
const
	dimF=10;
type
	str=string[30];
	infoCuenta=record
		cbu:integer;
		tipoCuenta:1..2;
		saldo:real;
	end;
	vector=array[1..dimF]of infoCuenta;
	cliente=record
		codigo:integer;
		nro:integer;
		dni:integer;
		apellido:str;
		nombre:str;
		cuentas:vector;
		cantCuentas:integer;{dimL}
	end;
	lista=^nodo;
	nodo=record
		dato:cliente;
		sig:lista;
	end;
procedure leerInfoCuenta(var i:infoCuenta);
begin
	writeln('escribir el cbu de la cuenta del cliente');
	readln(i.cbu);
	if(i.cbu<>111)then begin
		writeln('escribir el tipo de cuenta del cliente');
		readln(i.tipoCuenta);
		writeln('escribir el saldo de la cuenta del cliente');
		readln(i.saldo);
	end;
end;
procedure cargarVector (var v:vector;var dimL:integer);
var
	i:infoCuenta;
begin
	dimL:=0;
	writeln('Escribir la informacion de la cuenta');
	leerInfoCuenta(i);
	writeln('-----------------------------');
	while(dimL<10) and (i.cbu<>111) do begin
		dimL:=dimL+1;
		v[diml]:=i;
		writeln('en la posicion: ',dimL);
		writeln('-----------------------------');
		writeln('Escribir la informacion de la cuenta');
		leerInfoCuenta(i);
	end;
end;
procedure leerCliente (var c:cliente);
begin
	writeln('escriba el codigo');
	readln(c.codigo);
	if(c.codigo<>-1) then begin
		writeln('Escribir el nro de cliente');
		readln(c.nro);
		writeln('Escribir el dni de cliente');
		readln(c.dni);
		writeln('escribir el apellido del cliente');
		readln(c.apellido);
		writeln('escribir el nombre del cliente');
		readln(c.nombre);
		writeln('informacion de la cuenta del cliente');
		cargarVector(c.cuentas,c.cantCuentas);
	end;
end;
procedure agregarAdelante(var L:lista; c:cliente);
var
	nue:lista;
begin
	new(nue);
	nue^.dato:=c;
	nue^.sig:=L;
	L:=nue;
end;
procedure cargarLista(var L:lista);
var
	c:cliente;
begin
	leerCliente(c);
	while(c.codigo<>-1)do begin
		agregarAdelante(L,c);
		leerCliente(c);
	end;	
end;
{----------------------------------------------------------------------------------}
{incisos B}
procedure saldoTotalisimo (v:vector;dimL:integer;var saldoTotal:real);
var
	i:integer;
begin
	for i:=1 to diml do begin
		if(v[i].tipoCuenta=1)then 
			saldoTotal:=saldoTotal+v[i].saldo;
	end;
end;
procedure cantidadCuentas (v:vector;diml:integer;var cantCuentas:integer);
var
	i:integer;
begin
	for i:=1 to diml do 
		cantCuentas:=cantCuentas+1;
end;
procedure menorCantCuentas (nro:integer;var nromin1,nromin2,min1,min2:integer;cantCuentas:integer);
begin
	if(cantCuentas<min1)then begin
		min2:=min1;
		min1:=cantCuentas;
		nromin2:=nromin1;
		nromin1:=nro;
	end
	else
	if(cantCuentas<min2)then begin
		min2:=cantCuentas;
		nromin2:=nro;
	end;
end;
procedure descomponer (L:lista;var cantPares,cantImpares:integer);
var
	dig:integer;
begin
	while(L^.dato.dni<>0) do begin
		dig:=L^.dato.dni mod 10;
		if(dig mod 2=0) then
			cantPares:=cantPares+1
		else
			cantImpares:=cantImpares+1;
		L^.dato.dni:=L^.dato.dni div 10;
	end;
end;
function esMasDigitosPares(cantPares:integer;cantImpares:integer):boolean;
begin
	esMasDigitosPares:=(cantPares>cantImpares);
end;
procedure apellidoYNombre(L:lista;var apellido,nombre:str;cantPares,cantImpares:integer);
begin
	if(esMasDigitosPares(cantPares,cantImpares)) then begin
		apellido:=L^.dato.apellido;
		nombre:=L^.dato.nombre;
	end;
end;
{inciso C}
procedure adicionar (L:lista;var v:vector;diml:integer);
var
	i:integer;
begin
			for i:=1 to diml do begin
				if(v[i].cbu=1122) then begin
					v[i].saldo:=v[i].saldo+1000;
					writeln('el saldo aumentado del cliente con codigo: ',L^.dato.codigo,' es de: ',v[i].saldo:1:2);
				end;
			end;
end;
var
	L:lista;
	saldoTotal:real;
	nromin1,nromin2,min1,min2:integer;
	cantCuentas:integer;
	cantPares,cantImpares:integer;
	apellido,nombre:str;
begin
	cantPares:=0;
	cantImpares:=0;
	cantCuentas:=0;
	nromin1:=1000;
	nromin2:=1000;
	min1:=1000;
	min2:=1000;
	apellido:=' ';
	nombre:=' ';
	L:=nil;
	cargarLista(L);
	while(L<>nil) do begin
		saldoTotal:=0;
		saldoTotalisimo(L^.dato.cuentas,L^.dato.cantCuentas,saldoTotal);
		writeln('El saldo total del cliente con codigo: ',L^.dato.codigo,' de las cajas de ahorro es de: ',saldoTotal:1:2);
		menorCantCuentas(L^.dato.nro,nromin1,nromin2,min1,min2,cantCuentas);
		descomponer(L,cantPares,cantImpares);
		apellidoYNombre(L,apellido,nombre,cantPares,cantImpares);
		writeln('el apellido y nombre de los con Dni compuesto por mas digitos pares que impares con codigo: ',L^.dato.codigo,' es: ',nombre,apellido);
		if(L^.dato.nro=7777) then 
			adicionar(L,L^.dato.cuentas,L^.dato.cantCuentas);{para llamar al vector, llamas el campo del registro q tiene almacenado el vector}
		L:=L^.sig;
	end;
	writeln('el numero del cliente con menor cantidad de cuentas en el banco es de: ',nromin1,' y el numero del segundo cliente con menor cantidad de cuentas en el banco es de: ',nromin2);
end.
