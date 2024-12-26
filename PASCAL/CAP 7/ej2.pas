program title2;
type	
	subrango=1..6;
	str=string[20];
	cliente=record
		codigo:integer;
		dni:integer;
		apellido:str;
		nombre:str;
		codigoPoliza:subrango;
		montoMensual:integer;
	end;
	lista=^nodo;
	nodo=record
		dato:cliente;
		sig:lista;
	end;
	vTabla=array [subrango]of integer;
{en realidad dice que se dispone pero lo voy a hacer igual para que imprima bien}
procedure cargarTabla (var v:vTabla;l:lista);
var
	montoAdicional:integer;
	i:integer;
begin{cada elemento del vector tiene adentro un numero q representa un monto adicional segun el numero de poliza que tenga el cliente, ya que el vector va de 1 al 6 como la poliza}
	i:=l^.dato.codigoPoliza;
	for i:=1 to 6 do begin
		writeln('escribir el monto adicional que se le asigna a la poliza: ',i);
		readln(montoAdicional);
		v[i]:=montoAdicional;
	end;
end;
{el procedure seria asi cuando dice se dispone
procedure cargarTabla (var v:vTabla)
begin
	//se dispone
end;}

{PROCESOS PARA INFORMAR}
procedure informarCliente (l:lista;var montoTotal:integer;v:vTabla);
begin
	montoTotal:=l^.dato.montoMensual+v[l^.dato.codigoPoliza];
	writeln('----------------------');
	writeln('la informacion del cliente con codigo: ',l^.dato.codigo,' es: ');
	writeln('el dni del cliente es: ',l^.dato.dni);
	writeln('el apellido del cliente es: ',l^.dato.apellido);
	writeln('el nombre del cliente es: ',l^.dato.nombre);
	writeln('el monto completo que paga mensualmente por su seguro automotriz es: ',montoTotal);
end;
procedure descomponer(l:lista);
var
	dig,cantNueve:integer;
begin
	cantNueve:=0;
	while(L^.dato.dni<>0) do begin
		dig:=L^.dato.dni mod 10;
		if(dig=9) then
			cantNueve:=cantNueve+1;
		L^.dato.dni:=L^.dato.dni div 10;
	end;
	if(cantNueve>=2) then
		writeln('el apellido y nombre del cliente que tiene al menos dos digitos 9 es: ',l^.dato.apellido,' ',l^.dato.nombre);
end;
procedure eliminar ( var l:lista;codigo:integer);{probe haciendolo como el ppt y como los d notion pero me tira runtime error cuando pongo el proceso d imprimir en el programa principal}
var
	actual,ant:lista;
begin
	actual:=l;
	ant:=l;
		while(actual^.dato.codigo<>codigo)do begin
			ant:=actual;
			actual:=actual^.sig;
		end;
		if(actual=l) then
			l:=l^.sig
		else
			ant^.sig:=actual^.sig;
		dispose(actual);
end;

{LECTURA CLIENTE Y CARGA DE LISTA}
procedure leerRegistro (var c:cliente);
begin
	writeln('escribir el codigo del cliente');
	readln(c.codigo);
	writeln('escribir el dni del cliente');
	readln(c.dni);
	writeln('escribir el apellido del cliente');
	readln(c.apellido);
	writeln('escribir el nombre del cliente');
	readln(c.nombre);
	writeln('escribir el codigo de poliza del cliente');
	readln(c.codigoPoliza);
	writeln('escribir el monto mensual del cliente');
	readln(c.montoMensual);
	writeln('---------------------------');
end;
procedure agregarAdelante (var l:lista; c:cliente);
var
	nue:lista;
begin
	new(nue);
	nue^.dato:=c;
	nue^.sig:=l;
	l:=nue;
end;
procedure cargarLista(var l:lista);
var
	c:cliente;
begin
	repeat
		leerRegistro(c);
		agregarAdelante(l,c);
	until(c.codigo=1122);
end;
procedure imprimir (l:lista);{lo hago para ver si lo elimino}
begin
	while(l<>nil) do begin
		writeln('codigo de cliente: ',l^.dato.codigo);
		l:=l^.sig;
	end;	
end;
{PROGRAMA PRINCIPAL}
var
	l:lista;
	v:vTabla;
	montoTotal,codigo:integer;
begin
	montoTotal:=0;
	l:=nil;
	cargarLista(l);
	cargarTabla(v,l);
	while(l<>nil) do begin
		informarCliente(l,montoTotal,v);
		descomponer(l);
		l:=l^.sig;
	end;
	writeln('Ingrese codigo de cliente a eliminar');
	readln(codigo);
	eliminar(l,codigo);
end.
