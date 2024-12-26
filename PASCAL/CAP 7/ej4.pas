{Una maternidad dispone información sobre sus pacientes. De cada una se conoce: nombre, apellido y peso registrado el primer día de cada semana de embarazo (a lo sumo 42)(neceistas un vector que adentro tenga integer q va a ser el peso del nene, cada elemento del vector es una semana). 
La maternidad necesita un programa que analice esta información, determine e informe:
a. Para cada embarazada, la semana con mayor aumento de peso.
b. El aumento de peso total de cada embarazada durante el embarazo.}
//dice se dispone de la lista, x lo cual dispone del vector ya que esta dentro de la lsita, pero yo lo voy a hacer para ver como imprime
program title4;
const
	dimf=42;
type
	vector=array[1..dimf]of integer;
	str=string[20];
	pacientes=record
		nombre:str;
		apellido:str;
		semana:vector;
		cantSemana:integer;
	end;
	lista=^nodo;
	nodo=record
		dato:pacientes;
		sig:lista;
	end;

procedure semMayor (v:vector;diml:integer;nombre:str);
var
	i:integer;max,maxSem:integer;
begin
	max:=-1;
	maxSem:=0;
	for i:= 1 to diml do begin
		if(v[i]>max) then begin
			max:=v[i];
			maxSem:=i;
		end;
	end;{de esta amnera estaria comparando pesos entre las semanas y la semana q tenga mayor numero se guardaria en maxsem, pero no tengo que hacer eso, tengo que comparar los aumentos de peso, si en una semana subio 10 kilos y esa fue la semana de amyor aumento, esa debe ser max semana}
	writeln('la semana con mayor aumento de peso de la embarazada con el nombre: ',nombre,' es: ',maxSem);
end;

procedure agregarPesoEnVector (var v:vector;var diml:integer);
var
	peso:integer;
begin	
	diml:=1;
	writeln('escribir el peso de la semana: ',diml);
	readln(peso);
	while(diml<dimf) and (peso<>0) do begin
		v[diml]:=peso;
		diml:=diml+1;
		writeln('escribir el peso de la semana: ',diml);
		readln(peso);
	end;
end;

{procedure cargarVectorEnCero (var v:vector;diml:integer);
var
	i:integer;
begin 
	for i:= 1 to diml do begin
		v[i]:=0;
	end;
end;}

procedure leerRegistro (var p:pacientes);
begin
	writeln('escribir el nombre del paciente: ');
	readln(p.nombre);
	if(p.nombre<>'patricia') then begin
		writeln('escribir el apellido del paciente: ');
		readln(p.apellido);
		writeln('escribir el peso registrado el primer dia de cada semana');
		agregarPesoEnVector(p.semana,p.cantSemana);
	end;
	writeln('----------------------------');
end;
	
procedure agregarAdelante (var l:lista;p:pacientes);
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
	p:pacientes;
begin
	leerRegistro(p);
	while(p.nombre<>'patricia') do begin
		agregarAdelante(l,p);
		leerRegistro(p);
	end;
end;
var
	l:lista;
begin
	l:=nil;
	cargarLista(l);
	while(l<>nil) do begin
		semMayor(l^.dato.semana,l^.dato.cantSemana,l^.dato.nombre);
		l:=l^.sig;
	end;
end.
