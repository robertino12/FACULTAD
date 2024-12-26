program title;
const
	dimf=3;				
type
	str=string[30];
	subrango=1..dimf;
	goles=record
		codigo:integer;//NO LO TIENE PERO LO HAGO PARA CORTAR LA LISTA
		numeroPartido:subrango;
		equipoOPais:str;
		numCamisetaJugador:integer;
	end;
	lista=^nodo;//SE DISPONE 
	nodo=record
		dato:goles;
		sig:lista;
	end;
	partido=record
		numeroPartido:subrango;
		nombreEstadio:str;
		nombrePrimerPais:str;
		nombreSegundoPais:str;
	end;
	vInfoPartido=array[subrango]of partido;
	vPartidosMas5Goles=array[subrango] of integer;
//------------------------------------------------------------------------------
//PROCESO PARA INFORMAR
procedure maximo (var max:integer;var nombrePaisMax:str;nombrePais:str;cantGoles:integer);
begin
	if(cantGoles>max) then begin
		max:=cantGoles;
		nombrePaisMax:=nombrePais;
	end;
end;


//PROCESO PARA RECORRER E INFORMAR
procedure recorrerEInformar (l:lista;v:vInfoPartido;var vec:vPartidosMas5Goles);
var
	paisGolActual:str;
	cantGolesPais:integer;
	cantPartidosConMas5Goles:integer;
	i:integer;
	cantGoles:integer;
	max:integer;
	nombrePaisMax:str;
begin		
	cantPartidosConMas5Goles:=0;
	cantGolesPais:=0;
	nombrePaisMax:='';
	max:=-1;
	while(l<>nil) do begin
		cantGoles:=0;
		cantGolesPais:=0;
		paisGolActual:=l^.dato.equipoOPais;//SI SE CAMBIA DE PAIS QUE HIZO EL GOL NO CAMBIA DE PARTIDO SI O SI XQ PUEDE APARECER EL RIVAL DE ESE EQUIPO EN CAHBONES Q HICIEORN EL GOL Y SERIA EL MISMO PARTIDO
		while(l<>nil) and (l^.dato.equipoOPais=paisGolActual) do begin
				cantGolesPais:=cantGolesPais+1;
			if(cantGolesPais>5)then//SEA EL MISMO PAIS EL Q HACE 5 GOLES U OTRO PERO MIENTRAS ESTEN EN EL MISMO PARTIDO HAGAN MAS DE 5 GOLES, SE VA A SUMAR UNO AL VECTOR CONTADOR
				vec[l^.dato.numeroPartido]:=vec[l^.dato.numeroPartido]+cantGolesPais;//SUMO LOS GOLES Y DESP CUANDO RECOORO EL VECTOR GURADO LOS APRTIDOS QUE HICIERON MAS DE 5 GOLES EN UNA VAR CANTIDAD QUE ME TIRE CUANTOS PARTIDOS HAY CON MAS D 5 GOLES
			if(v[l^.dato.numeroPartido].nombreEstadio='san paolo')and (l^.dato.numCamisetaJugador=9)then
				cantGoles:=cantGoles+1;
				{vectardo[l^.dato.numeroPartido]:=vectardo[l^.dato.numeroPartido]+cantGoles;}//LO BORRO SUPONIENDO QUE SOLO UNA VEZ CADA PAIS PUDO JUGAR EN ESE ESTADIO, XQ NO SE COMO HACER PARA CONECTAR EN EL PROCESO DE MAXIMO EL NUMERO DE PARTIDO, XQ SI LLAMAS MAXIMO FUER DEL WHILE QUIERE DECIR Q CAMBIO EL NUMERO DE PARTIDO O NO, ENTONCES EN EL PROCESO NO ESTARIA COMPARANDO EL NUMERO DE PARTIDO ANTERIOR Q NECESITABA SINO EL NUEVO Q SE CAMBIA UNA VEZ FUERA DEL WHILE
			l:=l^.sig;
		end;
		{if(l^.dato.numeroPartido<>v[l^.dato.numeroPartido].numeroPartido)then //LO QUE HAGO CON ESTO ES QUE SI VIENE OTRO PAIS A HACER GOL PERO NO ES EL MISMO NUMERO DE PARTIDO, QUE LA CANTIDAD DE GOLES VUELVA A 0
			cantGolesPais:=0;}//SI SACO ESTO Y PONGO CANTGOLESPAIS CADA VEZ Q CAMBIA D PAIS NO M TIRA ERROR, Y M TIRA Q SI ITALIA HIZO MAS D 5 GOLES M CUENTA QUE EN UN PARTIDO HUBO MAS D 5 GOLES, SI PONGO 6 GOLES SEGUIDOS DE FRANCIA TAMBIEN ME CUENTA COMO PAIS, Y DESPUES LOS DE INFORMAR EL PAIS EN EL ESTADIO ESE TAMBIEN ME LO INFROMA BIEN PERO QUISIERA RESOLVER LO DE COMO AHCER SI EN EL MISMO PARTIDO EL OTRO EQUIPO TAMBIEN METE GOLES QUE LOS CUENTE Y SI ENTRE LOS DOS EQUIPOS LLEGA A MAS DE 5 QUE LO CUENTE COMO PARTIDO MAYOR A 5 GOLES
		maximo(max,nombrePaisMax,paisGolActual,cantGoles);
	end;
	for i:=1 to dimf do begin
		if(vec[i]>5) then
			cantPartidosConMas5Goles:=cantPartidosConMas5Goles+1;
	end;
	writeln('la cantidad de partidos con mas de 5 goles es de: ',cantPartidosConMas5Goles);	
	writeln('el nombre del pais con amyor cantidad de goles realizados en el estadio SanPaolo por el jugador camiseta numero 9 es: ',nombrePaisMax);
end;


//PROCESOS PARA CARGAR VECTOR
procedure leerInfoPartido (var p:partido);
begin
	write('escribir el numero de partido: ');
	readln(p.numeroPartido);
	write('escribir el nombre del estadio donde se jugo el partido: ');
	readln(p.nombreEstadio);
	write('escribir el nombre del primer pais o equipo que participo: ');
	readln(p.nombrePrimerPais);
	write('escribir el nombre del segundo pais o equipo que participo: ');
	readln(p.nombreSegundoPais);
end;
procedure cargarVectorConInfoPartido (var v:vInfoPartido);
var
	i:integer;
	p:partido;
begin
	for i:=1 to dimf do begin
		leerInfoPartido(p);
		v[i]:=p;
	end;
end;
procedure cargarVectorEn0 (var vec:vPartidosMas5Goles);
var
	i:integer;
begin
	for i:=1 to dimf do
		vec[i]:=0;
end;

//PROCESO CARGAR LISTA AUNQUE SE DISPONE
procedure leerInfoGoles (var g:goles);
begin
	writeln('escribir la informacion de los goles realizados en un partido');
	write('escribir un numero que represente un codigo: ');
	readln(g.codigo);
	if(g.codigo<>-1)then begin
		write('escribir el numero de partido: ');
		readln(g.numeroPartido);
		write('escribir el equipo o pais que realizo el gol en el partido: ');
		readln(g.equipoOPais);
		write('escribir el numero de camiseta del jugador que realizo el gol: ');
		readln(g.numCamisetaJugador);
	end;
	writeln('-----------------------------------------------------------------------');
end;
procedure agregarAdelante (var l:lista;g:goles);
var
	nue:lista;
begin
	new(nue);
	nue^.dato:=g;
	nue^.sig:=l;
	l:=nue;
end;
procedure cargarLista (var l:lista);
var
	g:goles;
begin
	leerInfoGoles(g);
	while(g.codigo<>-1) do begin
		agregarAdelante(l,g);
		leerInfoGoles(g);
	end;
end;


//PROGRAMA PRINCIPAL
var
	l:lista;
	v:vInfoPartido;
	vec:vPartidosMas5Goles;
begin
	l:=nil;
	cargarLista(l);
	cargarVectorConInfoPartido(v);
	cargarVectorEn0(vec);
	recorrerEInformar(l,v,vec);
end.
{
escribir la informacion de los goles realizados en un partido
escribir un numero que represente un codigo: 1
escribir el numero de partido: 1
escribir el equipo o pais que realizo el gol en el partido: italia
escribir el numero de camiseta del jugador que realizo el gol: 9
-----------------------------------------------------------------------
escribir la informacion de los goles realizados en un partido
escribir un numero que represente un codigo: 1
escribir el numero de partido: 1
escribir el equipo o pais que realizo el gol en el partido: italia
escribir el numero de camiseta del jugador que realizo el gol: 2
-----------------------------------------------------------------------
escribir la informacion de los goles realizados en un partido
escribir un numero que represente un codigo: 1
escribir el numero de partido: 1
escribir el equipo o pais que realizo el gol en el partido: italia
escribir el numero de camiseta del jugador que realizo el gol: 4
-----------------------------------------------------------------------
escribir la informacion de los goles realizados en un partido
escribir un numero que represente un codigo: 1
escribir el numero de partido: 1
escribir el equipo o pais que realizo el gol en el partido: italia
escribir el numero de camiseta del jugador que realizo el gol: 5
-----------------------------------------------------------------------
escribir la informacion de los goles realizados en un partido
escribir un numero que represente un codigo: 1
escribir el numero de partido: 1
escribir el equipo o pais que realizo el gol en el partido: italia
escribir el numero de camiseta del jugador que realizo el gol: 9
-----------------------------------------------------------------------
escribir la informacion de los goles realizados en un partido
escribir un numero que represente un codigo: 1
escribir el numero de partido: 1
escribir el equipo o pais que realizo el gol en el partido: italia
escribir el numero de camiseta del jugador que realizo el gol: 8
-----------------------------------------------------------------------
escribir la informacion de los goles realizados en un partido
escribir un numero que represente un codigo: 1
escribir el numero de partido: 3
escribir el equipo o pais que realizo el gol en el partido: francia
escribir el numero de camiseta del jugador que realizo el gol: 9
-----------------------------------------------------------------------
escribir la informacion de los goles realizados en un partido
escribir un numero que represente un codigo: 1
escribir el numero de partido: 3
escribir el equipo o pais que realizo el gol en el partido: francia
escribir el numero de camiseta del jugador que realizo el gol: 2
-----------------------------------------------------------------------
escribir la informacion de los goles realizados en un partido
escribir un numero que represente un codigo: 1
escribir el numero de partido: 3
escribir el equipo o pais que realizo el gol en el partido: francia
escribir el numero de camiseta del jugador que realizo el gol: 4
-----------------------------------------------------------------------
escribir la informacion de los goles realizados en un partido
escribir un numero que represente un codigo: 1
escribir el numero de partido: 3
escribir el equipo o pais que realizo el gol en el partido: francia
escribir el numero de camiseta del jugador que realizo el gol: 5
-----------------------------------------------------------------------
escribir la informacion de los goles realizados en un partido
escribir un numero que represente un codigo: 1
escribir el numero de partido: 3
escribir el equipo o pais que realizo el gol en el partido: francia
escribir el numero de camiseta del jugador que realizo el gol: 9
-----------------------------------------------------------------------
escribir la informacion de los goles realizados en un partido
escribir un numero que represente un codigo: 1
escribir el numero de partido: 1
escribir el equipo o pais que realizo el gol en el partido: francia
escribir el numero de camiseta del jugador que realizo el gol: 8
-----------------------------------------------------------------------
escribir la informacion de los goles realizados en un partido
escribir un numero que represente un codigo: 1
escribir el numero de partido: 2
escribir el equipo o pais que realizo el gol en el partido: brazil
escribir el numero de camiseta del jugador que realizo el gol: 9
-----------------------------------------------------------------------
escribir la informacion de los goles realizados en un partido
escribir un numero que represente un codigo: 1
escribir el numero de partido: 2
escribir el equipo o pais que realizo el gol en el partido: brazil
escribir el numero de camiseta del jugador que realizo el gol: 9
-----------------------------------------------------------------------
escribir la informacion de los goles realizados en un partido
escribir un numero que represente un codigo: -1
-----------------------------------------------------------------------
escribir el numero de partido: 1
escribir el nombre del estadio donde se jugo el partido: j
escribir el nombre del primer pais o equipo que participo: italia
escribir el nombre del segundo pais o equipo que participo: alemania
escribir el numero de partido: 2
escribir el nombre del estadio donde se jugo el partido: san paolo
escribir el nombre del primer pais o equipo que participo: brazil
escribir el nombre del segundo pais o equipo que participo: inglaterra
escribir el numero de partido: 3
escribir el nombre del estadio donde se jugo el partido: d
escribir el nombre del primer pais o equipo que participo: francia
escribir el nombre del segundo pais o equipo que participo: portugal}
