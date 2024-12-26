program ej14;
const
	dimF=31;          	
type
	rango=1..dimF;
	prestamo=record
		nro:integer;
		isbn:integer;
		nroSocio:integer;
		diaPrestamo:rango;
	end;
	lista=^nodo;
	nodo=record
		dato:prestamo;
		sig:lista;
	end;
	datos=record
		isbn:integer;
		cantPres:integer;
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
procedure leerPrestamo (var p:prestamo);
begin
	write('escribir isbn libro: ');
	readln(p.isbn);
	if(p.isbn<>-1)then begin
		write('escribir nro de prestamo: ');
		readln(p.nro);
		write('escribir nro de socio: ');
		readln(p.nroSocio);
		write('escribir dia prestamo: ');
		readln(p.diaPrestamo);
	end;
	write('-----------------');
end;
procedure insertarOrdenado(var l:lista; p:prestamo);
var
	ant,act,nue:lista;
begin
	new(nue);
	nue^.dato:=p;
	ant:=l;
	act:=l;
	while(act<>nil)and(p.isbn>act^.dato.isbn)do begin
		ant:=act;
		act:=act^.sig;
	end;
	if(act=ant)then 
		l:=nue
	else
		ant^.sig:=nue;
	nue^.sig:=act;
end;
procedure cargarLista (var l:lista);
var	
	p:prestamo;
begin
	leerPrestamo(p);
	while(p.isbn<>-1)do begin
		insertarOrdenado(l,p);
		leerPrestamo(p);
	end;
end;
procedure insertarOrdenadoL2 (var l2:lista2;d:datos);
var
	ant,act,nue:lista2;
begin
	new(nue);
	nue^.dato:=d;
	ant:=l2;
	act:=l2;
	while(act<>nil)and(d.isbn>act^.dato.isbn)do begin
		ant:=act;
		act:=act^.sig;
	end;
	if(act=ant)then 
		l2:=nue
	else
		ant^.sig:=nue;
	nue^.sig:=act;
end;
procedure minimo(prestamos,dia:integer;var diaMin,cantPrestamosMin:integer);
begin
	if(prestamos<cantPrestamosMin)then begin
		diaMin:=dia;
		cantPrestamosMin:=prestamos;
	end;
end;
function prestamoImpar (nro:integer):boolean;
var
	dig:integer;
	aux:boolean;
begin
	aux:=true;
	while(nro<>0)and(aux)do begin
		dig:=nro mod 10;
		if(dig mod 2=0)then
			aux:=false;
		nro:=nro div 10;
	end;
	prestamoImpar:=aux;
end;
function socioPar (nro:integer):boolean;
var
	dig:integer;
	aux:boolean;
begin
	aux:=true;
	while(nro<>0)and(aux)do begin
		dig:=nro mod 10;
		if(dig mod 2<>0)then
			aux:=false;
		nro:=nro div 10;
	end;
	socioPar:=aux;
end;
procedure recorrerLista (l:lista;var l2:lista2;var vC:vecCont);
var
	cantPrestado,isbnAct:integer;
	d:datos;
	i:integer;
	diaMin,cantPrestamosMin:integer;
	cantPrestamos,cantTotPrestado:integer;
begin
	diaMin:=10000;
	cantPrestamosMin:=10000;
	cantPrestamos:=0;
	cantTotPrestado:=0;
	while(l<>nil)do begin
		isbnAct:=l^.dato.isbn;
		cantPrestado:=0;
		while(l<>nil)and(l^.dato.isbn=isbnAct)do begin
			cantPrestado:=cantPrestado+1;
			vC[l^.dato.diaPrestamo]:=vC[l^.dato.diaPrestamo]+1;
			if(prestamoImpar(l^.dato.nro))and(socioPar(l^.dato.nroSocio))then
				cantPrestamos:=cantPrestamos+1;
			cantTotPrestado:=cantTotPrestado+1;
			l:=l^.sig;
		end;
		d.cantPres:=cantPrestado;
		d.isbn:=isbnAct;
		insertarOrdenadoL2(l2,d);
	end;
	for i:=1 to dimF do 
		minimo(vC[i],i,diaMin,cantPrestamosMin);
	writeln('el dia del mes que menos prestamos se hicieron es: ',diaMin);
	writeln('el porcentaje de prestamos con condiciones es de: ',(cantPrestamos*100) div cantTotPrestado,'%'); 
end;
procedure imprimir (l:lista2);
begin
	while(l<>nil)do begin
		writeln('isbn: ',l^.dato.isbn);
		l:=l^.sig;
	end;
end;
var
	l:lista;
	l2:lista2;
	vC:vecCont;
begin
	l:=nil;
	l2:=nil;
	cargarVecCont(vC);
	cargarLista(l);
	recorrerLista(l,l2,vC);
	imprimir(l2);
end.
