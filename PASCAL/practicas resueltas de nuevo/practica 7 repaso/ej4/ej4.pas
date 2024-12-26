program ej4;
const
	dimF=4;
type
	vector=array[1..dimF]of integer;
	paciente=record
		nombre:string;
		semanasPeso:vector;
	end;
	lista=^nodo;
	nodo=record
		dato:paciente;
		sig:lista;
	end;
	//la semana con mayor aumento d peso se refiera a la diferencia entre una semana y otra?
procedure cargarVec (var v:vector);//dice a lo sumo, seria con dimL pero alta paja
var
	i:integer;
	peso:integer;
begin
	for i:=1 to dimF do begin
		write('escribir peso semana: ',i);
		readln(peso);
		v[i]:=peso;
	end;
end;
procedure leerPaciente (var p:paciente);
begin
	write('escribir nombre paciente: ');
	readln(p.nombre);
	write('escribir pesos en todas las semanas');
	cargarVec(p.semanasPeso);
end;
procedure agregarAdelante (var l:lista;p:paciente);
var
	nue:lista;
begin
	new(nue);
	nue^.dato:=p;
	nue^.sig:=l;
	l:=nue;
end;
procedure cargarLista (var l:lista);
var
	p:paciente;
begin
	leerPaciente(p);
	while(p.nombre<>'0')do begin
		agregarAdelante(l,p);
		leerPaciente(p);
	end;
end;
procedure maximo (diferencia,semana:integer;var semanaMax,pesoMax:integer);
begin
	if(diferencia>pesoMax)then begin
		pesoMax:=diferencia;
		semanaMax:=semana;
	end;
end;
var
	l:lista;
	ant,act,pesoTot:integer;
	semanaMax,pesoMax,diferencia:integer;
begin
	l:=nil;
	cargarLista(l);
	while(l<>nil)do begin
		pesoTot:=0;
		diferencia:=0;
		ant:=0;
		act:=1;
		semanaMax:=-1;
		pesoMax:=-1;
		while((act)<dimF)do begin
			act:=act+1;
			ant:=ant+1;
			diferencia:=l^.dato.semanasPeso[act]-l^.dato.semanasPeso[ant];
			if(diferencia>0)then
				maximo(diferencia,ant,semanaMax,pesoMax);
		end;
		writeln('la semana con mayor aumento de peso fue: ',semanaMax,'  con: ',pesoMax,' kilos');
		pesoTot:=l^.dato.semanasPeso[4]-l^.dato.semanasPeso[1];
		writeln('el aumento de peso total de la emabazada es de: ',pesoTot);
		l:=l^.sig;
	end;
end.
