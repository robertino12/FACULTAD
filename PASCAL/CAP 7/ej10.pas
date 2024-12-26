program title;
const
	dimf=20;
type
	str=string[30];
	infoCultivo=record
		tipoCultivo:str;
		cantHect:integer;
		cantMeses:integer;
	end;
	subrango=1..dimf;
	vCultivo=array[subrango]of infoCultivo;
	empresa=record
		codigo:integer;
		nombre:str;
		tipo:str;
		ciudad:str;
		cultivos:vCultivo;
		cantCultivos:integer;
	end;
	lista=^nodo;
	nodo=record
		dato:empresa;
		sig:lista;
	end;
	
	
//PROCESOS PARA INFOMRAR
function descomponer (codigo:integer):boolean;
var
	aux:boolean;
	dig:integer;
	cantCeros:integer;
begin
	cantCeros:=0;
	while(codigo<>0) do begin
		dig:=codigo mod 10;
		if(dig=0) then
			cantCeros:=cantCeros+1;	
		codigo:=codigo div 10;
	end;
	if(cantCeros>=2) then
		aux:=true
	else
		aux:=false;
	descomponer:=aux;
end;
function esTrigo (v:vCultivo;diml:integer):boolean;
var
	aux:boolean;
begin
	aux:=false;
	diml:=1;
	while(diml<dimf)and(aux=false) do begin//RECORRE VECTOR PARA VER SI ALGUN CULTIVO ES TRIGO
		if(v[diml].tipoCultivo='trigo')then//LO HAGO CON WHILE ASI PUEDO PONER CONDICIONES DE PARE CUANDO YA EN ALGUN CULTIVO DEL VECTOR HAYA ALGUNO Q SEA TRIGO, XQ AUX SE VUELVE TRUE Y NO VUELVE A ENTRAR AL WHILE
			aux:=true
		else
			diml:=diml+1;
	end;
	esTrigo:=aux;
end;
procedure esSoja (v:vCultivo;diml:integer;var cantHectSoja:integer);
var
	i:integer;
begin
	for i:=1 to diml do begin//RECORRE VECTOR PARA VER SI ALGUN CULTIVO ES SOJA
		if(v[i].tipoCultivo='soja')then 
			cantHectSoja:=cantHectSoja+v[i].cantHect;
			//PUSE ESTE PARA VER Q VALORES DA Y PONIENDO 10 EN LA PRIMER POSICION D LA PRIMER EMPRESA Y 20 EN LA SEG POSICION, DESP EN LA SIG EMPRESA PONIENDO 10 EN LA PRIMERA POSICION ME TIRA DE VALOR TOTAL 60, AUNQUE A 40 LLEGA PERO DE LA NADA ME SUMA 60
			//AHI LO ARREGLE CAMBIANDO EL CARGAR VECTOR, TENIA QUE INICIALIZAR LA DIML EN 0, TO LA TENIA EN 1 Y UNA VEZ QUE ENTRA AL WHILE LE ASIGANABA EL CONTENIDO AL VECTOR, AHORA LE SUMO UNO A LA DIML CUANDO ENTRA AL WHILE
	end;
end;	
procedure sumarTotalHect (v:vCultivo;diml:integer;var cantHectTotal:integer);
var
	i:integer;
begin
	for i:=1 to diml do begin
		cantHectTotal:=cantHectTotal+v[i].cantHect;
	end;
end;
procedure esMaizYMaximos (v:vCultivo;diml:integer;var max:integer;var nombreMax:str;nombreEmpresa:str);
var
	i:integer;
	cantTiempoMaiz:integer;
begin
	cantTiempoMaiz:=0;
	for i:=1 to diml do begin//RECORRE VECTOR PARA VER SI ALGUN CULTIVO ES MAIZ
		if(v[i].tipoCultivo='maiz')then 
			cantTiempoMaiz:=cantTiempoMaiz+v[i].cantMeses;
	end;
	if(cantTiempoMaiz>max) then begin
		max:=cantTiempoMaiz;
		nombreMax:=nombreEmpresa;
	end;
end;
procedure incrementarGirasol (var v:vCultivo;diml:integer);
var
	i:integer;
begin
	
	for i:=1 to diml do begin
		if((v[i].tipoCultivo='girasol') and (v[i].cantHect<5))then begin
			v[i].cantMeses:=v[i].cantMeses+1;
			writeln(v[i].cantMeses);//LO PONGO PARA VER SI INCREMENTA Y DA BIEN
		end;
	end;
end;

//PROCESOS PARA CARGAR
procedure leerInfoCultivo (var i:infoCultivo);
begin
	write('escribir el tipo de cultivo: ');
	readln(i.tipoCultivo);
	write('escribir la cantidad de hectareas: ');
	readln(i.cantHect);
	if(i.cantHect<>0) then begin
		write('escribir la cantidad de meses que lleva el cilco de cultivo: ');
		readln(i.cantMeses);
	end;
end;
procedure cargarVector (var v:vCultivo; var diml:integer);
var
	i:infoCultivo;
begin
	diml:=0;
	writeln('escribir en la posicion: ',diml+1);
	leerInfoCultivo(i);
	while(diml<dimf) and (i.cantHect<>0) do begin
		diml:=diml+1;
		v[diml]:=i;
		writeln('-------------------------');
		writeln('escribir en la posicion: ',diml+1);
		leerInfoCultivo(i);
	end;
end;
procedure leerEmpresa (var e:empresa);
begin
	write('escribir el codigo de la empresa: ');
	readln(e.codigo);
	if(e.codigo<>-1) then begin
		write('escribir el nombre de la empresa: ');
		readln(e.nombre);
		write('escribir el tipo de empresa: ');
		readln(e.tipo);
		write('escribir la ciudad donde esta redicada: ');
		readln(e.ciudad);
		writeln('escribir la informacion del cultivo');
		cargarVector(e.cultivos,e.cantCultivos);
	end;
	writeln('---------------------');
end;
procedure agregarAdelante (var l:lista; e:empresa);
var
	nue:lista;
begin
	new(nue);
	nue^.dato:=e;
	nue^.sig:=l;
	l:=nue;
end;
procedure cargarLista (var l:lista);
var
	e:empresa;
begin
	leerEmpresa(e);
	while(e.codigo<>-1) do begin
		agregarAdelante(l,e);
		leerEmpresa(e);
	end;
end;


//PORGRAMA PRINCIPAL	
var
	l:lista;
	cantHectSoja:integer;
	cantHectTotal:integer;
	max:integer;
	nombreMax:str;
begin
	max:=-1;
	nombreMax:='';
	cantHectTotal:=0;
	cantHectSoja:=0;
	l:=nil;
	cargarLista(l);
	while(l<>nil) do begin
		if((descomponer(l^.dato.codigo)=true)and(l^.dato.ciudad='san miguel del monte')and(esTrigo(l^.dato.cultivos,l^.dato.cantCultivos)=true)) then
			writeln('el nombre de la empresa que radica en san miguel del monte, cultiva trigo y su codigo posee al menos dos ceros es: ',l^.dato.nombre);
		esSoja(l^.dato.cultivos,l^.dato.cantCultivos,cantHectSoja); 
		sumarTotalHect(l^.dato.cultivos,l^.dato.cantCultivos,cantHectTotal);
		esMaizYMaximos(l^.dato.cultivos,l^.dato.cantCultivos,max,nombreMax,l^.dato.nombre);
		if(l^.dato.tipo='privada') then
			incrementarGirasol(l^.dato.cultivos,l^.dato.cantCultivos);
		l:=l^.sig;
	end;
	writeln('la cantidad de hectareas dedicadas al cultivo de soja es de: ',cantHectSoja);//ME INFORMA PERO NO LO QUE ME DEBERIA DAR. LO ARREGLE ERA QUE PUSE Q LA DIMENSION LOGICA EMPIECE EN 1 CUANDO CARGO EL VECTOR, LO TENGO QUE HACER COMO LO PUSE AHORA
	writeln('el porcentaje que representa la cant de hectareas de soja con respecto a la cant de hectareas totales es: ',((cantHectSoja*100) div cantHectTotal));
	writeln('el nombre de la empresa que dedica mas tiempo al cultivo de maiz es: ',nombreMax);
end. 
