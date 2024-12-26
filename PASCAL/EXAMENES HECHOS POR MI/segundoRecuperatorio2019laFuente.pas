program title;
const
	dimf1=3;
	dimf2=7;
type
	subrango=1..dimf2;
	rangoCodLibro=1..dimf1;
	str=string[30];
	//VECTOR
	infoLibro=record
		codLibro:rangoCodLibro;
		codMateria:subrango;
		titulo:str;
		anioEdicion:integer;
	end;
	vLibro=array[rangoCodLibro]of infoLibro;
	//VECTOR ACUMULADOR
	vCantMaterias=array[subrango]of integer;
	//LISTA QUE SE DISPONE
	infoVenta=record
		dniCliente:integer;
		codLibro:rangoCodLibro;
		anioVenta:integer;
	end;
	lista=^nodo;
	nodo=record
		dato:infoVenta;
		sig:lista;
	end;
//----------------------------------------------------------------------
//PROCESOS PARA INFORMAR


function descomponerDNI (dni:integer):boolean;
var
	dig:integer;
	aux:boolean;
	cumple:boolean;
begin
	aux:=true;
	while(dni<>0) and (aux=true)do begin
		dig:=dni mod 10;
		if(dig mod 2=0) then
			aux:=false
		else
			aux:=true;
		dni:=dni div 10;
	end;
	if(aux=true)then
		cumple:=true;
	descomponerDNI:=cumple;
end;

function fueEditado(codlibro:integer;v:vLibro):boolean;
begin
	fueEditado:=(v[codlibro].anioEdicion>=2011)and(v[codlibro].anioEdicion<=2017);
end;

procedure saberSiVentaYLibroMismoCod (v:vLibro;var vec:vCantMaterias;codigoLibro:rangoCodLibro;dni:integer;anioVenta:integer);
var
	i:integer;
begin
	for i:= 1 to dimf1 do begin
		if(v[i].codLibro=codigoLibro)then begin
			vec[v[i].codMateria]:=vec[v[i].codMateria]+1;
			if(descomponerDNI(dni)=true)and(fueEditado(codigoLibro,v))then
				writeln('el anio de venta del libro con titulo: ',v[i].titulo,' es',anioVenta);
		end;
	end;//LO QUE BUSCO ES QUE ME RECORRA EL VECTOR POR CADA VENTA
end;

procedure max (var max1,max2:integer;var maxMateria1,maxMateria2:integer;vec:vCantMaterias);
var
	i:integer;
begin
	for i:=1 to dimf2 do begin	
		if(vec[i]>max1)then begin
			max2:=max1;
			max1:=vec[i];
			maxMateria2:=maxMateria1;
			maxMateria1:=i;
		end
		else
			if(vec[i]>max2)then begin
				max2:=vec[i];
				maxMateria2:=i;
		end;
	end;
end;

//PROCESO PARA RECORRER LISTA E INFORMAR
procedure recorrerEInformar (l:lista;v:vLibro;var vec:vCantMaterias);
var
	max1,max2:integer;
	maxMateria1,maxMateria2:integer;
begin
	max1:=-1;
	max2:=-1;
	maxMateria1:=0;
	maxMateria2:=0;
	while(l<>nil) do begin//SE LEEN VENTAS DE LIBROS ACA
		saberSiVentaYLibroMismoCod(v,vec,l^.dato.codLibro,l^.dato.dniCliente,l^.dato.anioVenta);
		max(max1,max2,maxMateria1,maxMateria2,vec);
		{if(v[l^.dato.codLibro].codMateria=1)then
			vec[1]:=vec[1]+1;}
		{if(descomponerDNI(l^.dato.dniCliente)=true)and(fueEditado(l^.dato.codLibro,v))then
			writeln('el anio de venta del libro con titulo: ',v[l^.dato.codLibro].titulo,' es',l^.dato.anioVenta);}
		l:=l^.sig;
	end;
	writeln('la materia con mayor cantidad de libros vendidos es: ',maxMateria1,' y la segunda materia con mayor cantidad de libros vendidos es: ',maxMateria2);
end;


//CARGAR VECTOR 
procedure leerInfoLibro (var info:infoLibro);
begin
	write('escribir el codigo de libro: ');
	readln(info.codLibro);
	write('escribir el codigo de materia: ');
	readln(info.codMateria);
	write('escribir el titulo del libro: ');
	readln(info.titulo);
	write('escribir el anio de edicion: ');
	readln(info.anioEdicion);
	writeln('---------------------------------------------');
end;
procedure cargarVectorConInfoLibro(var v:vLibro);
var
	i:integer;
	info:infoLibro;
begin
	for i:=1 to dimf1 do begin
		writeln('escribir la informacion del libro: ',i);
		leerInfoLibro(info);
		v[i]:=info;
	end;
end;
procedure cargarVectorEn0 (var vec:vCantMaterias);
var
	i:integer;
begin
	for i:=1 to dimf2 do 
		vec[i]:=0;
end;



//CARGAR LISTA QUE SE DISPONE	
procedure leerInfoVentaLibro (var i:infoVenta);
begin
	write('escribir el dni del cliente: ');
	readln(i.dniCliente);
	if(i.dniCliente<>-1)then begin
		write('escribir el codigo de libro: ');
		readln(i.codLibro);
		write('escribir el anio de la venta: ');
		readln(i.anioVenta);
	end;
	writeln('--------------------------------');
end;
{procedure agregarAtras (var l:lista;i:infoVenta;var ult:lista);
var//NO PIDE QUE SE MUESTRE LA LISTA EN LA FORMA QUE FUE LEIDO PERO LO HAGO PARA PRACTICAR	
	nue:lista;
begin
	new(nue);
	nue^.dato:=i;
	nue^.sig:=nil;
	if(l=nil)then
		l:=nue
	else
		ult^.sig:=nue;
	ult:=nue;
end;}
procedure agregarAdelante (var l:lista;i:infoVenta);
var
	nue:lista;
begin
	new(nue);
	nue^.dato:=i;
	nue^.sig:=l;
	l:=nue;
end;
procedure cargarLista (var l:lista);
var
	i:infoVenta;
	{ult:lista;}
begin
	leerInfoVentaLibro(i);
	while(i.dniCliente<>-1) do begin
		{agregarAtras(l,i,ult);}
		agregarAdelante(l,i);
		leerInfoVentaLibro(i);
	end;
end;


//PROGRAMA PRINCIPAL
var
	l:lista;
	v:vLibro;
	vec:vCantMaterias;
begin
	l:=nil;
	cargarLista(l);
	cargarVectorConInfoLibro(v);
	cargarVectorEn0(vec);
	recorrerEInformar(l,v,vec);
end.
