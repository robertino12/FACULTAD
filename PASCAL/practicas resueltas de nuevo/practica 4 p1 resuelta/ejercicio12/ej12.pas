program ej12;
const
	dimF=6;
type
	infoGalaxia=record
		nombre:string;
		tipo:integer;
		masa:integer;
		distancia:integer;
	end;
	vector=array[1..dimF]of infoGalaxia;
	vecCont=array[1..4] of integer;
procedure cargarReg (var i:infoGalaxia);
begin
	write('escribir nombre galaxia: ');
	readln(i.nombre);
	write('escribir tipo: ');
	readln(i.tipo);
	write('escribir masa: ');
	readln(i.masa);
	write('escribir distancia: ');
	readln(i.distancia);
end;
procedure cantGalax (vC:vecCont);
var
	i:integer;
begin
	for i:=1 to 4 do 
		writeln('la cantidad de galaxias del tipo: ',i,' es de: ',vC[i]);
end;
function cumpleC (galaxias:integer;masa:integer):boolean;
begin
	cumpleC:=(galaxias<>4)and(masa<1000);
end;

procedure maximo (masa:integer;nombre:string;var maxMasa1,maxMasa2:integer; var maxNombre1,maxNombre2:string);
begin
	if(masa>maxMasa1)then begin
		maxMasa2:=maxMasa1;
		maxNombre2:=maxNombre1;
		maxMasa1:=masa;
		maxNombre1:=nombre;
	end
	else
		if(masa>maxMasa2)then begin
			maxMasa2:=masa;
			maxNombre2:=nombre;
		end;
end;

procedure minimo (masa:integer;nombre:string;var minMasa1,minMasa2:integer; var minNombre1,minNombre2:string);
begin
	if(masa<minMasa1)then begin
		minMasa2:=minMasa1;
		minNombre2:=minNombre1;
		minMasa1:=masa;
		minNombre1:=nombre;
	end
	else
		if(masa<minMasa2)then begin
			minMasa2:=masa;
			minNombre2:=nombre;
		end;
end;


var
	v:vector;
	i,j:integer;
	cantGalaxias:integer;
	vC:vecCont;
	masaTotAcu,masaTot:integer;
	porcentaje:real;
	maxMasa1,maxMasa2,minMasa1,minMasa2:integer;
	maxNombre1,maxNombre2,minNombre1,minNombre2:string;
begin
	maxMasa1:=-1;
	maxMasa2:=-1;
	maxNombre1:=' ';
	maxNombre2:=' ';
	minMasa1:=10000;
	minMasa2:=10000;
	minNombre1:=' ';
	minNombre2:=' ';
	masaTotAcu:=0;
	masaTot:=0;
	cantGalaxias:=0;
	for j:=1 to 4 do
		vC[j]:=0;
	for i:=1 to dimF do begin
		cargarReg(v[i]);
		writeln('-----------------');
		vC[v[i].tipo]:=vC[v[i].tipo]+1;
		if(v[i].nombre='la via lactea')or(v[i].nombre='andromeda')or(v[i].nombre='triangulo')then
			masaTotAcu:=masaTotAcu+v[i].masa;
		masaTot:=masaTot+v[i].masa;
		if(cumpleC(v[i].tipo,v[i].masa))then
			cantGalaxias:=cantGalaxias+1;
		maximo(v[i].masa,v[i].nombre,maxMasa1,maxMasa2,maxNombre1,maxNombre2);
		minimo(v[i].masa,v[i].nombre,minMasa1,minMasa2,minNombre1,minNombre2);
	end;
	porcentaje:=(masaTotAcu*100)div masaTot;
	cantGalax(vC);
	writeln('la masa total acumulada entre las 3 galaxias es de: ',masaTotAcu,' y el porcentaje con respecto a la masa de todas las demas es de: ',porcentaje:1:2);
	writeln('la cantidad de galaxias no irregulares que se encuentran a menos de 1000 pc son: ',cantGalaxias);
	writeln('la galacia con mayor masa es: ',maxNombre1,' y la segunda con mas es: ',maxNombre2);
	writeln('la galacia con menor masa es: ',minNombre1,' y la segunda con menos es: ',minNombre2);
end. 
