program ejercicio6p3;
type
  microprocesadores=record
    marca:string;
    linea:string;
    cantcores:integer;
    velocreloj:integer;
    tamanoNMtransis:integer;
	end;
procedure leerMicro(var m:microprocesadores);
begin
  writeln('Ingresar el nombre de la marca');
  readln(m.marca);
  writeln('Ingresar el nombre de la linea');
  readln(m.linea);
  writeln('Ingresar la cantidad de cores');
  readln(m.cantcores);
  if(m.cantcores<>0)then begin
    writeln('Ingresar la velocidad del reloj');
    readln(m.velocreloj);
    writeln('Ingresar el tamaño en nanometros de los transistores');
    readln(m.tamanoNMtransis);
  end;
  writeln('--------------------------------------------------------');
end;
function es2cores(m:microprocesadores):boolean;
begin
  es2cores:= (m.cantcores>=2)and(m.tamanoNMtransis<=22);
end;
function esMascores (m:microprocesadores):boolean;
begin
  esMascores:= (m.cantcores>=2) and ((m.marca='intel') or (m.marca='amd')) and (m.velocreloj>=2);
end;
var
micro:microprocesadores;
marcaActual:string;
cant:integer;
begin
cant:=0;
leerMicro(micro);
while(micro.cantcores<>0) do begin
  marcaActual:=micro.marca;
  while(micro.marca=marcaActual) and (micro.cantcores<>0) do begin
    if(es2cores(micro)) then
      writeln('La marca y linea del procesador de mas de 2 cores con transistores de a lo sumo 22nm es de: ',micro.marca,'',micro.linea);
    if(esMascores(micro)) then
      cant:=cant+1;
    leerMicro(micro);
  end;
end;
writeln('La cantidad de procesadores multicore de intel o AMD, cuyos relojes alcancen velocidades de al menos 2 Ghz son: ',cant);
end.


{procedure dosMaximos(markas:string; transisTam:integer; var markamax1:string; var markamax2:string; var max1,max2:integer; var cantprocTransis:integer;
begin
if(transisTam=14) then 
    cantprocTransis:= cantprocTransis+1;
if(cantproctransis>max1)
maxmarka2:makmarka1;
maxmarka1:=marka
else
if(cantproctransis>max2)
maxmarka2:=marka
  
end;}




