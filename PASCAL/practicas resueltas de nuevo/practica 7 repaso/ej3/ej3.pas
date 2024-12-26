program ej3;
type
	viaje=record
		num:integer;
		codAuto:integer;
		kmRecor:integer;
	end;
	lista=^nodo;
	nodo=record
		dato:viaje;
		sig:lista;
	end;
	lista2=^nodo2;
	nodo2=record
		dato:viaje;
		sig:lista2;
	end;
procedure leerViaje(var v:viaje);
begin
	write('escribir cod de auto: ');
	readln(v.codAuto);
	write('escribir num viaje: ');
	readln(v.num);
	write('escribir km recorridos: ');
	readln(v.kmRecor);
	writeln('--------------------------------------');
end;
procedure agregarAdelante(var l:lista;v:viaje);
var
	nue:lista;
begin
	new(nue);
	nue^.dato:=v;
	nue^.sig:=l;
	l:=nue;
end;
procedure cargarLista(var l:lista);
var
	v:viaje;
begin
	leerViaje(v);
	while(v.codAuto<>0)do begin
		agregarAdelante(l,v);
		leerViaje(v);
	end;
end;
procedure maximo(cod,km:integer;var maxCod,maxCod2,kmMax,kmMax2:integer);
begin
	if(km>kmMax)then begin
		kmMax2:=kmMax;
		maxCod2:=maxCod;
		kmMax:=km;
		maxCod:=cod;
	end
	else
		if(km>kmMax2)then begin
			kmMax2:=km;
			maxCod2:=cod;
		end;
end;
procedure agregarAdelante2 (var l2:lista2;v:viaje);
var
	nue:lista2;
begin
	new(nue);
	nue^.dato:=v;
	nue^.sig:=l2;
	l2:=nue;
end;
var
	l:lista;
	l2:lista2;
	cantKm,codAutAct:integer;
	maxCod,maxCod2,kmMax,kmMax2:integer;
begin
	maxCod:=-1;
	maxCod2:=-1;
	kmMax:=-1;
	kmMax2:=-1;
	l:=nil;
	l2:=nil;
	cargarLista(l);
	while(l<>nil)do begin	
		cantKm:=0;
		codAutAct:=l^.dato.codAuto;
		while(l<>nil)and(l^.dato.codAuto=codAutAct)do begin
			cantKm:=cantKm+l^.dato.kmRecor;
			if(l^.dato.kmRecor>5)then 
				agregarAdelante2(l2,l^.dato);
			l:=l^.sig;
		end;
		maximo(codAutAct,cantKm,maxCod,maxCod2,kmMax,kmMax2);
	end;
	writeln('el codgio de auto con mas km es: ',maxCod,' y el segundo con mas es: ',maxCod2);
	while(l2<>nil)do begin
		writeln('km record: ',l2^.dato.kmRecor);
		l2:=l2^.sig;
	end;
end.
