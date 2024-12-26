program ej14;
const
	dimF=1000;
type
	rango=1..1000;
	rango2=1..5;
	participantes=record
		pais:string;
		codProyec:integer;
		nombreProy:string;
		rol:rango2;
		cantHsTrab:integer;
	end;
	desarrolladores=record
		codigo:integer;
		rol:string;
		valorXHs:integer;
	end;
	vector2=array[rango2]of desarrolladores;
	vector=array[rango]of participantes;
	vecCont=array[rango] of integer;
procedure cargarVecDos (var v2:vector2);
begin
	v2[1].codigo:=1;
	v2[1].rol:='analista funcional';
	v2[1].valorXHs:=35;
	v2[2].codigo:=2;
	v2[2].rol:='prgramador';
	v2[2].valorXHs:=27;
	v2[3].codigo:=3;
	v2[3].rol:='administrador de bases de datos';
	v2[3].valorXHs:=31;
	v2[4].codigo:=4;
	v2[4].rol:='arquitecto de software';
	v2[4].valorXHs:=44;
	v2[5].codigo:=5;
	v2[5].rol:='administracion de redes y seguridad';
	v2[5].valorXHs:=39;
end;
procedure cargarReg (var p:participantes);
begin
	write('escribir el cod del proyecto: ');
	readln(p.codProyec);
	if(p.codProyec <> -1) then begin
		write('escribir pais del participante: ');
		readln(p.pais);
		write('escribir el nombre del proyecto: ');
		readln(p.nombreProy);
		write('escribir el rol en el proyecto: ');
		readln(p.rol);
		write('escribir la cant de hs trabajadas: ');
		readln(p.cantHsTrab);
		writeln('------------------------');
	end;
end;
procedure cargarVec (var v:vector; var dl:integer);
var
	p:participantes;
begin
	cargarReg(p);
	while(dl<dimF)and(p.codProyec<>-1)do begin
		dl:=dl+1;
		v[dl]:=p;
		cargarReg(p);
	end;
end;
procedure minimo (cod,monto:integer;var codMin,montoMin:integer);
begin
	if(monto<montoMin)then begin
		codMin:=cod;
		montoMin:=monto;
	end;
end;
var
	v:vector;
	v2:vector2;
	dl,i:integer;
	montoTot,cantTotHs:integer;
	montoInvertido:integer;
	codMin,montoMin:integer;
	vC:vecCont;
	j,m:integer;
begin
	for j:=1 to 1000 do begin
		vC[j]:=0;
	end;
	dl:=0;
	cantTotHs:=0;
	cargarVec(v,dl);
	cargarVecDos(v2);
	montoTot:=0;
	codMin:=10000; 
	montoMin:=10000;
	for i:=1 to dl do begin
		montoInvertido:=0;
		montoInvertido:=v2[v[i].rol].valorXHs*v[i].cantHsTrab;
		if(v[i].pais='argentina')then 
			montoTot:=montoTot+montoInvertido;
		if(v[i].rol=3)then
			cantTotHs:=cantTotHs+v[i].cantHsTrab;
		minimo(v[i].codProyec,montoInvertido,codMin,montoMin);
		if(v[i].rol=4)then
			vC[v[i].codProyec]:=vC[v[i].codProyec]+1;
	end;
	writeln('el monto total invertido en desarooladores con residencia en argentina es de: ',montoTot);
	writeln('la cantidad total de horas trabajas por admin de bases de datos es de: ',cantTotHs);
	writeln('el codigo del proyecto con menor monto invertido es: ',codMin);
	for m:=1 to 1000 do 
		writeln('la cantidad de arquitectos de software del proyecto: ',m,' es de: ',vC[m]);
end.
