program ej9;
const
	dimF=8;
type
	rango=1..8;
	pelicula=record
		codPeli:integer;
		titulo:string;
		codGenero:rango;
		puntajeProm:integer;
	end;
	lista=^nodo;
	nodo=record
		dato:pelicula;
		sig:lista;
	end;
	critica=record
		dni:integer;
		nombre:string;
		codPeli:integer;
		puntaje:integer;
	end;
	lista2=^nodo2;
	nodo2=record
		dato:critica;
		sig:lista2;
	end;
	vecCont=array[rango]of integer;
//LISTA PELICULAS
procedure leerPeli (var p:pelicula);
begin
	write('escribir cod de pelicula: ');
	readln(p.codPeli);
	if(p.codPeli<>-1)then begin
		write('escribir titulo de peli: ');
		readln(p.titulo);
		write('escribir codigo de genero de la peli: ');
		readln(p.codGenero);
		write('escribir puntaje promedio de la peli: ');
		readln(p.puntajeProm);
	end;
	writeln('----------------------------');
end;
procedure agregarAtras(var l:lista;var ult:lista; p:pelicula);
var
	nue:lista;
begin
	new(nue);
	nue^.dato:=p;
	nue^.sig:=nil;
	if(l=nil)then 
		l:=nue
	else
		ult^.sig:=nue;
	ult:=nue;
end;
procedure cargarLista (var l:lista);
var
	p:pelicula;
	ult:lista;
begin
	leerPeli(p);
	while(p.codPeli<>-1)do begin
		agregarAtras(l,ult,p);
		leerPeli(p);
	end;
end;

//LISTA CRITICAS
procedure leerCritica (var c:critica);
begin
	write('escribir cod de pelicula: ');
	readln(c.codPeli);
	if(c.codPeli<>-1)then begin
		write('escribir dni del criticon: ');
		readln(c.dni);
		write('escribir nombre del criticon: ');
		readln(c.nombre);
		write('escribir puntaje del criticon: ');
		readln(c.puntaje);
	end;
	writeln('----------------------------');
end;
procedure insertarOrdenado (var l2:lista2;c:critica);
var
	nue,act,ant:lista2;
begin
	new(nue);
	nue^.dato:=c;
	act:=l2;
	ant:=l2;
	while(act<>nil)and(c.codPeli>act^.dato.codPeli)do begin
		ant:=act;
		act:=act^.sig;
	end;
	if(act=ant)then
		l2:=nue
	else
		ant^.sig:=nue;
	nue^.sig:=act;
end;
procedure cargarLista2 (var l2:lista2);
var
	c:critica;
begin
	leerCritica(c);
	while(c.codPeli<>-1)do begin
		insertarOrdenado(l2,c);
		leerCritica(c);
	end;
end;

//RECORRER E INCISOS
procedure iniciarVc (var vC:vecCont);
var
	i:integer;
begin
	for i:=1 to dimF do
		vC[i]:=0;
end;
procedure maximo (puntaje,cod:integer;var maxCod,maxPuntaje:integer);
begin
	if(puntaje>maxPuntaje)then begin
		maxPuntaje:=puntaje;
		maxCod:=cod;
	end;
end;
function paresImpares (dni:integer):boolean;
var
	dig:integer;
	pares,impares:integer;
	aux:boolean;
begin
	pares:=0;
	impares:=0;
	while(dni<>0)do begin
		dig:=dni mod 10;
		if(dig mod 2=0)then
			pares:=pares+1
		else
			impares:=impares+1;
		dni:=dni div 10;
	end;
	if(pares=impares)then
		aux:=true
	else
		aux:=false;
	paresImpares:=aux;
end;
procedure incisoA(var l:lista;l2:lista2;var vC:vecCont);
var
	aux:lista2;
	cant,sumaPuntaje,codPeliAct:integer;
	maxCod,maxPuntaje,i:integer;
begin
	maxCod:=-1;
	maxPuntaje:=-1;
	while(l<>nil)do begin
		aux:=l2;
		while(aux<>nil)do begin
			if(l^.dato.codPeli=aux^.dato.codPeli)then begin
				codPeliAct:=aux^.dato.codPeli;
				cant:=0;
				sumaPuntaje:=0;
				while(aux<>nil)and(aux^.dato.codPeli=codPeliAct)do begin
					sumaPuntaje:=sumaPuntaje+aux^.dato.puntaje;
					cant:=cant+1;
					aux:=aux^.sig;
				end;
				l^.dato.puntajeProm:=l^.dato.puntajeProm + (sumaPuntaje div cant);
				vC[l^.dato.codGenero]:=vC[l^.dato.codGenero]+l^.dato.puntajeProm;
			end
			else
				aux:=aux^.sig;
		end;
		l:=l^.sig;
	end;
	for i:= 1 to dimF do
		maximo(vC[i],i,maxCod,maxPuntaje);
	while(l2<>nil)do begin
		if(paresImpares(l2^.dato.dni))then
			writeln('el nombre del critico q tiene misma cant pares impares en dni: ',l2^.dato.nombre); 
		l2:=l2^.sig;
	end;
end;
procedure imprimir (l:lista);
begin
	while(l<>nil)do begin
		writeln('cod peli: ',l^.dato.codPeli);
		l:=l^.sig;
	end;
end;
var
	l:lista;
	l2:lista2;
	vC:vecCont;
begin
	iniciarVc(vC);
	l:=nil;
	l2:=nil;
	cargarLista(l);
	cargarLista2(l2);
	incisoA(l,l2,vC);//si la lista la paso x referencia el puntero l m queda en nil
	//pero sino la paso no se actualizan los promedios
end.
