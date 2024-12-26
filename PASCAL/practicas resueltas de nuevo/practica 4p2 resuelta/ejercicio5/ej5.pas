program ej5;
const
	dimF=4;
type
	rango='A'..'F';
	rango2=1..2400;
	fecha=record
		dia:integer;
		mes:integer;
		anio:integer;
	end;
	cliente=record
		fechaFirma:fecha;
		categoria:rango;
		codCiudad:rango2;
		montoMensual:integer;
	end;
	vector=array[1..dimF]of cliente;
	vCAnio=array[1..10]of integer;
	vCMes=array[1..12]of integer;
	vCMono=array[rango]of integer;
	vCCiu=array[rango2]of integer;
procedure cargarVcAnio (var vC:vCAnio);
var
	i:integer;
begin	
	for i:=1 to 10 do
		vC[i]:=0;
end;
procedure cargarVcMes (var vC:vCMes);
var
	i:integer;
begin	
	for i:=1 to 12 do
		vC[i]:=0;
end;
procedure cargarVcMono (var vC:vCMono);
var
	i:rango;
begin
	for i:='A' to 'B' do
		vC[i]:=0;
end;
procedure cargarVcCiudad (var vC:vCCiu);
var
	i:integer;
begin	
	for i:=1 to 2400 do
		vC[i]:=0;
end;
procedure cargarFecha (var f:fecha);
begin
	write('escribir dia: ');
	readln(f.dia);
	write('escribir mes: ');
	readln(f.mes);
	write('escribir anio: ');
	readln(f.anio);
end;
procedure cargarReg (var c:cliente);
var
	f:fecha;
begin
	write('escribir fecha firma del contrato: ');
	cargarFecha(f);
	write('escribir categoria de monotributo: ');
	readln(c.categoria);
	write('escribir el codigo de la ciudad: ');
	readln(c.codCiudad);
	write('escribir monto mensual del contrato: ');
	readln(c.montoMensual); 
end;
procedure maximo (contratos,anio:integer;var anioMax,contratosMax:integer);
begin
	if(contratos>contratosMax)then begin
		contratosMax:=contratos;
		anioMax:=anio;
	end;
end;
procedure cargarVec (var v:vector);
var
	i:integer;
begin
	for i:=1 to dimF do
		cargarReg(v[i]);
end;

procedure puntoA (v:vector;var vCA:vCAnio;var vCM:vCMes);
var
	i,j,m:integer;
	anioMax,cantContratosMax:integer;
begin
	anioMax:=-1;
	cantContratosMax:=-1;
	for i:=1 to dimF do begin
		vCA[v[i].fechaFirma.anio]:=vCA[v[i].fechaFirma.anio]+1;
		vCM[v[i].fechaFirma.mes]:=vCM[v[i].fechaFirma.mes]+1;
	end;
	for m:=1 to 10 do begin
		maximo(vCA[m],m,anioMax,cantContratosMax);
		writeln('la cantidad de contratos en el anio: ',i,' es de: ',vCA[i]);
	end;
	for j:=1 to 12 do begin
		writeln('la cantidad de contratos en el mes: ',i,' es de: ',vCM[i]);
	end;
	writeln('el anio en que se firmo la mayor cantidad de contratos es: ',anioMax);
end;

procedure puntoB (v:vector;var vCM:vCMono);
var
	i:integer;
	j:rango;
begin
	for i:=1 to dimF do 
		vCM[v[i].categoria]:=vCM[v[i].categoria]+1;
	for j:='A' to 'F' do
		writeln('la cantidad de clientes para la categoria: ',j,'es de: ',vCM[j]);
end;
procedure max (clientes,cod:integer;var codMax,cantCliMax:integer);
begin
	if(clientes>cantCliMax)then begin
		cantCliMax:=clientes;
		codMax:=cod;
	end;
end;
procedure puntoC (v:vector;var vCC:vCCiu);
var
	i,l,m,dim,codMax,cantCliMax:integer;
	j:rango2;
begin
	dim:=2400;
	for i:=1 to dimF do 
		vCC[v[i].codCiudad]:=vCC[v[i].codCiudad]+1;//recorrer vector, encontrar mayor, iinformar e eliminarlo, asi diez veces
	for m:=1 to 10 do begin
		codMax:=-1;
		cantCliMax:=-1;
		for j:=1 to dim do begin
			max(vCC[j],j,codMax,cantCliMax);
		end;
		writeln('el codigo de la ',m,' ciudad con mayor cantidad de clientes es: ',codMax);
		for l:= codMax to (dim-1) do 
			vCC[l]:=vCC[l+1];//eliminamos para no ecnontrar el mayor de nuevo
		dim:=dim-1;
	end;
end;
procedure puntoD (v:vector);
var
	i,j:integer;
	totMonto,cantCli:integer;
	promedio:real;
begin
	totMonto:=0;
	cantCli:=0;
	for i:=1 to dimF do begin
		totMonto:=totMonto+v[i].montoMensual;
	end;
	promedio:=totMonto/dimF;
	for j:=1 to dimF do begin
		if(v[i].montoMensual>promedio)then
			cantCli:=cantCli+1;
	end;
	writeln('la cantidad de clientes que superan mensualmente el monto promedio es de: ',cantCli);
end;
var
	v:vector;
	vCA:vCAnio;
	vCM:vCMes;
	vCMon:vCMono;
	vCC:vCCiu;
begin
	cargarVec(v);
	cargarVcAnio(vCA);
	cargarVcMes(vCM);
	puntoA(v,vCA,vCM);
	cargarVcMono(vCMon);
	puntoB(v,vCMon);
	cargarVcCiudad(vCC);
	puntoD(v);
end.
