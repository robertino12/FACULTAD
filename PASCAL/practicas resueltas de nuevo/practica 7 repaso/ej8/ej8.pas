program ej8;
const
	dimF=7;
type
	rango=1..7;
	transferencia=record
		numCuentaOrigen:integer;
		dniOrigen:integer;
		numCuentaDestino:integer;
		dniDestino:integer;
		fecha:integer;
		hora:integer;
		monto:integer;
		codMotivo:rango;
	end;
	lista=^nodo;
	nodo=record
		dato:transferencia;
		sig:lista;
	end;
	lista2=^nodo2;
	nodo2=record
		dato:transferencia;
		sig:lista2;
	end;
	vecCont=array[rango]of integer;
procedure cargarVc (var vC:vecCont);
var
	i:integer;
begin
	for i:=1 to dimF do 
		vC[i]:=0;
end;
procedure leerTransfe (var t:transferencia);
begin
	write('escribir numero de cuenta de origen: ');
	readln(t.numCuentaOrigen);
	if(t.numCuentaOrigen<>-1)then begin
		write('escribir dni origen: ');
		readln(t.dniOrigen);
		write('escribir num cuenta destino: ');
		readln(t.numCuentaDestino);
		write('escribir dni destino: ');
		readln(t.dniDestino);
		write('escribir fecha transfe: ');
		readln(t.fecha);
		write('escribir hora transfe: ');
		readln(t.hora);
		write('escribir monto transfe: ');
		readln(t.monto);
		write('escribir cod motivo transfe: ');
		readln(t.codMotivo);
	end;
	writeln('----------------------------');
end;
procedure agregarAtras(var l:lista;var ult:lista; t:transferencia);
var
	nue:lista;
begin
	new(nue);
	nue^.dato:=t;
	nue^.sig:=nil;
	if(l=nil)then 
		l:=nue
	else
		ult^.sig:=nue;
	ult:=nue;
end;
procedure cargarLista (var l:lista);
var
	t:transferencia;
	ult:lista;
begin
	leerTransfe(t);
	while(t.numCuentaOrigen<>-1)do begin
		agregarAtras(l,ult,t);
		leerTransfe(t);
	end;
end;
procedure insertarOrdenado (var l2:lista2;t:transferencia);
var
	nue,act,ant:lista2;
begin
	new(nue);
	nue^.dato:=t;
	act:=l2;
	ant:=l2;
	while(act<>nil)and(t.numCuentaOrigen>act^.dato.numCuentaOrigen)do begin
		ant:=act;
		act:=act^.sig;
	end;
	if(act=ant)then
		l2:=nue
	else
		ant^.sig:=nue;
	nue^.sig:=act;
end;
procedure recorrerLista (l:lista;var l2:lista2);
begin
	while(l<>nil)do begin
		if(l^.dato.dniOrigen<>l^.dato.dniDestino)then
			insertarOrdenado(l2,l^.dato);
		l:=l^.sig;
	end;
end;
procedure maximo (transferencias,cod:integer;var maxCod,maxTransferencia:integer);
begin
	if(transferencias>maxTransferencia)then begin
		maxTransferencia:=transferencias;
		maxCod:=cod;
	end;
end;
function menosPares(numCuenta:integer):boolean;
var
	dig:integer;
	pares,impares:integer;
	aux:boolean;
begin
	pares:=0;
	impares:=0;
	while(numCuenta<>0)do begin
		dig:=numCuenta mod 10;
		if(dig mod 2=0)then
			pares:=pares+1
		else
			impares:=impares+1;
		numCuenta:=numCuenta div 10;
	end;
	if(pares<impares)then
		aux:=true
	else
		aux:=false;
	menosPares:=aux;
end;
procedure recorrerLista2 (l2:lista2;var vC:vecCont);
var
	numCuentaOrigenAct,montoTot,i:integer;
	maxCod,maxTransferencias,cantTransf:integer;
begin
	cantTransf:=0;
	while(l2<>nil)do begin
		//como la segunda lista esta ordenada por numero de cuenta de origen la unica forma
		//para hacer el inciso a es con corte de control
		montoTot:=0;
		numCuentaOrigenAct:=l2^.dato.numCuentaOrigen;
		while(l2^.dato.numCuentaOrigen=numCuentaOrigenAct)do begin
			montoTot:=montoTot+l2^.dato.monto;
			vC[l2^.dato.codMotivo]:=vC[l2^.dato.codMotivo]+1;
			if(l2^.dato.fecha=7)and(menosPares(l2^.dato.numCuentaDestino))then
				cantTransf:=cantTransf+1;
			l2:=l2^.sig;
		end;
		writeln('el monto total transferido a terceros de la cuenta de origen: ',numCuentaOrigenAct,' es: ',montoTot);
	end;
	maxCod:=-1;
	maxTransferencias:=-1;
	for i:=1 to dimF do
		maximo(vC[i],i,maxCod,maxTransferencias);
	writeln('el codigo de motivo que mas transferencias tuvo es: ',maxCod);
end;
var
	vC:vecCont;
	l:lista;
	l2:lista2;
begin
	l:=nil;
	l2:=nil;
	cargarVc(vC);
	cargarLista(l);
	recorrerLista(l,l2);
	recorrerLista2(l2,vC);
end.
