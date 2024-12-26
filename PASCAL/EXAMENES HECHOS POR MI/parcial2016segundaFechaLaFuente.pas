program title;
const
	dimf=3;
type
	subrango=1..dimf;
	str=string[30];
	infoProductos=record
		descripcion:str;
		precioUnitario:integer;
	end;
	vProducto=array[subrango]of infoProductos;//SE DISPONE
	infoVentas=record
		codVenta:integer;
		dniComprador:integer;
		codProductoComprado:subrango;
		cantUnidadesProduc:integer;
	end;
	lista=^nodo;
	nodo=record
		dato:infoVentas;
		sig:lista;
	end;
	vContadorVentas=array[subrango]of integer;
//-------------------------------------------------------
//PROCESOS PARA INFORMAR
procedure maximos (vec:vContadorVentas;var max,min:integer;codProduc:integer;descripcion:str;var codProducMin,codProducMax:integer;var descripMin,descripMax:str);
var
	i:integer;
begin
	for i:=1 to dimf do begin
		if(vec[i]>max) then begin
			max:=vec[i];
			codProducMax:=codProduc;
			descripMax:=descripcion;
		end;
		if(vec[i]<min) then begin
			min:=vec[i];
			codProducMin:=codProduc;
			descripMin:=descripcion;
		end;
	end;
end;
function descomponer(dni:integer):boolean;
var
	dig,cantPares:integer;
	cumple:boolean;
begin
	cantPares:=0;
	while(dni<>0)do begin
		dig:=dni mod 10;
		if(dig mod 2=0) then
			cantPares:=cantPares+1;
		dni:=dni div 10;
	end;
	if(cantPares>=3) then
		cumple:=true
	else
		cumple:=false;
	descomponer:=cumple;
end;

//PROCESO PARA RECORRER E INFORMAR TODO
procedure recorrerEInformar (l:lista;v:vProducto;var vec:vContadorVentas);
var
	i:integer;
	montoTotal:integer;
	codProducMax,codProducMin:integer;
	descripMin,descripMax:str;
	min,max:integer;
	cantVentas:integer;
begin
	min:=1000;
	max:=-1;
	codProducMax:=1;
	codProducMin:=1;
	descripMin:='';
	descripMax:='';
	cantVentas:=0;
	while(l<>nil) do begin//SE LEE UNA VENTA POR NODO
		montoTotal:=0;
		for i:=1 to dimf do begin
			if(i=l^.dato.codProductoComprado) then begin
				montoTotal:=l^.dato.cantUnidadesProduc*v[i].precioUnitario;
				vec[l^.dato.codProductoComprado]:=vec[l^.dato.codProductoComprado]+1;
				maximos(vec,max,min,l^.dato.codProductoComprado,v[i].descripcion,codProducMin,codProducMax,descripMin,descripMax);
			end;
		end;
		writeln('esta venta tiene un codigo de venta que es: ',l^.dato.codVenta,' en la cual se vendio un monto total de: ',montoTotal);
		if(descomponer(l^.dato.dniComprador)=true)then
			cantVentas:=cantVentas+1;
		l:=l^.sig;
	end;
	writeln('el codigo y descripcion del producto mas vendido es: ',codProducMax,' y ',descripMax);
	writeln('el codigo y descripcion del producto menos vendido es: ',codProducMin,' y ',descripMin);
	writeln('la cantidad de ventas con dni... es de: ',cantVentas);
end;

//PROCESO PARA CARGAR VECTOR QUE SE DISPONE
procedure leerInfoProductos (var info:infoProductos);
begin
	write('escribir la descripcion del producto: ');
	readln(info.descripcion);
	write('escribir el precio unitario del producto: ');
	readln(info.precioUnitario);
	writeln('----------------------------------');
end;
procedure cargarVectorConInfoProducto(var v:vProducto);
var
	i:integer;
	info:infoProductos;
begin
	for i:=1 to dimf do begin
		writeln('escribir la info del producto en la posicion: ',i);
		leerInfoProductos(info);
		v[i]:=info;
	end;
end;
procedure aumentar15% (var precioUnitario:integer; var descrip:str);
var
	i:integer;
begin
	for i:=1 to dimf do begin
		porcentaje:=15*precioUnitario/1;
		v[i].precioUnitario:=v[i].precioUnitario+porcentaje;
		if(descrip='')then
			v[i].descrip:='no existe'
		else
			v[i].descrip:=descrip;
end;

//PROCESO PARA CARGAR VECTOR CONTADOR
procedure cargarVectorEn0 (var vec:vContadorVentas);
var
	i:integer;
begin
	for i:=1 to dimf do 
		vec[i]:=0;
end;

//PROCESO PARA CARGAR LISTA
procedure leerInfoVenta (var i:infoVentas);
begin
	write('escribir el codigo de venta: ');
	readln(i.codVenta);
	write('escribir el dni del comprador: ');
	readln(i.dniComprador);
	write('escribir el codigo del producto comprado: ');
	readln(i.codProductoComprado);
	write('escribir la cantidad de unidades del producto adquiridas: '); 
	readln(i.cantUnidadesProduc);
	writeln('----------------------------------------------------------------');
end;
procedure agregarAdelante (var l:lista;i:infoVentas);
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
	i:infoVentas;
begin
	repeat
		leerInfoVenta(i);
		agregarAdelante(l,i);
	until(i.codVenta=2121);
end;


//PROGRAMA PRINCIPAL
var
	l:lista;
	v:vProducto;
	vec:vContadorVentas;
begin
	l:=nil;
	cargarLista(l);
	cargarVectorConInfoProducto(v);
	cargarVectorEn0(vec);
	recorrerEInformar(l,v,vec);
end.
