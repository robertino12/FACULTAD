program title3;
type
	str=string[30];
	viaje=record
		numViaje:integer;
		codigo:integer;
		direcDeOrig:str;
		direcDeDest:str;
		kmRecorridos:integer;
	end;
	lista=^nodo;
	nodo=record
		dato:viaje;
		sig:lista;
	end;
	
procedure masKm(cod,kmtotal:integer;var maxcod1,maxcod2:integer;var max1,max2:integer);
begin
	if(kmtotal>max1) then begin
		max2:=max1;
		max1:=kmtotal;
		maxcod2:=maxcod1;
		maxcod1:=cod;
	end
	else
		if(kmtotal>max2) then begin
			max2:=kmtotal;
			maxcod2:=cod;
		end;
end;

procedure agregarViaje(var l2:lista;v:viaje);{no se si esta bien lo copie, no lo entendi}
var
    nue,ant,act:lista;
begin
    new(nue);
    nue^.dato:=v;
    ant:=l2;// Al inicio de la lista
    act:=l2;// Al inicio de la lista
    while((l2<>nil)and(act^.dato.numViaje<v.numViaje))do begin
       ant:=act;
       act:=act^.sig;
    end;
       if(act=ant)then //Al inicio o lista vacia
         l2:=nue
       else// al medio o al final
         ant^.sig:=nue;  
       nue^.sig:=act;
end;
procedure leerRegistro(var v:viaje);
begin
	//se dispone
end;
procedure insertar (var l:lista;v:viaje);
begin
	//se dispone
end;
procedure cargarLista(var l:lista);
begin
	//se dispone
end;

var
	l,l2:lista;
	codActual,maxcod1,maxcod2,max1,max2,kmtotales:integer;
begin
	l:=nil;
	l2:=nil;
	cargarLista(l);
	maxcod1:=0;
	maxcod2:=0;
	max1:=-1;
	max2:=-1;
	while(l<>nil) do begin
		codActual:=l^.dato.codigo;
		kmtotales:=0;
		while(l<>nil) and (l^.dato.codigo=codActual) do begin
			kmtotales:=kmtotales+l^.dato.kmRecorridos;
			if(l^.dato.kmRecorridos>5) then{si es mayor a 5, agregas viaje y cada nodo se va a ordenar por numero de viaje}
				agregarViaje(l2,l^.dato);
			l:=l^.sig;
		end;
		masKm(codActual,kmtotales,maxcod1,maxcod2,max1,max2);
	end;
	writeln('el codigo del auto que mas km hizo es: ',maxcod1,' y el codigo del segundo auto que mas km hizo es: ',maxcod2);
end.
