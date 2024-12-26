program title;	
type
	subrango=1..7;
	str=string[20];
	fechas=record
		anio:integer;
		mes:str;
		dia:integer;
	end;
	vMotivTrans=array[subrango]of integer;
	transferencia=record
		numCuentaOrig:integer;
		dniCuentaOrig:integer;
		numCuentaDest:integer;
		dniCuentaDest:integer;
		fecha:fechas;
		hora:integer;
		monto:integer;
		codMotivoTransf:subrango;
	end;
	listaA=^nodoA;
	nodoA=record
		dato:transferencia;
		sig:listaA;
	end;
	listaT=^nodoT;
	nodoT=record
		dato:transferencia;
		sig:listaT;
	end;
//PROCESOS PARA INFORMAR	
procedure inicializarVectorEn0 (var v:vMotivTrans);
var
	i:integer;
begin
	for i:=1 to 7 do begin
		v[i]:=0;
	end;
end;
procedure maxCodMotivo (var v:vMotivTrans;var max:integer;var codMax:subrango;codigo:integer);
begin
	v[codigo]:=v[codigo]+1;
	if(v[codigo]>max) then begin
		max:=v[codigo];
		codMax:=codigo;
	end;
end;
function menosDigitosPares(numCuentaDestino:integer):boolean;
var
	dig,cantDigImpares,cantDigPares:integer;
	aux:boolean;
begin
	cantDigImpares:=0;
	cantDigPares:=0;
	while(numCuentaDestino<>0) do begin
		dig:=numCuentaDestino mod 10;
		if(dig mod 2=1) then
			cantDigImpares:=cantDigImpares+1
		else
			cantDigPares:=cantDigPares+1;
		numCuentaDestino:=numCuentaDestino div 10;
	end;
	if(cantDigPares<cantDigImpares) then
		aux:=true
	else
		aux:=false;
	menosDigitosPares:=aux;
end;

//LISTA DE TRANSFERENCIA ENTRE ENERO Y DICIMEBRE 2018 SE DISPONE
procedure leerFecha (var f:fechas);//SE DISPONE
begin
	{writeln('escribir la fecha en la que se realizo la transferencia');
	write('escribir el anio: ');
	readln(f.anio);
	write('escribir el mes: ');
	readln(f.mes);
	write('escribir el dia: ');
	readln(f.dia);}
end;
procedure leerTransferencia (var t:transferencia);//SE DISPONE
begin
	{write('escribir el numero de cuenta de origen de la transferencia: ');
	readln(t.numCuentaOrig);
	if(t.numCuentaOrig<>-1) then begin
		write('escribir el dni de cuenta de origen de la transferencia: ');
		readln(t.dniCuentaOrig);
		write('escribir el numero de cuenta de destino de la transferencia: ');
		readln(t.numCuentaDest);
		write('escribir el dni de cuenta de destino de la transferencia: ');
		readln(t.dniCuentaDest);
		leerFecha(t.fecha);
		write('escribir la hora en la que se realizo la transferencia: ');
		readln(t.hora);
		write('escribir el monto de la transferencia: ');
		readln(t.monto);
		write('escribir el codigo del motivo de la transferencia: ');
		readln(t.codMotivoTransf);
	end;
	writeln('---------------------------------------');}
end;
procedure agregarAdelante (var l:listaA; t:transferencia);//SE DISPONE
{var
	nue:listaA;}
begin
	{new(nue);
	nue^.dato:=t;
	nue^.sig:=l;
	l:=nue;}
end;
procedure cargarLista (var l:listaA);//SE DISPONE
{var
	t:transferencia;}
begin
	{leerTransferencia(t);
	while(t.numCuentaOrig<>-1) do begin
		agregarAdelante(l,t);
		leerTransferencia(t);
	end;}
end;

//NUEVA ESTRUCTURA SOLO TRNASFERENCIAS TERCEROS
procedure agregarAdelanteT (var lT:listaT; t:transferencia);
var
	nue:listaT;
begin
	new(nue);
	nue^.dato:=t;
	nue^.sig:=lT;
	lT:=nue;
end;
procedure crearListaTerceros (var lT:listaT;l:listaA);
var
	t:transferencia;
begin
	while(l<>nil) do begin
		if(l^.dato.dniCuentaOrig<>l^.dato.dniCuentaDest) then begin
			leerTransferencia(t);
			agregarAdelanteT(lT,t);
		end;
		l:=l^.sig;
	end;
end;

//PORGRAMA PRINCIPAL
var 
	lA:listaA;
	lT:listaT;
	numCuentaOrigActual:integer;
	montoTotal:integer;
	v:vMotivTrans;
	max:integer;
	codMax:subrango;
	cantTransf:integer;
begin
	max:=-1;
	codMax:=1;
	lT:=nil;
	lA:=nil;
	cargarLista(lA);	
	crearListaTerceros(lT,lA);
	inicializarVectorEn0(v);
	cantTransf:=0;
	while(lT<>nil)do begin
		montoTotal:=0;
		numCuentaOrigActual:=lT^.dato.numCuentaOrig;
		while(lT<>nil)and(lT^.dato.numCuentaOrig=numCuentaOrigActual)do begin
			montoTotal:=montoTotal+lT^.dato.monto;
			maxCodMotivo(v,max,codMax,lT^.dato.codMotivoTransf);
			if(menosdigitosPares(lT^.dato.numCuentaDest)=true)and (lT^.dato.fecha.mes='junio') then 
				cantTransf:=cantTransf+1;
			lT:=lT^.sig;
		end;
		writeln('el monto total transferido a terceros de la cuenta de origen con numero: ',numCuentaOrigActual,' es de: ',montoTotal);
	end;
	writeln('el codigo de motivo que mas transferencias a terceros tuvo es: ',codMax);
	writeln('la cantidad de transferencias a terceros realizadas en el mes de junio en las cueales el numero de cuenta destino posee menos digitos pares que imapres es: ',cantTransf);
end.
