
with ada.text_io, ada.Integer_text_IO, Ada.Text_IO.Text_Streams, Ada.Strings.Fixed;
use ada.text_io, ada.Integer_text_IO, Ada.Strings, Ada.Strings.Fixed;

procedure sumDiv is
procedure foo is
  a : Integer;
begin
  a := (0);
  -- test 
  
  a := a + (1);
  -- test 2 
  
end;

procedure foo2 is
begin
  NULL;
  
end;

procedure foo3 is
begin
  if (1) = (1)
  then
    NULL;
    
  end if;
end;

function sumdiv(n : in Integer) return Integer is
  out0 : Integer;
begin
  -- On désire renvoyer la somme des diviseurs 
  
  out0 := (0);
  -- On déclare un entier qui contiendra la somme 
  
  for i in integer range (1)..n loop
    -- La boucle : i est le diviseur potentiel
    
    if (n rem i) = (0)
    then
      -- Si i divise 
      
      out0 := out0 + i;
      -- On incrémente 
      
    else
      NULL;
      
    end if;
  end loop;
  return out0;
  --On renvoie out
  
end;


  n : Integer;
begin
  -- Programme principal 
  
  n := (0);
  Get(n);
  -- Lecture de l'entier 
  
  String'Write (Text_Streams.Stream (Current_Output), Trim(Integer'Image(sumdiv(n)), Left));
end;
