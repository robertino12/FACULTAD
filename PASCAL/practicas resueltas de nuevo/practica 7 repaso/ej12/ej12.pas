program ej12;
const
	dimF=4;
type
	rango=1..4;
	vector=array[rango]of integer;
	cliente=record
		nombre:string;
		dni:integer;
		edad:integer;
		tipoSuscrip:rango;
	end;
	lista=^nodo;
	nodo=record
		dato:cliente;
		sig:lista;
	end;
	datos=record
		nombre:string;
		dni:integer;
	end;
	lista2=^nodo2;
	nodo2=record
		dato:datos;
		sig:lista2;
	end;
	vecCont=array[rango]of integer;
procedure cargarVecCont (var vC:vecCont);
var
	i:integer;
begin
	for i:=1 to dimF do
		vC[i]:=0;
end;
procedure cargarVec (var v:vector);
begin
	v[1]:=10;
	v[2]:=20;
	v[3]:=30;
	v[4]:=40;
end;
procedure leerCliente (var c:cliente);
begin
	write('escribir dni del cliente: ');
	readln(c.dni);
	if(c.dni<>0)then begin
		write('escribir nombre del cliente: ');
		readln(c.nombre);
		write('escribir edad del cliente: ');
		readln(c.edad);
		write('escribir tipo de suscripcion del cliente: ');
		readln(c.tipoSuscrip);
	end;
	writeln('------------------------------');
end;
procedure agregarAtras (var l:lista; var ult:lista; c:cliente);
var
	nue:lista;
begin
	new(nue);
	nue^.dato:=c;
	nue^.sig:=nil;
	if(l=nil)then
		l:=nue
	else
		ult^.sig:=nue;
	ult:=nue;
end;
procedure cargarLista (var l:lista);
var
	c:cliente;
	ult:lista;
begin
	leerCliente(c);
	while(c.dni<>0)do begin
		agregarAtras(l,ult,c);
		leerCliente(c);
	end;
end;
procedure maximo( clientes,suscripcion:integer;var maxSuscrip,maxSuscrip2,maxCliente,maxCliente2:integer);
begin
	if(clientes>maxCliente)then begin
		maxCliente2:=maxCliente;
		maxSuscrip2:=maxSuscrip;
		maxCliente:=clientes;
		maxSuscrip:=suscripcion;
	end
	else
		if(clientes>maxCliente2)then begin
			maxCliente2:=clientes;
			maxSuscrip2:=suscripcion;
		end;
end;
procedure insertarOrdenado (var l2:lista2;d:datos);
var
	ant,act,nue:lista2;
begin
	act:=l2;
	ant:=l2;
	new(nue);
	nue^.dato:=d;
	while(act<>nil)and(d.dni>act^.dato.dni)do begin
		ant:=act;
		act:=act^.sig;
	end;
	if(act=ant)then
		l2:=nue
	else
		ant^.sig:=nue;
	nue^.sig:=act;
end;
procedure recorrerLista(l:lista;v:vector;var vC:vecCont;var l2:lista2);
var
	gananciaTot,i:integer;
	maxSuscrip,maxClientes,maxSuscrip2,maxClientes2:integer;
	d:datos;
begin
	gananciaTot:=0;
	maxSuscrip:=-1;
	maxClientes:=-1;
	maxSuscrip2:=-1;
	maxClientes2:=-1;
	while(l<>nil)do begin
		gananciaTot:=gananciaTot+v[l^.dato.tipoSuscrip];
		vC[l^.dato.tipoSuscrip]:=vC[l^.dato.tipoSuscrip]+1;
		if(l^.dato.edad>40)and(l^.dato.tipoSuscrip=3)or(l^.dato.tipoSuscrip=4)then begin
			d.nombre:=l^.dato.nombre;
			d.dni:=l^.dato.dni;
			insertarOrdenado(l2,d);
		end;
		l:=l^.sig;
	end;
	writeln('la ganancia total de fortacos es de: ',gananciaTot);
	for i:=1 to dimF do
		maximo(vC[i],i,maxSuscrip,maxSuscrip2,maxClientes,maxClientes2);
	writeln('la suscripcion con mas clientes es: ',maxSuscrip);
	writeln('la segunda suscripcion con mas clientes es: ',maxSuscrip2);
end;
procedure imprimir (l2:lista2);
begin
	while(l2<>nil)do begin
		writeln('nombre: ',l2^.dato.nombre);
		l2:=l2^.sig;
	end;
end;
var
	l:lista;
	v:vector;
	vC:vecCont;
	l2:lista2;
begin
	l:=nil;
	l2:=nil;
	cargarLista(l);
	cargarVec(v);
	cargarVecCont(vC);
	recorrerLista(l,v,vC,l2);
	imprimir(l2);
end.
