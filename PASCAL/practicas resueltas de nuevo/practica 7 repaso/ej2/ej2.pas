program ej2;
type
	rango=1..6;//PREGUNTAR PORQUE NO IMPRIME LA LISTA
	cliente=record
		cod:integer;
		dni:integer;
		nombre:string;
		codPoliza:rango;
		montoMens:integer;
	end;
	lista=^nodo;
	nodo=record
		dato:cliente;
		sig:lista;
	end;
	vecPoliza=array[rango]of integer;
procedure cargarVecPoliza (var vP:vecPoliza);
begin
	vP[1]:=10;
	vP[2]:=20;
	vP[3]:=30;
	vP[4]:=40;
	vP[5]:=50;
	vP[6]:=60;
end;
procedure cargarReg (var c:cliente);
begin
	write('escribir codigo cliente: ');
	readln(c.cod);
	write('escribir dni cliente: ');
	readln(c.dni);
	write('escribir nombre cliente: ');
	readln(c.nombre);
	write('escribir cod poliza cliente: ');
	readln(c.codPoliza);
	write('escribir montoMens cliente: ');
	readln(c.montoMens);
	writeln('-------------------------');
end;
procedure agregarAdelante (var l:lista;c:cliente);
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
	c:cliente;
begin
	repeat
		cargarReg(c);
		agregarAdelante(l,c);
	until(c.cod=1122);
end;
function contiene(dni:integer):boolean;
var
	aux:boolean;
	dig:integer;
	cantNueves:integer;
begin
	cantNueves:=0;
	while(dni<>0)do begin
		dig:=dni mod 10;
		if(dig=9)then
			cantNueves:=cantNueves+1;
		dni:=dni div 10;
	end;
	if(cantNueves>=2)then
		aux:=true
	else
		aux:=false;
	contiene:=aux;
end;
procedure eliminar (var l:lista; cod:integer);
var
	act,ant:lista;
begin
	act:=l;
	while(act^.dato.cod<>cod)do begin
		ant:=act;
		act:=act^.sig;
	end;
		if(act=l)then
			l:=l^.sig
		else
			ant^.sig:=act^.sig;
		dispose(act);
end;
procedure imprimir (l:lista);
begin
	while(l<>nil)do begin
		writeln('dni cliente: ',l^.dato.dni);
		l:=l^.sig;
	end;
end;
var
	l,nuevo:lista;
	vP:vecPoliza;
	cod:integer;
begin
	l:=nil;
	cargarLista(l);imprimir(l);
	nuevo:=l;
	cargarVecPoliza(vP);
	while(l<>nil)do begin
		writeln('el cliente: ',l^.dato.nombre,' paga: ',l^.dato.montoMens+vP[l^.dato.codPoliza]);
		if(contiene(l^.dato.dni))then
			writeln('el cliente con nombre: ',l^.dato.nombre,' contiene al menos dos digitos 9 en su dni');
		l:=l^.sig;
	end;
	//PARA IMPRIMIR, TENGO QUE CREAR UNA INSTANCIA NUEVA DE LA LISTA, PORQUE DESP D RECORRERLA
	//EN EL WHILE DE ARRIBA, EL PUNTERO L APUNTA A NIL, ENTONCES CUANDO VOY A IMPRIMIR NO IMPRIME NADA
	//SI ES QUE LE PASO EL PARAMETRO L, POR ESO IMPRIMIR LO PUSE ARRIBA DEL TODO, PARA VER
	//LA LISTA NORMAL
	//Y PARA VER LO MODIFICADA, GUARDE LA LISTA AL COMIENZO EN UNA VAR, Y ESA VAR LA USO PARA ELIMINAR Y VER COMODA QUEDA
	write('escribir codigo cliente a eliminar: ');
	readln(cod);
	eliminar(nuevo,cod);
	imprimir(nuevo);
end.
