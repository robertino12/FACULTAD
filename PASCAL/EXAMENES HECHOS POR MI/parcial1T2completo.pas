{Una panadería del centro La Plata vende productos de elaboración propia. La panadería agrupa sus
productos en 20 categorías (1. Pan; 2. Medialunas dulces; 3. Medialunas saladas; ...). De cada
categoría se conoce nombre y precio por kilo del producto.La panaderia dispone de la infomacion de las categorias.
a) Realizar un módulo que retorne, en una estructura de datos adecuada, la informacion de todas las compras efectuadas en el ultimo año. 
Dicha informacion se lee desde teclado, ordenada por DNI del cliente. De cada compra se lee:
dni del cliente, categoria del producto(entre 1 y 20) y cantidad de kilos compardos.
La lectura finaliza cuando se ingresa el dni -1(que no debe procesarse).
b) Realizar un módulo que reciba la información de las categorias y la de todas las compras, y retorne:
	1. DNI del cliente que menos dinero ha gastado. LO QUE NO ENTIENDO ES COMO SE HACE XQ NO SE SI MENOS DINERO ES RELACIONANDONOS CON LAS CANT D COMPRAS Q HIZO UN CLIENTE O DE OTRA FORMA, XQ PODES TENER 40 COMPRAS DE LOS PRODUCTOS MAS BARATOS Y OTRO PUEDE TENER 20 COMPRAS DE LOS PRODUCTOS MAS CAROS Y HABER GASTADO MAS PLATA. AHI LO SUPE SACAR GRACIAS A ESCRIBIRLO
	2. cantidad de compras por categoria.
	3.cantidad total de compras de clientes con DNI compuesto por, a lo sumo, 5 digitos impares.
NOTA: Implementar el programa principal.}
program title;//ANDA BIEN
const
	dimf=3;
type
	str=string[30];
	subrango=1..dimf;
	infoCategoria=record
		nombre:str;
		precioPorKiloProduc:integer;
	end;
	vCategoria=array[subrango]of infoCategoria;//DE ESTE VECTOR SE DIPONE
	infoCompras=record
		dniCliente:integer;
		categoriaProduc:subrango;
		cantKilosComprados:integer;
	end;
	lista=^nodo;
	nodo=record
		dato:infoCompras;
		sig:lista;
	end;
	vCatProduc=array[subrango]of integer;//ESTE VECTOR ES PARA LA VAR 'CATEGORIA PRODUC'
//------------------------------------------------------------------------------------------------------------------------------------------------------------
//PROCESOS PARA INFORMAR
procedure minimo (dni:integer;dineroGastado:integer;var min:integer;var dniMin:integer);
begin
	if(dineroGastado<min) then begin
		min:=dineroGastado;
		dniMin:=dni;
	end;
end;
function descomponerDNI (dni:integer):boolean;
var
	dig,cantImpares:integer;
begin
	cantImpares:=0;
	while(dni<>0) do begin
		dig:=dni mod 10;
		if(dig mod 2=1)then
			cantImpares:=cantImpares+1;
		dni:=dni div 10;
	end;
	descomponerDNI:=(cantImpares<=5);
end;
//PROCESO PARA RECORRER LISTA E INFORMAR TODO
procedure recorrerListaEInformar (l:lista;var v:vCatProduc;vec:vCategoria);
var
	cantComprasTotales:integer;
	dniActual:integer;
	dineroGastado:integer;
	min:integer;
	dniMin:integer;
	i:integer;
begin
	min:=10000;
	dniMin:=10;
	cantComprasTotales:=0;
	while(l<>nil) do begin
		dineroGastado:=0;
		dniActual:=l^.dato.dniCliente;
		while(l<>nil) and (l^.dato.dniCliente=dniActual)do begin
			dineroGastado:=l^.dato.cantKilosComprados*vec[l^.dato.categoriaProduc].precioPorKiloProduc;//PARA SACAR EL DINER GASTADO DE UN CLIENTE TENES QUE MULTIPLICAR LA CANTIDAD DE KILOS POR EL PRECIO POR KILO DE LA CATEGORIA Q ESTAS LEYENDO
			v[l^.dato.categoriaProduc]:=v[l^.dato.categoriaProduc]+1;
			if(descomponerDNI(l^.dato.dniCliente))then
				cantComprasTotales:=cantComprasTotales+1;
			l:=l^.sig;
		end;
		minimo(dniActual,dineroGastado,min,dniMin);//dni actual para q salga el dni q estaba contando dentro del while mas chiquito, si pongo l^.dato.dniCliente seria otro dni ya q se fue del while x no ser igual a dniActual
	end;
	writeln('el dni del cliente que menos dinero ha gastado es: ',dniMin);
	for i:=1 to dimf do 
		writeln('la cantidad de compras de la categoria: ',i,' es de: ',v[i]);
	writeln('la cantidad total de compras de clientes con dni a lo sumo 5 digitos impares: ',cantComprasTotales);
end;

//PROCESOS PARA CARGAR EL VECTOR QUE DISPONER PERO LO HAGO PARA PROBAR SI ANDA
procedure leerInfoCategoria( var info:infoCategoria);
begin
	write('escribir el nombre del producto: ');
	readln(info.nombre);
	write('escribir el precio por kilo del producto: ');
	readln(info.precioPorKiloProduc);
end;
procedure cargarVectorInfoCat (var vec:vCategoria);
var
	i:integer;
	info:infoCategoria;
begin
	for i:=1 to dimf do begin
		leerInfoCategoria(info);
		vec[i]:=info;
	end;
end;


//PORCESOS PARA CARGAR
procedure inicializarVectorEn0 (var v:vCatProduc);
var
	i:integer;
begin
	for i:=1 to dimf do begin
		v[i]:=0;
	end;
end;
procedure leerInfoCompras (var i:infoCompras);
begin
	write('escribir el dni del cliente: ');
	readln(i.dniCliente);
	if(i.dniCliente<>-1)then begin
		write('escribir la categoria del producto: ');
		readln(i.categoriaProduc);
		write('escribir la cantidad de kilos comprados: ');
		readln(i.cantKilosComprados);
	end;
	writeln('------------------------------------------');
end;
procedure agregarAdelante (var l:lista;i:infoCompras);
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
	i:infoCompras;
begin
	leerInfoCompras(i);
	while(i.dniCliente<>-1)do begin
		agregarAdelante(l,i);
		leerInfoCompras(i);
	end;
end;
var
	l:lista;
	v:vCatProduc;
	vec:vCategoria;
begin
	l:=nil;
	cargarLista(l);
	cargarVectorInfoCat(vec);
	inicializarVectorEn0(v);
	recorrerListaEInformar(l,v,vec);
end.
