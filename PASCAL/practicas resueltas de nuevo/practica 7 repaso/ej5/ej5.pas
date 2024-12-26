program ej5;
const
	dimF=4;
type
	rango=1..dimF;
	camion=record
		patente:integer;
		anioFabricacion:integer;
		capacidad:integer;
	end;
	flota=array[rango]of camion;
	viajes=record
		codViaje:integer;
		codCamion:rango;
		distKm:integer;
		destino:string;
		anio:integer;
		dniChofer:integer;
	end;
	lista=^nodo;
	nodo=record
		dato:viajes;
		sig:lista;
	end;
	vecCont=array[rango]of integer;
procedure leerCamion(var c:camion);
begin
	write('escribir patente camion: ');
	readln(c.patente);
	write('escribir anio fabricacion: ');
	readln(c.anioFabricacion);
	write('escribir capacidad: ');
	readln(c.capacidad);
	writeln('---------------------');
end;
procedure cargarVec (var v:flota);
var
	c:camion;
	i:integer;
begin
	for i:=1 to dimF do begin
		writeln('escribir los datos del camion: ',i);
		leerCamion(c);
		v[i]:=c;
	end;
end;
procedure leerViaje (var v:viajes);
begin
	write('escribir cod viaje: ');
	readln(v.codViaje);
	if(v.codViaje<>-1)then begin
		write('escribir codigo camion: ');
		readln(v.codCamion);
		write('escribir dist km: ');
		readln(v.distKm);
		write('escribir destino: ');
		readln(v.destino);
		write('escribir anio viaje: ');
		readln(v.anio);
		write('escribir dni chofer: ');
		readln(v.dniChofer);
	end;
	writeln('----------------------');
end;
procedure agregarAdelante (var l:lista; v:viajes);
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
	leerViaje(v);
	while(v.codViaje<>-1)do begin
		agregarAdelante(l,v);
		leerViaje(v);
	end;
end;
procedure cargarVecCont (var vC:vecCont);
var
	i:integer;
begin
	for i:=1 to dimF do
		vC[i]:=0;
end;
procedure minimo (patente,km:integer;var minPatente,minKm:integer);
begin
	if(km<minKm)then begin
		minKm:=km;
		minPatente:=patente;
	end;
end;
procedure maximo (patente,km:integer;var maxPatente,maxKm:integer);
begin
	if(km>maxKm)then begin
		maxKm:=km;
		maxPatente:=patente;
	end;
end;
function soloImpares (dni:integer):boolean;
var
	dig:integer;
	seguir:boolean;
begin
	seguir:=true;
	while(dni<>0)and(seguir)do begin
		dig:=dni mod 10;
		if(dig div 2=0)then
			seguir:=false;
		dni:=dni div 10;
	end;
	soloImpares:=seguir;
end;
var
	l:lista;
	v:flota;
	vC:vecCont;
	maxPatente,maxKm,minPatente,minKm:integer;
	cantViajes:integer;
begin
	cantViajes:=0;
	cargarVecCont(vC);
	maxPatente:=-1;
	maxKm:=-1;
	minPatente:=10000;
	minKm:=10000;
	l:=nil;
	cargarVec(v);
	cargarLista(l);
	while(l<>nil)do begin
		vC[l^.dato.codCamion]:=vC[l^.dato.codCamion]+l^.dato.distKm;
		minimo(v[l^.dato.codCamion].patente,vC[l^.dato.codCamion],minPatente,minKm);
		maximo(v[l^.dato.codCamion].patente,vC[l^.dato.codCamion],maxPatente,maxKm);
		if(v[l^.dato.codCamion].capacidad>30.5)and((l^.dato.anio-v[l^.dato.codCamion].anioFabricacion)>5)then
			cantViajes:=cantViajes+1;
		if(soloImpares(l^.dato.dniChofer))then
			writeln('el codigo de viaje realizado por chofer con dni impar es: ',l^.dato.codViaje);
		l:=l^.sig;
	end;
	writeln('la patente del camion que menos km hizo es: ',minPatente);
	writeln('la patente del camion que mas km hizo es: ',maxPatente);
	writeln('la cantiidad de viajes que han realizado camiones con muchas condiciones es de: ',cantViajes);
end.
