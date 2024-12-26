program ej8;
const
	dimF=4;
type
	alumnos=record
		nro:integer;
		dni:integer;
		apellido:string;
		nombre:string;
		anioNaci:integer;
	end;
	vecAlum=array[1..dimF] of alumnos;
procedure leerReg (var alumno:alumnos);
begin
	write('escribir num de inscripcion: ');
	readln(alumno.nro);
	write('escribir num de dni: ');
	readln(alumno.dni);
	write('escribir apellido: ');
	readln(alumno.apellido);
	write('escribir nombre: ');
	readln(alumno.nombre);
	write('escribir anioNaci: ');
	readln(alumno.anioNaci);
end;

procedure cargarVec (var v:vecAlum);
var
	i:integer;
	al:alumnos;
begin
	for i:=1 to dimF do begin
		leerReg(al);
		v[i]:=al;
	end;
end;

function soloPares(dni:integer):boolean;
var
	dig:integer;
	cumple:boolean;
begin	
	cumple:=true;
	while(dni<>0)and(cumple=true)do begin
		dig:=dni mod 10;
		if(dig mod 2<>0)then
			cumple:=false;
		dni:=dni div 10;
	end;
	soloPares:=cumple;
end;

procedure porcentaje (v:vecAlum);
var
	i,cantPares:integer;
	porcentaje:real;
begin
	cantPares:=0;
	for i:=1 to dimF do begin
		if (soloPares(v[i].dni))then 
			cantPares:=cantPares+1;
	end;
	porcentaje:=cantPares/dimF*100;
	writeln('el porcentaje de alumnos con DNI compuesto solo por digitos pares es: ',porcentaje,'%'); 
end;

procedure mayorEdad (v:vecAlum; var max1,max2:integer; var nombre1,nombre2,apellido1,apellido2:string);
var
	i,edad:integer;
begin
	for i:=1 to dimF do begin
		edad:=2024-v[i].anioNaci;
		if(edad>max1)then begin
			max2:=max1;
			nombre2:=nombre1;
			apellido2:=apellido1;
			max1:=edad;
			nombre1:=v[i].nombre;
			apellido1:=v[i].apellido;
		end
		else
			if(edad>max2)then begin
				max2:=edad;
				nombre2:=v[i].nombre;
				apellido2:=v[i].apellido;
			end;
	end;
end;
var
	vec:vecAlum;
	max1,max2:integer;
	nombre1,nombre2,apellido1,apellido2:string;
begin
	cargarVec(vec);
	porcentaje(vec);
	max1:=-1;
	max2:=-1;
	nombre1:=' ';
	nombre2:=' ';
	apellido1:=' ';
	apellido2:=' ';
	mayorEdad(vec,max1,max2,nombre1,nombre2,apellido1,apellido2);
	writeln('el nombre y apellido del alumno con mayor edad es: ',nombre1, ' ',apellido1,' y el nombre y apellido del segundo alumno con mayor edad es: ',nombre2,' ',apellido2);
end. 
