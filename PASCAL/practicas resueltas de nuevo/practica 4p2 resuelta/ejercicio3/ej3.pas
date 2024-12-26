program ej3;
const
	dimF=200;
type
	rango=1..31;
	viaje=record
		dia:rango;
		dineroTransp:integer;
		distRecor:integer;
	end;
	vector=array[1..dimF]of viaje;
	vecCont=array[rango]of integer;
procedure cargarReg (var v:viaje);
begin
	write('escribir dist recorrida: ');
	readln(v.distRecor);
	if(v.distRecor<>0)then begin
		write('escribir dia del viaje: ');
		readln(v.dia);
		write('escribir dinero transp: ');
		readln(v.dineroTransp);
	end;
	writeln('--------------------------');
end;
procedure cargarVec (var v:vector;var dl:integer);
var
	vi:viaje;
begin
	cargarReg(vi);
	while(dl<dimF)and(vi.distRecor<>0)do begin
		dl:=dl+1;
		v[dl]:=vi;
		cargarReg(vi);
	end;
end;
procedure minimo (dia,dist,dinero:integer;var minDist,minDia,minDin:integer);
begin
	if(dinero<minDin)then begin
		minDin:=dinero;
		minDist:=dist;
		minDia:=dia;
	end;
end;
procedure cargarVc (var vC:vecCont);
var
	i:integer;
begin
	for i:=1 to 31 do 
		vC[i]:=0;
end;
procedure incisoB (v:vector;dl:integer;var vC:vecCont);
var
	i,montoTot,m:integer;
	minDist,minDia,minDinero:integer;
begin
	minDist:=10000;
	minDia:=10000;
	montoTot:=0;
	for i:=1 to dl do begin
		montoTot:=montoTot+v[i].dineroTransp;
		minimo(v[i].dia,v[i].distRecor,v[i].dineroTransp,minDist,minDia,minDinero);
		vC[v[i].dia]:=vC[v[i].dia]+1;
	end;
	writeln('el monto promedio transportado de los viajes es: ',montoTot/dl:1:2);
	writeln('la distancia recorrida y el dia del mes del viaje que menos transporto dinero es, dist: ',minDist,' dia: ',minDia);
	for m:=1 to 31 do
		writeln('la cantidad de viajes realizados el dia: ',m,' es de: ',vC[m]);
end;

procedure eliminarViajes (var v:vector;var dl:integer);
var
	i,m:integer;
begin
	i:=1;
	while(i<=dl)do begin
		if(v[i].distRecor=100)then begin
			for m:=i to dl-1 do
				v[m]:=v[m+1];
			dl:=dl-1;
		end
		else
			i:=i+1;
	end;
end;
procedure imprimir(v:vector;dl:integer);
var
	i:integer;
begin
	for i:=1 to dl do
		writeln('la dist recor del viaje: ',i,' es de: ',v[i].distRecor);
end;
var
	v:vector;
	dl:integer;
	vC:vecCont;
begin
	dl:=0;
	cargarVec(v,dl);
	cargarVc(vC);
	incisoB(v,dl,vC);
	imprimir(v,dl);
	eliminarViajes(v,dl);
	imprimir(v,dl);
end. 
