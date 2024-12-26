program title;
const
	dimf=3;					//ANDA BIEN
type
	str=string[30];
	subrango=1..dimf;
	infoCategoria=record
		nombre:str;
		cod:subrango;
		precioXKgProduc:integer;
	end;
	vCategoria=array[subrango] of infoCategoria;
	compra=record
		dniCliente:integer;
		categoriaProduc:subrango;
		cantKilosComprados:integer;
	end;
	lista=^nodo;//SE DISPONE DE LA LISTA PERO LA VOY A CARGAR IGUAL
	nodo=record
		dato:compra;
		sig:lista;
	end;
	vMontoCatego=array[subrango]of integer;
//------------------------------------------------------------------------------------
//PROCESOS PARA INFORMAR
procedure maximo (dni:integer;var dniMax:integer;cantCompras:integer;var max:integer);
begin
	if(cantCompras>max) then begin
		max:=cantCompras;
		dniMax:=dni;
	end;
end;
function esDNI3Pares(dni:integer):boolean;
var
	dig:integer;
	cantPares:integer;
	aux:boolean;
begin
	cantPares:=0;
	while(dni<>0)do begin
		dig:=dni mod 10;
		if(dig mod 2=0) then
			cantPares:=cantPares+1;
		dni:=dni div 10;
	end;
	if (cantPares>=3) then
		aux:=true
	else
		aux:=false;
	esDNI3Pares:=aux;
end;
//RECORRER LISTA E INFORMAR TODO
procedure recorrerEInformar (l:lista;vec:vCategoria;var v:vMontoCatego);
var
	dniActual:integer;
	cantCompras:integer;
	max:integer;
	dniMax:integer;	
	i:integer;
	cantTotalCompras:integer;
begin
	max:=-1;
	dniMax:=0;
	cantTotalCompras:=0;
	while(l<>nil) do begin
		cantCompras:=0;
		dniActual:=l^.dato.dniCliente;
		while(l<>nil) and (l^.dato.dniCliente=dniActual) do begin
			cantCompras:=cantCompras+1;
{incisoB2}	v[l^.dato.categoriaProduc]:=v[l^.dato.categoriaProduc]+l^.dato.cantKilosComprados*vec[l^.dato.categoriaProduc].precioXKgProduc;
			if(esDNI3Pares(l^.dato.dniCliente)=true)then
				cantTotalCompras:=cantTotalCompras+1;
			l:=l^.sig;
		end;
		maximo(dniActual,dniMax,cantCompras,max);{incisoB1}
	end;
	writeln('el dni del cliente que mas compras ha realizado es: ',dniMax);{incisoB1}
	for i:=1 to dimf do 
		writeln('el monto total recaudado de la categoria: ',i,' es de: ',v[i]);{incisoB2}
	writeln('la cantidad total de compras de clientes con DNI compuesto por al menos 3 digitos pares es de: ',cantTotalCompras);
end;

//CARGAR VECTORES Y LECTURA REGISTRO DEL VECTOR
procedure leerInfoCategoria (var info:infoCategoria);
begin
	write('escribir el nombre del producto: ');
	readln(info.nombre);
	write('escribir el codigo del producto: ');
	readln(info.cod);
	write('escribir el precio por kilo del producto: ');
	readln(info.precioXKgProduc);
	writeln('--------------------------------------------');
end;
procedure inicializarVectorEn0 (var v:vMontoCatego);
var
	i:integer;
begin
	for i:=1 to dimf do 
		v[i]:=0;
end;
procedure cargarVectorConInfoCategoria (var vec:vCategoria);
var
	i:integer;
	info:infoCategoria;
begin
	for i:=1 to dimf do begin
		writeln('la informacion de la categoria',i,' es la siguiente: ');
		leerInfoCategoria(info);
		vec[i]:=info;
	end;
end;


//PROCESOS PARA CARGAR LISTA QUE SE DISPONE
procedure leerInfoCompra(var c:compra);
begin
	write('escribir el dni del cliente: ');
	readln(c.dniCliente);
	if(c.dniCliente<>-1) then begin
		write('escribir la categoria del producto: ');
		readln(c.categoriaProduc);
		write('escribir la cantidad de kilos comprados: ');
		readln(c.cantKilosComprados);
	end;
	writeln('-------------------------');
end;
procedure agregarAdelante (var l:lista;c:compra);
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
	c:compra;
begin
	leerInfoCompra(c);
	while(c.dniCliente<>-1)do begin	
		agregarAdelante(l,c);
		leerInfoCompra(c);
	end;
end;


//PORGRAMA PRINCIPAL
var
	l:lista;
	vec:vCategoria;
	v:vMontoCatego;
begin
	l:=nil;
	cargarLista(l);//SE DISPONE
	inicializarVectorEn0(v);
	cargarVectorConInfoCategoria(vec);
	recorrerEinformar(l,vec,v);
end.
