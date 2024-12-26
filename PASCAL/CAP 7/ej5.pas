{
Una empresa de transporte de cargas dispone de la información de su flota compuesta por 100 camiones. 
De cada camión se tiene: patente, año de fabricación y capacidad (peso máximo en toneladas que puede transportar).
Realizar un programa que lea y almacene la información de los viajes realizados por la empresa. 
De cada viaje se lee: código de viaje, código del camión que lo realizó (1..100), distancia en kilómetros recorrida, ciudad de destino, año en que se realizó el viaje y DNI del chofer. 
La lectura finaliza cuando se lee el código de viaje -1.
Una vez leída y almacenada la información, se pide:
1. Informar la patente del camión que más kilómetros recorridos posee y la patente del camión que
menos kilómetros recorridos posee.
2. Informar la cantidad de viajes que se han realizado en camiones con capacidad mayor a 30,5
toneladas y que posean una antigüedad mayor a 5 años al momento de realizar el viaje (año en
que se realizó el viaje).
3. Informar los códigos de los viajes realizados por choferes cuyo DNI tenga sólo dígitos impares.
Nota: Los códigos de viaje no se repiten.}
program title5;
const
	dimf=100;
type
	camiones=record
		patente:integer;
		anoFabricacion:integer;
		capacidad:integer;
	end;
	vflota=array[1..dimf]of camiones;
	subrango=1..100;
	str=string[20];
	viajes=record
		codViaje:integer;
		codCamion:subrango;
		distKm:integer;
		ciudDestino:str;
		anoViaje:integer;
		dniChofer:integer;
		infoCamion:
	end;
	lista=^nodo;
	nodo=record;
		dato:viajes;
		sig:lista;
	end;
procedure leerCamion (var c:camion);//SE DISPONE PERO LO HAGO IGUAL
begin
	writeln('escribir la patente del camion: ');
	read(c.patente);
	writeln('escribir el ano de fabricacion del camion: ');
	read(c.anoFabricacion);
	writeln('escribir la capacidad del camion: ');
	read(c.capacidad);
end;
procedure 
procedure leerViajes (var v:viajes);
begin
	writeln('escribir el codigo de viaje: ');
	read(v.codViaje);
	if(v.codViaje<>-1) then begin		
		writeln('escribir el codigo de camion: ');
		read(v.codCamion);
		writeln('escribir la distancia recorridas en kilometros: ');
		read(v.distKm);
		writeln('escribir la ciudad de destino: ');
		read(v.ciudDestino);
		writeln('escribir el ano del viaje: ');
		read(v.anoViaje);
		writeln('escribir el dni del chofer: ');
		read(v.dniChofer);
	end;
	writeln('-----------------------');
end;
procedure agregarAdelante (var l:lista;v:viajes);
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
	v:viajes;
begin
	leerViajes(v);
	while(v.codViaje<>-1) do begin
		agregarAdelante(l,v);
		leerViajes(v);
	end;
end;
var
	l:lista;
begin
	l:=nil;
end.
