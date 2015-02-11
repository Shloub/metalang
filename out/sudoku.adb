
with ada.text_io, ada.Integer_text_IO, Ada.Text_IO.Text_Streams, Ada.Strings.Fixed;
use ada.text_io, ada.Integer_text_IO, Ada.Strings, Ada.Strings.Fixed;

procedure sudoku is
procedure SkipSpaces is
  C : Character;
  Eol : Boolean;
begin
  loop
    Look_Ahead(C, Eol);
    exit when Eol or C /= ' ';
    Get(C);
  end loop;
end;
-- lit un sudoku sur l'entrée standard 

type a is Array (Integer range <>) of Integer;
type a_PTR is access a;
function read_sudoku return a_PTR is
  out0 : a_PTR;
  k : Integer;
begin
  out0 := new a (0..(9) * (9));
  for i in integer range (0)..(9) * (9) - (1) loop
    Get(k);
    SkipSpaces;
    out0(i) := k;
  end loop;
  return out0;
end;

-- affiche un sudoku 

procedure print_sudoku(sudoku0 : in a_PTR) is
begin
  for y in integer range (0)..(8) loop
    for x in integer range (0)..(8) loop
      String'Write (Text_Streams.Stream (Current_Output), Trim(Integer'Image(sudoku0(x +
      y * (9))), Left));
      String'Write (Text_Streams.Stream (Current_Output), " ");
      if (x rem (3)) = (2)
      then
        String'Write (Text_Streams.Stream (Current_Output), " ");
      end if;
    end loop;
    String'Write (Text_Streams.Stream (Current_Output), "" & Character'Val(10) & "");
    if (y rem (3)) = (2)
    then
      String'Write (Text_Streams.Stream (Current_Output), "" & Character'Val(10) & "");
    end if;
  end loop;
  String'Write (Text_Streams.Stream (Current_Output), "" & Character'Val(10) & "");
end;

-- dit si les variables sont toutes différentes 

-- dit si les variables sont toutes différentes 

-- dit si le sudoku est terminé de remplir 

function sudoku_done(s : in a_PTR) return Boolean is
begin
  for i in integer range (0)..(80) loop
    if s(i) = (0)
    then
      return FALSE;
    end if;
  end loop;
  return TRUE;
end;

-- dit si il y a une erreur dans le sudoku 

-- résout le sudoku

function solve(sudoku0 : in a_PTR) return Boolean is
begin
  if FALSE or else
  (sudoku0((0)) /= (0) and then sudoku0((0)) = sudoku0((9))) or else
  (sudoku0((0)) /= (0) and then sudoku0((0)) = sudoku0((18))) or else
  (sudoku0((9)) /= (0) and then sudoku0((9)) = sudoku0((18))) or else
  (sudoku0((0)) /= (0) and then sudoku0((0)) = sudoku0((27))) or else
  (sudoku0((9)) /= (0) and then sudoku0((9)) = sudoku0((27))) or else
  (sudoku0((18)) /= (0) and then sudoku0((18)) = sudoku0((27))) or else
  (sudoku0((0)) /= (0) and then sudoku0((0)) = sudoku0((36))) or else
  (sudoku0((9)) /= (0) and then sudoku0((9)) = sudoku0((36))) or else
  (sudoku0((18)) /= (0) and then sudoku0((18)) = sudoku0((36))) or else
  (sudoku0((27)) /= (0) and then sudoku0((27)) = sudoku0((36))) or else
  (sudoku0((0)) /= (0) and then sudoku0((0)) = sudoku0((45))) or else
  (sudoku0((9)) /= (0) and then sudoku0((9)) = sudoku0((45))) or else
  (sudoku0((18)) /= (0) and then sudoku0((18)) = sudoku0((45))) or else
  (sudoku0((27)) /= (0) and then sudoku0((27)) = sudoku0((45))) or else
  (sudoku0((36)) /= (0) and then sudoku0((36)) = sudoku0((45))) or else
  (sudoku0((0)) /= (0) and then sudoku0((0)) = sudoku0((54))) or else
  (sudoku0((9)) /= (0) and then sudoku0((9)) = sudoku0((54))) or else
  (sudoku0((18)) /= (0) and then sudoku0((18)) = sudoku0((54))) or else
  (sudoku0((27)) /= (0) and then sudoku0((27)) = sudoku0((54))) or else
  (sudoku0((36)) /= (0) and then sudoku0((36)) = sudoku0((54))) or else
  (sudoku0((45)) /= (0) and then sudoku0((45)) = sudoku0((54))) or else
  (sudoku0((0)) /= (0) and then sudoku0((0)) = sudoku0((63))) or else
  (sudoku0((9)) /= (0) and then sudoku0((9)) = sudoku0((63))) or else
  (sudoku0((18)) /= (0) and then sudoku0((18)) = sudoku0((63))) or else
  (sudoku0((27)) /= (0) and then sudoku0((27)) = sudoku0((63))) or else
  (sudoku0((36)) /= (0) and then sudoku0((36)) = sudoku0((63))) or else
  (sudoku0((45)) /= (0) and then sudoku0((45)) = sudoku0((63))) or else
  (sudoku0((54)) /= (0) and then sudoku0((54)) = sudoku0((63))) or else
  (sudoku0((0)) /= (0) and then sudoku0((0)) = sudoku0((72))) or else
  (sudoku0((9)) /= (0) and then sudoku0((9)) = sudoku0((72))) or else
  (sudoku0((18)) /= (0) and then sudoku0((18)) = sudoku0((72))) or else
  (sudoku0((27)) /= (0) and then sudoku0((27)) = sudoku0((72))) or else
  (sudoku0((36)) /= (0) and then sudoku0((36)) = sudoku0((72))) or else
  (sudoku0((45)) /= (0) and then sudoku0((45)) = sudoku0((72))) or else
  (sudoku0((54)) /= (0) and then sudoku0((54)) = sudoku0((72))) or else
  (sudoku0((63)) /= (0) and then sudoku0((63)) = sudoku0((72))) or else
  (sudoku0((1)) /= (0) and then sudoku0((1)) = sudoku0((10))) or else
  (sudoku0((1)) /= (0) and then sudoku0((1)) = sudoku0((19))) or else
  (sudoku0((10)) /= (0) and then sudoku0((10)) = sudoku0((19))) or else
  (sudoku0((1)) /= (0) and then sudoku0((1)) = sudoku0((28))) or else
  (sudoku0((10)) /= (0) and then sudoku0((10)) = sudoku0((28))) or else
  (sudoku0((19)) /= (0) and then sudoku0((19)) = sudoku0((28))) or else
  (sudoku0((1)) /= (0) and then sudoku0((1)) = sudoku0((37))) or else
  (sudoku0((10)) /= (0) and then sudoku0((10)) = sudoku0((37))) or else
  (sudoku0((19)) /= (0) and then sudoku0((19)) = sudoku0((37))) or else
  (sudoku0((28)) /= (0) and then sudoku0((28)) = sudoku0((37))) or else
  (sudoku0((1)) /= (0) and then sudoku0((1)) = sudoku0((46))) or else
  (sudoku0((10)) /= (0) and then sudoku0((10)) = sudoku0((46))) or else
  (sudoku0((19)) /= (0) and then sudoku0((19)) = sudoku0((46))) or else
  (sudoku0((28)) /= (0) and then sudoku0((28)) = sudoku0((46))) or else
  (sudoku0((37)) /= (0) and then sudoku0((37)) = sudoku0((46))) or else
  (sudoku0((1)) /= (0) and then sudoku0((1)) = sudoku0((55))) or else
  (sudoku0((10)) /= (0) and then sudoku0((10)) = sudoku0((55))) or else
  (sudoku0((19)) /= (0) and then sudoku0((19)) = sudoku0((55))) or else
  (sudoku0((28)) /= (0) and then sudoku0((28)) = sudoku0((55))) or else
  (sudoku0((37)) /= (0) and then sudoku0((37)) = sudoku0((55))) or else
  (sudoku0((46)) /= (0) and then sudoku0((46)) = sudoku0((55))) or else
  (sudoku0((1)) /= (0) and then sudoku0((1)) = sudoku0((64))) or else
  (sudoku0((10)) /= (0) and then sudoku0((10)) = sudoku0((64))) or else
  (sudoku0((19)) /= (0) and then sudoku0((19)) = sudoku0((64))) or else
  (sudoku0((28)) /= (0) and then sudoku0((28)) = sudoku0((64))) or else
  (sudoku0((37)) /= (0) and then sudoku0((37)) = sudoku0((64))) or else
  (sudoku0((46)) /= (0) and then sudoku0((46)) = sudoku0((64))) or else
  (sudoku0((55)) /= (0) and then sudoku0((55)) = sudoku0((64))) or else
  (sudoku0((1)) /= (0) and then sudoku0((1)) = sudoku0((73))) or else
  (sudoku0((10)) /= (0) and then sudoku0((10)) = sudoku0((73))) or else
  (sudoku0((19)) /= (0) and then sudoku0((19)) = sudoku0((73))) or else
  (sudoku0((28)) /= (0) and then sudoku0((28)) = sudoku0((73))) or else
  (sudoku0((37)) /= (0) and then sudoku0((37)) = sudoku0((73))) or else
  (sudoku0((46)) /= (0) and then sudoku0((46)) = sudoku0((73))) or else
  (sudoku0((55)) /= (0) and then sudoku0((55)) = sudoku0((73))) or else
  (sudoku0((64)) /= (0) and then sudoku0((64)) = sudoku0((73))) or else
  (sudoku0((2)) /= (0) and then sudoku0((2)) = sudoku0((11))) or else
  (sudoku0((2)) /= (0) and then sudoku0((2)) = sudoku0((20))) or else
  (sudoku0((11)) /= (0) and then sudoku0((11)) = sudoku0((20))) or else
  (sudoku0((2)) /= (0) and then sudoku0((2)) = sudoku0((29))) or else
  (sudoku0((11)) /= (0) and then sudoku0((11)) = sudoku0((29))) or else
  (sudoku0((20)) /= (0) and then sudoku0((20)) = sudoku0((29))) or else
  (sudoku0((2)) /= (0) and then sudoku0((2)) = sudoku0((38))) or else
  (sudoku0((11)) /= (0) and then sudoku0((11)) = sudoku0((38))) or else
  (sudoku0((20)) /= (0) and then sudoku0((20)) = sudoku0((38))) or else
  (sudoku0((29)) /= (0) and then sudoku0((29)) = sudoku0((38))) or else
  (sudoku0((2)) /= (0) and then sudoku0((2)) = sudoku0((47))) or else
  (sudoku0((11)) /= (0) and then sudoku0((11)) = sudoku0((47))) or else
  (sudoku0((20)) /= (0) and then sudoku0((20)) = sudoku0((47))) or else
  (sudoku0((29)) /= (0) and then sudoku0((29)) = sudoku0((47))) or else
  (sudoku0((38)) /= (0) and then sudoku0((38)) = sudoku0((47))) or else
  (sudoku0((2)) /= (0) and then sudoku0((2)) = sudoku0((56))) or else
  (sudoku0((11)) /= (0) and then sudoku0((11)) = sudoku0((56))) or else
  (sudoku0((20)) /= (0) and then sudoku0((20)) = sudoku0((56))) or else
  (sudoku0((29)) /= (0) and then sudoku0((29)) = sudoku0((56))) or else
  (sudoku0((38)) /= (0) and then sudoku0((38)) = sudoku0((56))) or else
  (sudoku0((47)) /= (0) and then sudoku0((47)) = sudoku0((56))) or else
  (sudoku0((2)) /= (0) and then sudoku0((2)) = sudoku0((65))) or else
  (sudoku0((11)) /= (0) and then sudoku0((11)) = sudoku0((65))) or else
  (sudoku0((20)) /= (0) and then sudoku0((20)) = sudoku0((65))) or else
  (sudoku0((29)) /= (0) and then sudoku0((29)) = sudoku0((65))) or else
  (sudoku0((38)) /= (0) and then sudoku0((38)) = sudoku0((65))) or else
  (sudoku0((47)) /= (0) and then sudoku0((47)) = sudoku0((65))) or else
  (sudoku0((56)) /= (0) and then sudoku0((56)) = sudoku0((65))) or else
  (sudoku0((2)) /= (0) and then sudoku0((2)) = sudoku0((74))) or else
  (sudoku0((11)) /= (0) and then sudoku0((11)) = sudoku0((74))) or else
  (sudoku0((20)) /= (0) and then sudoku0((20)) = sudoku0((74))) or else
  (sudoku0((29)) /= (0) and then sudoku0((29)) = sudoku0((74))) or else
  (sudoku0((38)) /= (0) and then sudoku0((38)) = sudoku0((74))) or else
  (sudoku0((47)) /= (0) and then sudoku0((47)) = sudoku0((74))) or else
  (sudoku0((56)) /= (0) and then sudoku0((56)) = sudoku0((74))) or else
  (sudoku0((65)) /= (0) and then sudoku0((65)) = sudoku0((74))) or else
  (sudoku0((3)) /= (0) and then sudoku0((3)) = sudoku0((12))) or else
  (sudoku0((3)) /= (0) and then sudoku0((3)) = sudoku0((21))) or else
  (sudoku0((12)) /= (0) and then sudoku0((12)) = sudoku0((21))) or else
  (sudoku0((3)) /= (0) and then sudoku0((3)) = sudoku0((30))) or else
  (sudoku0((12)) /= (0) and then sudoku0((12)) = sudoku0((30))) or else
  (sudoku0((21)) /= (0) and then sudoku0((21)) = sudoku0((30))) or else
  (sudoku0((3)) /= (0) and then sudoku0((3)) = sudoku0((39))) or else
  (sudoku0((12)) /= (0) and then sudoku0((12)) = sudoku0((39))) or else
  (sudoku0((21)) /= (0) and then sudoku0((21)) = sudoku0((39))) or else
  (sudoku0((30)) /= (0) and then sudoku0((30)) = sudoku0((39))) or else
  (sudoku0((3)) /= (0) and then sudoku0((3)) = sudoku0((48))) or else
  (sudoku0((12)) /= (0) and then sudoku0((12)) = sudoku0((48))) or else
  (sudoku0((21)) /= (0) and then sudoku0((21)) = sudoku0((48))) or else
  (sudoku0((30)) /= (0) and then sudoku0((30)) = sudoku0((48))) or else
  (sudoku0((39)) /= (0) and then sudoku0((39)) = sudoku0((48))) or else
  (sudoku0((3)) /= (0) and then sudoku0((3)) = sudoku0((57))) or else
  (sudoku0((12)) /= (0) and then sudoku0((12)) = sudoku0((57))) or else
  (sudoku0((21)) /= (0) and then sudoku0((21)) = sudoku0((57))) or else
  (sudoku0((30)) /= (0) and then sudoku0((30)) = sudoku0((57))) or else
  (sudoku0((39)) /= (0) and then sudoku0((39)) = sudoku0((57))) or else
  (sudoku0((48)) /= (0) and then sudoku0((48)) = sudoku0((57))) or else
  (sudoku0((3)) /= (0) and then sudoku0((3)) = sudoku0((66))) or else
  (sudoku0((12)) /= (0) and then sudoku0((12)) = sudoku0((66))) or else
  (sudoku0((21)) /= (0) and then sudoku0((21)) = sudoku0((66))) or else
  (sudoku0((30)) /= (0) and then sudoku0((30)) = sudoku0((66))) or else
  (sudoku0((39)) /= (0) and then sudoku0((39)) = sudoku0((66))) or else
  (sudoku0((48)) /= (0) and then sudoku0((48)) = sudoku0((66))) or else
  (sudoku0((57)) /= (0) and then sudoku0((57)) = sudoku0((66))) or else
  (sudoku0((3)) /= (0) and then sudoku0((3)) = sudoku0((75))) or else
  (sudoku0((12)) /= (0) and then sudoku0((12)) = sudoku0((75))) or else
  (sudoku0((21)) /= (0) and then sudoku0((21)) = sudoku0((75))) or else
  (sudoku0((30)) /= (0) and then sudoku0((30)) = sudoku0((75))) or else
  (sudoku0((39)) /= (0) and then sudoku0((39)) = sudoku0((75))) or else
  (sudoku0((48)) /= (0) and then sudoku0((48)) = sudoku0((75))) or else
  (sudoku0((57)) /= (0) and then sudoku0((57)) = sudoku0((75))) or else
  (sudoku0((66)) /= (0) and then sudoku0((66)) = sudoku0((75))) or else
  (sudoku0((4)) /= (0) and then sudoku0((4)) = sudoku0((13))) or else
  (sudoku0((4)) /= (0) and then sudoku0((4)) = sudoku0((22))) or else
  (sudoku0((13)) /= (0) and then sudoku0((13)) = sudoku0((22))) or else
  (sudoku0((4)) /= (0) and then sudoku0((4)) = sudoku0((31))) or else
  (sudoku0((13)) /= (0) and then sudoku0((13)) = sudoku0((31))) or else
  (sudoku0((22)) /= (0) and then sudoku0((22)) = sudoku0((31))) or else
  (sudoku0((4)) /= (0) and then sudoku0((4)) = sudoku0((40))) or else
  (sudoku0((13)) /= (0) and then sudoku0((13)) = sudoku0((40))) or else
  (sudoku0((22)) /= (0) and then sudoku0((22)) = sudoku0((40))) or else
  (sudoku0((31)) /= (0) and then sudoku0((31)) = sudoku0((40))) or else
  (sudoku0((4)) /= (0) and then sudoku0((4)) = sudoku0((49))) or else
  (sudoku0((13)) /= (0) and then sudoku0((13)) = sudoku0((49))) or else
  (sudoku0((22)) /= (0) and then sudoku0((22)) = sudoku0((49))) or else
  (sudoku0((31)) /= (0) and then sudoku0((31)) = sudoku0((49))) or else
  (sudoku0((40)) /= (0) and then sudoku0((40)) = sudoku0((49))) or else
  (sudoku0((4)) /= (0) and then sudoku0((4)) = sudoku0((58))) or else
  (sudoku0((13)) /= (0) and then sudoku0((13)) = sudoku0((58))) or else
  (sudoku0((22)) /= (0) and then sudoku0((22)) = sudoku0((58))) or else
  (sudoku0((31)) /= (0) and then sudoku0((31)) = sudoku0((58))) or else
  (sudoku0((40)) /= (0) and then sudoku0((40)) = sudoku0((58))) or else
  (sudoku0((49)) /= (0) and then sudoku0((49)) = sudoku0((58))) or else
  (sudoku0((4)) /= (0) and then sudoku0((4)) = sudoku0((67))) or else
  (sudoku0((13)) /= (0) and then sudoku0((13)) = sudoku0((67))) or else
  (sudoku0((22)) /= (0) and then sudoku0((22)) = sudoku0((67))) or else
  (sudoku0((31)) /= (0) and then sudoku0((31)) = sudoku0((67))) or else
  (sudoku0((40)) /= (0) and then sudoku0((40)) = sudoku0((67))) or else
  (sudoku0((49)) /= (0) and then sudoku0((49)) = sudoku0((67))) or else
  (sudoku0((58)) /= (0) and then sudoku0((58)) = sudoku0((67))) or else
  (sudoku0((4)) /= (0) and then sudoku0((4)) = sudoku0((76))) or else
  (sudoku0((13)) /= (0) and then sudoku0((13)) = sudoku0((76))) or else
  (sudoku0((22)) /= (0) and then sudoku0((22)) = sudoku0((76))) or else
  (sudoku0((31)) /= (0) and then sudoku0((31)) = sudoku0((76))) or else
  (sudoku0((40)) /= (0) and then sudoku0((40)) = sudoku0((76))) or else
  (sudoku0((49)) /= (0) and then sudoku0((49)) = sudoku0((76))) or else
  (sudoku0((58)) /= (0) and then sudoku0((58)) = sudoku0((76))) or else
  (sudoku0((67)) /= (0) and then sudoku0((67)) = sudoku0((76))) or else
  (sudoku0((5)) /= (0) and then sudoku0((5)) = sudoku0((14))) or else
  (sudoku0((5)) /= (0) and then sudoku0((5)) = sudoku0((23))) or else
  (sudoku0((14)) /= (0) and then sudoku0((14)) = sudoku0((23))) or else
  (sudoku0((5)) /= (0) and then sudoku0((5)) = sudoku0((32))) or else
  (sudoku0((14)) /= (0) and then sudoku0((14)) = sudoku0((32))) or else
  (sudoku0((23)) /= (0) and then sudoku0((23)) = sudoku0((32))) or else
  (sudoku0((5)) /= (0) and then sudoku0((5)) = sudoku0((41))) or else
  (sudoku0((14)) /= (0) and then sudoku0((14)) = sudoku0((41))) or else
  (sudoku0((23)) /= (0) and then sudoku0((23)) = sudoku0((41))) or else
  (sudoku0((32)) /= (0) and then sudoku0((32)) = sudoku0((41))) or else
  (sudoku0((5)) /= (0) and then sudoku0((5)) = sudoku0((50))) or else
  (sudoku0((14)) /= (0) and then sudoku0((14)) = sudoku0((50))) or else
  (sudoku0((23)) /= (0) and then sudoku0((23)) = sudoku0((50))) or else
  (sudoku0((32)) /= (0) and then sudoku0((32)) = sudoku0((50))) or else
  (sudoku0((41)) /= (0) and then sudoku0((41)) = sudoku0((50))) or else
  (sudoku0((5)) /= (0) and then sudoku0((5)) = sudoku0((59))) or else
  (sudoku0((14)) /= (0) and then sudoku0((14)) = sudoku0((59))) or else
  (sudoku0((23)) /= (0) and then sudoku0((23)) = sudoku0((59))) or else
  (sudoku0((32)) /= (0) and then sudoku0((32)) = sudoku0((59))) or else
  (sudoku0((41)) /= (0) and then sudoku0((41)) = sudoku0((59))) or else
  (sudoku0((50)) /= (0) and then sudoku0((50)) = sudoku0((59))) or else
  (sudoku0((5)) /= (0) and then sudoku0((5)) = sudoku0((68))) or else
  (sudoku0((14)) /= (0) and then sudoku0((14)) = sudoku0((68))) or else
  (sudoku0((23)) /= (0) and then sudoku0((23)) = sudoku0((68))) or else
  (sudoku0((32)) /= (0) and then sudoku0((32)) = sudoku0((68))) or else
  (sudoku0((41)) /= (0) and then sudoku0((41)) = sudoku0((68))) or else
  (sudoku0((50)) /= (0) and then sudoku0((50)) = sudoku0((68))) or else
  (sudoku0((59)) /= (0) and then sudoku0((59)) = sudoku0((68))) or else
  (sudoku0((5)) /= (0) and then sudoku0((5)) = sudoku0((77))) or else
  (sudoku0((14)) /= (0) and then sudoku0((14)) = sudoku0((77))) or else
  (sudoku0((23)) /= (0) and then sudoku0((23)) = sudoku0((77))) or else
  (sudoku0((32)) /= (0) and then sudoku0((32)) = sudoku0((77))) or else
  (sudoku0((41)) /= (0) and then sudoku0((41)) = sudoku0((77))) or else
  (sudoku0((50)) /= (0) and then sudoku0((50)) = sudoku0((77))) or else
  (sudoku0((59)) /= (0) and then sudoku0((59)) = sudoku0((77))) or else
  (sudoku0((68)) /= (0) and then sudoku0((68)) = sudoku0((77))) or else
  (sudoku0((6)) /= (0) and then sudoku0((6)) = sudoku0((15))) or else
  (sudoku0((6)) /= (0) and then sudoku0((6)) = sudoku0((24))) or else
  (sudoku0((15)) /= (0) and then sudoku0((15)) = sudoku0((24))) or else
  (sudoku0((6)) /= (0) and then sudoku0((6)) = sudoku0((33))) or else
  (sudoku0((15)) /= (0) and then sudoku0((15)) = sudoku0((33))) or else
  (sudoku0((24)) /= (0) and then sudoku0((24)) = sudoku0((33))) or else
  (sudoku0((6)) /= (0) and then sudoku0((6)) = sudoku0((42))) or else
  (sudoku0((15)) /= (0) and then sudoku0((15)) = sudoku0((42))) or else
  (sudoku0((24)) /= (0) and then sudoku0((24)) = sudoku0((42))) or else
  (sudoku0((33)) /= (0) and then sudoku0((33)) = sudoku0((42))) or else
  (sudoku0((6)) /= (0) and then sudoku0((6)) = sudoku0((51))) or else
  (sudoku0((15)) /= (0) and then sudoku0((15)) = sudoku0((51))) or else
  (sudoku0((24)) /= (0) and then sudoku0((24)) = sudoku0((51))) or else
  (sudoku0((33)) /= (0) and then sudoku0((33)) = sudoku0((51))) or else
  (sudoku0((42)) /= (0) and then sudoku0((42)) = sudoku0((51))) or else
  (sudoku0((6)) /= (0) and then sudoku0((6)) = sudoku0((60))) or else
  (sudoku0((15)) /= (0) and then sudoku0((15)) = sudoku0((60))) or else
  (sudoku0((24)) /= (0) and then sudoku0((24)) = sudoku0((60))) or else
  (sudoku0((33)) /= (0) and then sudoku0((33)) = sudoku0((60))) or else
  (sudoku0((42)) /= (0) and then sudoku0((42)) = sudoku0((60))) or else
  (sudoku0((51)) /= (0) and then sudoku0((51)) = sudoku0((60))) or else
  (sudoku0((6)) /= (0) and then sudoku0((6)) = sudoku0((69))) or else
  (sudoku0((15)) /= (0) and then sudoku0((15)) = sudoku0((69))) or else
  (sudoku0((24)) /= (0) and then sudoku0((24)) = sudoku0((69))) or else
  (sudoku0((33)) /= (0) and then sudoku0((33)) = sudoku0((69))) or else
  (sudoku0((42)) /= (0) and then sudoku0((42)) = sudoku0((69))) or else
  (sudoku0((51)) /= (0) and then sudoku0((51)) = sudoku0((69))) or else
  (sudoku0((60)) /= (0) and then sudoku0((60)) = sudoku0((69))) or else
  (sudoku0((6)) /= (0) and then sudoku0((6)) = sudoku0((78))) or else
  (sudoku0((15)) /= (0) and then sudoku0((15)) = sudoku0((78))) or else
  (sudoku0((24)) /= (0) and then sudoku0((24)) = sudoku0((78))) or else
  (sudoku0((33)) /= (0) and then sudoku0((33)) = sudoku0((78))) or else
  (sudoku0((42)) /= (0) and then sudoku0((42)) = sudoku0((78))) or else
  (sudoku0((51)) /= (0) and then sudoku0((51)) = sudoku0((78))) or else
  (sudoku0((60)) /= (0) and then sudoku0((60)) = sudoku0((78))) or else
  (sudoku0((69)) /= (0) and then sudoku0((69)) = sudoku0((78))) or else
  (sudoku0((7)) /= (0) and then sudoku0((7)) = sudoku0((16))) or else
  (sudoku0((7)) /= (0) and then sudoku0((7)) = sudoku0((25))) or else
  (sudoku0((16)) /= (0) and then sudoku0((16)) = sudoku0((25))) or else
  (sudoku0((7)) /= (0) and then sudoku0((7)) = sudoku0((34))) or else
  (sudoku0((16)) /= (0) and then sudoku0((16)) = sudoku0((34))) or else
  (sudoku0((25)) /= (0) and then sudoku0((25)) = sudoku0((34))) or else
  (sudoku0((7)) /= (0) and then sudoku0((7)) = sudoku0((43))) or else
  (sudoku0((16)) /= (0) and then sudoku0((16)) = sudoku0((43))) or else
  (sudoku0((25)) /= (0) and then sudoku0((25)) = sudoku0((43))) or else
  (sudoku0((34)) /= (0) and then sudoku0((34)) = sudoku0((43))) or else
  (sudoku0((7)) /= (0) and then sudoku0((7)) = sudoku0((52))) or else
  (sudoku0((16)) /= (0) and then sudoku0((16)) = sudoku0((52))) or else
  (sudoku0((25)) /= (0) and then sudoku0((25)) = sudoku0((52))) or else
  (sudoku0((34)) /= (0) and then sudoku0((34)) = sudoku0((52))) or else
  (sudoku0((43)) /= (0) and then sudoku0((43)) = sudoku0((52))) or else
  (sudoku0((7)) /= (0) and then sudoku0((7)) = sudoku0((61))) or else
  (sudoku0((16)) /= (0) and then sudoku0((16)) = sudoku0((61))) or else
  (sudoku0((25)) /= (0) and then sudoku0((25)) = sudoku0((61))) or else
  (sudoku0((34)) /= (0) and then sudoku0((34)) = sudoku0((61))) or else
  (sudoku0((43)) /= (0) and then sudoku0((43)) = sudoku0((61))) or else
  (sudoku0((52)) /= (0) and then sudoku0((52)) = sudoku0((61))) or else
  (sudoku0((7)) /= (0) and then sudoku0((7)) = sudoku0((70))) or else
  (sudoku0((16)) /= (0) and then sudoku0((16)) = sudoku0((70))) or else
  (sudoku0((25)) /= (0) and then sudoku0((25)) = sudoku0((70))) or else
  (sudoku0((34)) /= (0) and then sudoku0((34)) = sudoku0((70))) or else
  (sudoku0((43)) /= (0) and then sudoku0((43)) = sudoku0((70))) or else
  (sudoku0((52)) /= (0) and then sudoku0((52)) = sudoku0((70))) or else
  (sudoku0((61)) /= (0) and then sudoku0((61)) = sudoku0((70))) or else
  (sudoku0((7)) /= (0) and then sudoku0((7)) = sudoku0((79))) or else
  (sudoku0((16)) /= (0) and then sudoku0((16)) = sudoku0((79))) or else
  (sudoku0((25)) /= (0) and then sudoku0((25)) = sudoku0((79))) or else
  (sudoku0((34)) /= (0) and then sudoku0((34)) = sudoku0((79))) or else
  (sudoku0((43)) /= (0) and then sudoku0((43)) = sudoku0((79))) or else
  (sudoku0((52)) /= (0) and then sudoku0((52)) = sudoku0((79))) or else
  (sudoku0((61)) /= (0) and then sudoku0((61)) = sudoku0((79))) or else
  (sudoku0((70)) /= (0) and then sudoku0((70)) = sudoku0((79))) or else
  (sudoku0((8)) /= (0) and then sudoku0((8)) = sudoku0((17))) or else
  (sudoku0((8)) /= (0) and then sudoku0((8)) = sudoku0((26))) or else
  (sudoku0((17)) /= (0) and then sudoku0((17)) = sudoku0((26))) or else
  (sudoku0((8)) /= (0) and then sudoku0((8)) = sudoku0((35))) or else
  (sudoku0((17)) /= (0) and then sudoku0((17)) = sudoku0((35))) or else
  (sudoku0((26)) /= (0) and then sudoku0((26)) = sudoku0((35))) or else
  (sudoku0((8)) /= (0) and then sudoku0((8)) = sudoku0((44))) or else
  (sudoku0((17)) /= (0) and then sudoku0((17)) = sudoku0((44))) or else
  (sudoku0((26)) /= (0) and then sudoku0((26)) = sudoku0((44))) or else
  (sudoku0((35)) /= (0) and then sudoku0((35)) = sudoku0((44))) or else
  (sudoku0((8)) /= (0) and then sudoku0((8)) = sudoku0((53))) or else
  (sudoku0((17)) /= (0) and then sudoku0((17)) = sudoku0((53))) or else
  (sudoku0((26)) /= (0) and then sudoku0((26)) = sudoku0((53))) or else
  (sudoku0((35)) /= (0) and then sudoku0((35)) = sudoku0((53))) or else
  (sudoku0((44)) /= (0) and then sudoku0((44)) = sudoku0((53))) or else
  (sudoku0((8)) /= (0) and then sudoku0((8)) = sudoku0((62))) or else
  (sudoku0((17)) /= (0) and then sudoku0((17)) = sudoku0((62))) or else
  (sudoku0((26)) /= (0) and then sudoku0((26)) = sudoku0((62))) or else
  (sudoku0((35)) /= (0) and then sudoku0((35)) = sudoku0((62))) or else
  (sudoku0((44)) /= (0) and then sudoku0((44)) = sudoku0((62))) or else
  (sudoku0((53)) /= (0) and then sudoku0((53)) = sudoku0((62))) or else
  (sudoku0((8)) /= (0) and then sudoku0((8)) = sudoku0((71))) or else
  (sudoku0((17)) /= (0) and then sudoku0((17)) = sudoku0((71))) or else
  (sudoku0((26)) /= (0) and then sudoku0((26)) = sudoku0((71))) or else
  (sudoku0((35)) /= (0) and then sudoku0((35)) = sudoku0((71))) or else
  (sudoku0((44)) /= (0) and then sudoku0((44)) = sudoku0((71))) or else
  (sudoku0((53)) /= (0) and then sudoku0((53)) = sudoku0((71))) or else
  (sudoku0((62)) /= (0) and then sudoku0((62)) = sudoku0((71))) or else
  (sudoku0((8)) /= (0) and then sudoku0((8)) = sudoku0((80))) or else
  (sudoku0((17)) /= (0) and then sudoku0((17)) = sudoku0((80))) or else
  (sudoku0((26)) /= (0) and then sudoku0((26)) = sudoku0((80))) or else
  (sudoku0((35)) /= (0) and then sudoku0((35)) = sudoku0((80))) or else
  (sudoku0((44)) /= (0) and then sudoku0((44)) = sudoku0((80))) or else
  (sudoku0((53)) /= (0) and then sudoku0((53)) = sudoku0((80))) or else
  (sudoku0((62)) /= (0) and then sudoku0((62)) = sudoku0((80))) or else
  (sudoku0((71)) /= (0) and then sudoku0((71)) = sudoku0((80))) or else
  (sudoku0((0)) /= (0) and then sudoku0((0)) = sudoku0((1))) or else
  (sudoku0((0)) /= (0) and then sudoku0((0)) = sudoku0((2))) or else
  (sudoku0((1)) /= (0) and then sudoku0((1)) = sudoku0((2))) or else
  (sudoku0((0)) /= (0) and then sudoku0((0)) = sudoku0((3))) or else
  (sudoku0((1)) /= (0) and then sudoku0((1)) = sudoku0((3))) or else
  (sudoku0((2)) /= (0) and then sudoku0((2)) = sudoku0((3))) or else
  (sudoku0((0)) /= (0) and then sudoku0((0)) = sudoku0((4))) or else
  (sudoku0((1)) /= (0) and then sudoku0((1)) = sudoku0((4))) or else
  (sudoku0((2)) /= (0) and then sudoku0((2)) = sudoku0((4))) or else
  (sudoku0((3)) /= (0) and then sudoku0((3)) = sudoku0((4))) or else
  (sudoku0((0)) /= (0) and then sudoku0((0)) = sudoku0((5))) or else
  (sudoku0((1)) /= (0) and then sudoku0((1)) = sudoku0((5))) or else
  (sudoku0((2)) /= (0) and then sudoku0((2)) = sudoku0((5))) or else
  (sudoku0((3)) /= (0) and then sudoku0((3)) = sudoku0((5))) or else
  (sudoku0((4)) /= (0) and then sudoku0((4)) = sudoku0((5))) or else
  (sudoku0((0)) /= (0) and then sudoku0((0)) = sudoku0((6))) or else
  (sudoku0((1)) /= (0) and then sudoku0((1)) = sudoku0((6))) or else
  (sudoku0((2)) /= (0) and then sudoku0((2)) = sudoku0((6))) or else
  (sudoku0((3)) /= (0) and then sudoku0((3)) = sudoku0((6))) or else
  (sudoku0((4)) /= (0) and then sudoku0((4)) = sudoku0((6))) or else
  (sudoku0((5)) /= (0) and then sudoku0((5)) = sudoku0((6))) or else
  (sudoku0((0)) /= (0) and then sudoku0((0)) = sudoku0((7))) or else
  (sudoku0((1)) /= (0) and then sudoku0((1)) = sudoku0((7))) or else
  (sudoku0((2)) /= (0) and then sudoku0((2)) = sudoku0((7))) or else
  (sudoku0((3)) /= (0) and then sudoku0((3)) = sudoku0((7))) or else
  (sudoku0((4)) /= (0) and then sudoku0((4)) = sudoku0((7))) or else
  (sudoku0((5)) /= (0) and then sudoku0((5)) = sudoku0((7))) or else
  (sudoku0((6)) /= (0) and then sudoku0((6)) = sudoku0((7))) or else
  (sudoku0((0)) /= (0) and then sudoku0((0)) = sudoku0((8))) or else
  (sudoku0((1)) /= (0) and then sudoku0((1)) = sudoku0((8))) or else
  (sudoku0((2)) /= (0) and then sudoku0((2)) = sudoku0((8))) or else
  (sudoku0((3)) /= (0) and then sudoku0((3)) = sudoku0((8))) or else
  (sudoku0((4)) /= (0) and then sudoku0((4)) = sudoku0((8))) or else
  (sudoku0((5)) /= (0) and then sudoku0((5)) = sudoku0((8))) or else
  (sudoku0((6)) /= (0) and then sudoku0((6)) = sudoku0((8))) or else
  (sudoku0((7)) /= (0) and then sudoku0((7)) = sudoku0((8))) or else
  (sudoku0((9)) /= (0) and then sudoku0((9)) = sudoku0((10))) or else
  (sudoku0((9)) /= (0) and then sudoku0((9)) = sudoku0((11))) or else
  (sudoku0((10)) /= (0) and then sudoku0((10)) = sudoku0((11))) or else
  (sudoku0((9)) /= (0) and then sudoku0((9)) = sudoku0((12))) or else
  (sudoku0((10)) /= (0) and then sudoku0((10)) = sudoku0((12))) or else
  (sudoku0((11)) /= (0) and then sudoku0((11)) = sudoku0((12))) or else
  (sudoku0((9)) /= (0) and then sudoku0((9)) = sudoku0((13))) or else
  (sudoku0((10)) /= (0) and then sudoku0((10)) = sudoku0((13))) or else
  (sudoku0((11)) /= (0) and then sudoku0((11)) = sudoku0((13))) or else
  (sudoku0((12)) /= (0) and then sudoku0((12)) = sudoku0((13))) or else
  (sudoku0((9)) /= (0) and then sudoku0((9)) = sudoku0((14))) or else
  (sudoku0((10)) /= (0) and then sudoku0((10)) = sudoku0((14))) or else
  (sudoku0((11)) /= (0) and then sudoku0((11)) = sudoku0((14))) or else
  (sudoku0((12)) /= (0) and then sudoku0((12)) = sudoku0((14))) or else
  (sudoku0((13)) /= (0) and then sudoku0((13)) = sudoku0((14))) or else
  (sudoku0((9)) /= (0) and then sudoku0((9)) = sudoku0((15))) or else
  (sudoku0((10)) /= (0) and then sudoku0((10)) = sudoku0((15))) or else
  (sudoku0((11)) /= (0) and then sudoku0((11)) = sudoku0((15))) or else
  (sudoku0((12)) /= (0) and then sudoku0((12)) = sudoku0((15))) or else
  (sudoku0((13)) /= (0) and then sudoku0((13)) = sudoku0((15))) or else
  (sudoku0((14)) /= (0) and then sudoku0((14)) = sudoku0((15))) or else
  (sudoku0((9)) /= (0) and then sudoku0((9)) = sudoku0((16))) or else
  (sudoku0((10)) /= (0) and then sudoku0((10)) = sudoku0((16))) or else
  (sudoku0((11)) /= (0) and then sudoku0((11)) = sudoku0((16))) or else
  (sudoku0((12)) /= (0) and then sudoku0((12)) = sudoku0((16))) or else
  (sudoku0((13)) /= (0) and then sudoku0((13)) = sudoku0((16))) or else
  (sudoku0((14)) /= (0) and then sudoku0((14)) = sudoku0((16))) or else
  (sudoku0((15)) /= (0) and then sudoku0((15)) = sudoku0((16))) or else
  (sudoku0((9)) /= (0) and then sudoku0((9)) = sudoku0((17))) or else
  (sudoku0((10)) /= (0) and then sudoku0((10)) = sudoku0((17))) or else
  (sudoku0((11)) /= (0) and then sudoku0((11)) = sudoku0((17))) or else
  (sudoku0((12)) /= (0) and then sudoku0((12)) = sudoku0((17))) or else
  (sudoku0((13)) /= (0) and then sudoku0((13)) = sudoku0((17))) or else
  (sudoku0((14)) /= (0) and then sudoku0((14)) = sudoku0((17))) or else
  (sudoku0((15)) /= (0) and then sudoku0((15)) = sudoku0((17))) or else
  (sudoku0((16)) /= (0) and then sudoku0((16)) = sudoku0((17))) or else
  (sudoku0((18)) /= (0) and then sudoku0((18)) = sudoku0((19))) or else
  (sudoku0((18)) /= (0) and then sudoku0((18)) = sudoku0((20))) or else
  (sudoku0((19)) /= (0) and then sudoku0((19)) = sudoku0((20))) or else
  (sudoku0((18)) /= (0) and then sudoku0((18)) = sudoku0((21))) or else
  (sudoku0((19)) /= (0) and then sudoku0((19)) = sudoku0((21))) or else
  (sudoku0((20)) /= (0) and then sudoku0((20)) = sudoku0((21))) or else
  (sudoku0((18)) /= (0) and then sudoku0((18)) = sudoku0((22))) or else
  (sudoku0((19)) /= (0) and then sudoku0((19)) = sudoku0((22))) or else
  (sudoku0((20)) /= (0) and then sudoku0((20)) = sudoku0((22))) or else
  (sudoku0((21)) /= (0) and then sudoku0((21)) = sudoku0((22))) or else
  (sudoku0((18)) /= (0) and then sudoku0((18)) = sudoku0((23))) or else
  (sudoku0((19)) /= (0) and then sudoku0((19)) = sudoku0((23))) or else
  (sudoku0((20)) /= (0) and then sudoku0((20)) = sudoku0((23))) or else
  (sudoku0((21)) /= (0) and then sudoku0((21)) = sudoku0((23))) or else
  (sudoku0((22)) /= (0) and then sudoku0((22)) = sudoku0((23))) or else
  (sudoku0((18)) /= (0) and then sudoku0((18)) = sudoku0((24))) or else
  (sudoku0((19)) /= (0) and then sudoku0((19)) = sudoku0((24))) or else
  (sudoku0((20)) /= (0) and then sudoku0((20)) = sudoku0((24))) or else
  (sudoku0((21)) /= (0) and then sudoku0((21)) = sudoku0((24))) or else
  (sudoku0((22)) /= (0) and then sudoku0((22)) = sudoku0((24))) or else
  (sudoku0((23)) /= (0) and then sudoku0((23)) = sudoku0((24))) or else
  (sudoku0((18)) /= (0) and then sudoku0((18)) = sudoku0((25))) or else
  (sudoku0((19)) /= (0) and then sudoku0((19)) = sudoku0((25))) or else
  (sudoku0((20)) /= (0) and then sudoku0((20)) = sudoku0((25))) or else
  (sudoku0((21)) /= (0) and then sudoku0((21)) = sudoku0((25))) or else
  (sudoku0((22)) /= (0) and then sudoku0((22)) = sudoku0((25))) or else
  (sudoku0((23)) /= (0) and then sudoku0((23)) = sudoku0((25))) or else
  (sudoku0((24)) /= (0) and then sudoku0((24)) = sudoku0((25))) or else
  (sudoku0((18)) /= (0) and then sudoku0((18)) = sudoku0((26))) or else
  (sudoku0((19)) /= (0) and then sudoku0((19)) = sudoku0((26))) or else
  (sudoku0((20)) /= (0) and then sudoku0((20)) = sudoku0((26))) or else
  (sudoku0((21)) /= (0) and then sudoku0((21)) = sudoku0((26))) or else
  (sudoku0((22)) /= (0) and then sudoku0((22)) = sudoku0((26))) or else
  (sudoku0((23)) /= (0) and then sudoku0((23)) = sudoku0((26))) or else
  (sudoku0((24)) /= (0) and then sudoku0((24)) = sudoku0((26))) or else
  (sudoku0((25)) /= (0) and then sudoku0((25)) = sudoku0((26))) or else
  (sudoku0((27)) /= (0) and then sudoku0((27)) = sudoku0((28))) or else
  (sudoku0((27)) /= (0) and then sudoku0((27)) = sudoku0((29))) or else
  (sudoku0((28)) /= (0) and then sudoku0((28)) = sudoku0((29))) or else
  (sudoku0((27)) /= (0) and then sudoku0((27)) = sudoku0((30))) or else
  (sudoku0((28)) /= (0) and then sudoku0((28)) = sudoku0((30))) or else
  (sudoku0((29)) /= (0) and then sudoku0((29)) = sudoku0((30))) or else
  (sudoku0((27)) /= (0) and then sudoku0((27)) = sudoku0((31))) or else
  (sudoku0((28)) /= (0) and then sudoku0((28)) = sudoku0((31))) or else
  (sudoku0((29)) /= (0) and then sudoku0((29)) = sudoku0((31))) or else
  (sudoku0((30)) /= (0) and then sudoku0((30)) = sudoku0((31))) or else
  (sudoku0((27)) /= (0) and then sudoku0((27)) = sudoku0((32))) or else
  (sudoku0((28)) /= (0) and then sudoku0((28)) = sudoku0((32))) or else
  (sudoku0((29)) /= (0) and then sudoku0((29)) = sudoku0((32))) or else
  (sudoku0((30)) /= (0) and then sudoku0((30)) = sudoku0((32))) or else
  (sudoku0((31)) /= (0) and then sudoku0((31)) = sudoku0((32))) or else
  (sudoku0((27)) /= (0) and then sudoku0((27)) = sudoku0((33))) or else
  (sudoku0((28)) /= (0) and then sudoku0((28)) = sudoku0((33))) or else
  (sudoku0((29)) /= (0) and then sudoku0((29)) = sudoku0((33))) or else
  (sudoku0((30)) /= (0) and then sudoku0((30)) = sudoku0((33))) or else
  (sudoku0((31)) /= (0) and then sudoku0((31)) = sudoku0((33))) or else
  (sudoku0((32)) /= (0) and then sudoku0((32)) = sudoku0((33))) or else
  (sudoku0((27)) /= (0) and then sudoku0((27)) = sudoku0((34))) or else
  (sudoku0((28)) /= (0) and then sudoku0((28)) = sudoku0((34))) or else
  (sudoku0((29)) /= (0) and then sudoku0((29)) = sudoku0((34))) or else
  (sudoku0((30)) /= (0) and then sudoku0((30)) = sudoku0((34))) or else
  (sudoku0((31)) /= (0) and then sudoku0((31)) = sudoku0((34))) or else
  (sudoku0((32)) /= (0) and then sudoku0((32)) = sudoku0((34))) or else
  (sudoku0((33)) /= (0) and then sudoku0((33)) = sudoku0((34))) or else
  (sudoku0((27)) /= (0) and then sudoku0((27)) = sudoku0((35))) or else
  (sudoku0((28)) /= (0) and then sudoku0((28)) = sudoku0((35))) or else
  (sudoku0((29)) /= (0) and then sudoku0((29)) = sudoku0((35))) or else
  (sudoku0((30)) /= (0) and then sudoku0((30)) = sudoku0((35))) or else
  (sudoku0((31)) /= (0) and then sudoku0((31)) = sudoku0((35))) or else
  (sudoku0((32)) /= (0) and then sudoku0((32)) = sudoku0((35))) or else
  (sudoku0((33)) /= (0) and then sudoku0((33)) = sudoku0((35))) or else
  (sudoku0((34)) /= (0) and then sudoku0((34)) = sudoku0((35))) or else
  (sudoku0((36)) /= (0) and then sudoku0((36)) = sudoku0((37))) or else
  (sudoku0((36)) /= (0) and then sudoku0((36)) = sudoku0((38))) or else
  (sudoku0((37)) /= (0) and then sudoku0((37)) = sudoku0((38))) or else
  (sudoku0((36)) /= (0) and then sudoku0((36)) = sudoku0((39))) or else
  (sudoku0((37)) /= (0) and then sudoku0((37)) = sudoku0((39))) or else
  (sudoku0((38)) /= (0) and then sudoku0((38)) = sudoku0((39))) or else
  (sudoku0((36)) /= (0) and then sudoku0((36)) = sudoku0((40))) or else
  (sudoku0((37)) /= (0) and then sudoku0((37)) = sudoku0((40))) or else
  (sudoku0((38)) /= (0) and then sudoku0((38)) = sudoku0((40))) or else
  (sudoku0((39)) /= (0) and then sudoku0((39)) = sudoku0((40))) or else
  (sudoku0((36)) /= (0) and then sudoku0((36)) = sudoku0((41))) or else
  (sudoku0((37)) /= (0) and then sudoku0((37)) = sudoku0((41))) or else
  (sudoku0((38)) /= (0) and then sudoku0((38)) = sudoku0((41))) or else
  (sudoku0((39)) /= (0) and then sudoku0((39)) = sudoku0((41))) or else
  (sudoku0((40)) /= (0) and then sudoku0((40)) = sudoku0((41))) or else
  (sudoku0((36)) /= (0) and then sudoku0((36)) = sudoku0((42))) or else
  (sudoku0((37)) /= (0) and then sudoku0((37)) = sudoku0((42))) or else
  (sudoku0((38)) /= (0) and then sudoku0((38)) = sudoku0((42))) or else
  (sudoku0((39)) /= (0) and then sudoku0((39)) = sudoku0((42))) or else
  (sudoku0((40)) /= (0) and then sudoku0((40)) = sudoku0((42))) or else
  (sudoku0((41)) /= (0) and then sudoku0((41)) = sudoku0((42))) or else
  (sudoku0((36)) /= (0) and then sudoku0((36)) = sudoku0((43))) or else
  (sudoku0((37)) /= (0) and then sudoku0((37)) = sudoku0((43))) or else
  (sudoku0((38)) /= (0) and then sudoku0((38)) = sudoku0((43))) or else
  (sudoku0((39)) /= (0) and then sudoku0((39)) = sudoku0((43))) or else
  (sudoku0((40)) /= (0) and then sudoku0((40)) = sudoku0((43))) or else
  (sudoku0((41)) /= (0) and then sudoku0((41)) = sudoku0((43))) or else
  (sudoku0((42)) /= (0) and then sudoku0((42)) = sudoku0((43))) or else
  (sudoku0((36)) /= (0) and then sudoku0((36)) = sudoku0((44))) or else
  (sudoku0((37)) /= (0) and then sudoku0((37)) = sudoku0((44))) or else
  (sudoku0((38)) /= (0) and then sudoku0((38)) = sudoku0((44))) or else
  (sudoku0((39)) /= (0) and then sudoku0((39)) = sudoku0((44))) or else
  (sudoku0((40)) /= (0) and then sudoku0((40)) = sudoku0((44))) or else
  (sudoku0((41)) /= (0) and then sudoku0((41)) = sudoku0((44))) or else
  (sudoku0((42)) /= (0) and then sudoku0((42)) = sudoku0((44))) or else
  (sudoku0((43)) /= (0) and then sudoku0((43)) = sudoku0((44))) or else
  (sudoku0((45)) /= (0) and then sudoku0((45)) = sudoku0((46))) or else
  (sudoku0((45)) /= (0) and then sudoku0((45)) = sudoku0((47))) or else
  (sudoku0((46)) /= (0) and then sudoku0((46)) = sudoku0((47))) or else
  (sudoku0((45)) /= (0) and then sudoku0((45)) = sudoku0((48))) or else
  (sudoku0((46)) /= (0) and then sudoku0((46)) = sudoku0((48))) or else
  (sudoku0((47)) /= (0) and then sudoku0((47)) = sudoku0((48))) or else
  (sudoku0((45)) /= (0) and then sudoku0((45)) = sudoku0((49))) or else
  (sudoku0((46)) /= (0) and then sudoku0((46)) = sudoku0((49))) or else
  (sudoku0((47)) /= (0) and then sudoku0((47)) = sudoku0((49))) or else
  (sudoku0((48)) /= (0) and then sudoku0((48)) = sudoku0((49))) or else
  (sudoku0((45)) /= (0) and then sudoku0((45)) = sudoku0((50))) or else
  (sudoku0((46)) /= (0) and then sudoku0((46)) = sudoku0((50))) or else
  (sudoku0((47)) /= (0) and then sudoku0((47)) = sudoku0((50))) or else
  (sudoku0((48)) /= (0) and then sudoku0((48)) = sudoku0((50))) or else
  (sudoku0((49)) /= (0) and then sudoku0((49)) = sudoku0((50))) or else
  (sudoku0((45)) /= (0) and then sudoku0((45)) = sudoku0((51))) or else
  (sudoku0((46)) /= (0) and then sudoku0((46)) = sudoku0((51))) or else
  (sudoku0((47)) /= (0) and then sudoku0((47)) = sudoku0((51))) or else
  (sudoku0((48)) /= (0) and then sudoku0((48)) = sudoku0((51))) or else
  (sudoku0((49)) /= (0) and then sudoku0((49)) = sudoku0((51))) or else
  (sudoku0((50)) /= (0) and then sudoku0((50)) = sudoku0((51))) or else
  (sudoku0((45)) /= (0) and then sudoku0((45)) = sudoku0((52))) or else
  (sudoku0((46)) /= (0) and then sudoku0((46)) = sudoku0((52))) or else
  (sudoku0((47)) /= (0) and then sudoku0((47)) = sudoku0((52))) or else
  (sudoku0((48)) /= (0) and then sudoku0((48)) = sudoku0((52))) or else
  (sudoku0((49)) /= (0) and then sudoku0((49)) = sudoku0((52))) or else
  (sudoku0((50)) /= (0) and then sudoku0((50)) = sudoku0((52))) or else
  (sudoku0((51)) /= (0) and then sudoku0((51)) = sudoku0((52))) or else
  (sudoku0((45)) /= (0) and then sudoku0((45)) = sudoku0((53))) or else
  (sudoku0((46)) /= (0) and then sudoku0((46)) = sudoku0((53))) or else
  (sudoku0((47)) /= (0) and then sudoku0((47)) = sudoku0((53))) or else
  (sudoku0((48)) /= (0) and then sudoku0((48)) = sudoku0((53))) or else
  (sudoku0((49)) /= (0) and then sudoku0((49)) = sudoku0((53))) or else
  (sudoku0((50)) /= (0) and then sudoku0((50)) = sudoku0((53))) or else
  (sudoku0((51)) /= (0) and then sudoku0((51)) = sudoku0((53))) or else
  (sudoku0((52)) /= (0) and then sudoku0((52)) = sudoku0((53))) or else
  (sudoku0((54)) /= (0) and then sudoku0((54)) = sudoku0((55))) or else
  (sudoku0((54)) /= (0) and then sudoku0((54)) = sudoku0((56))) or else
  (sudoku0((55)) /= (0) and then sudoku0((55)) = sudoku0((56))) or else
  (sudoku0((54)) /= (0) and then sudoku0((54)) = sudoku0((57))) or else
  (sudoku0((55)) /= (0) and then sudoku0((55)) = sudoku0((57))) or else
  (sudoku0((56)) /= (0) and then sudoku0((56)) = sudoku0((57))) or else
  (sudoku0((54)) /= (0) and then sudoku0((54)) = sudoku0((58))) or else
  (sudoku0((55)) /= (0) and then sudoku0((55)) = sudoku0((58))) or else
  (sudoku0((56)) /= (0) and then sudoku0((56)) = sudoku0((58))) or else
  (sudoku0((57)) /= (0) and then sudoku0((57)) = sudoku0((58))) or else
  (sudoku0((54)) /= (0) and then sudoku0((54)) = sudoku0((59))) or else
  (sudoku0((55)) /= (0) and then sudoku0((55)) = sudoku0((59))) or else
  (sudoku0((56)) /= (0) and then sudoku0((56)) = sudoku0((59))) or else
  (sudoku0((57)) /= (0) and then sudoku0((57)) = sudoku0((59))) or else
  (sudoku0((58)) /= (0) and then sudoku0((58)) = sudoku0((59))) or else
  (sudoku0((54)) /= (0) and then sudoku0((54)) = sudoku0((60))) or else
  (sudoku0((55)) /= (0) and then sudoku0((55)) = sudoku0((60))) or else
  (sudoku0((56)) /= (0) and then sudoku0((56)) = sudoku0((60))) or else
  (sudoku0((57)) /= (0) and then sudoku0((57)) = sudoku0((60))) or else
  (sudoku0((58)) /= (0) and then sudoku0((58)) = sudoku0((60))) or else
  (sudoku0((59)) /= (0) and then sudoku0((59)) = sudoku0((60))) or else
  (sudoku0((54)) /= (0) and then sudoku0((54)) = sudoku0((61))) or else
  (sudoku0((55)) /= (0) and then sudoku0((55)) = sudoku0((61))) or else
  (sudoku0((56)) /= (0) and then sudoku0((56)) = sudoku0((61))) or else
  (sudoku0((57)) /= (0) and then sudoku0((57)) = sudoku0((61))) or else
  (sudoku0((58)) /= (0) and then sudoku0((58)) = sudoku0((61))) or else
  (sudoku0((59)) /= (0) and then sudoku0((59)) = sudoku0((61))) or else
  (sudoku0((60)) /= (0) and then sudoku0((60)) = sudoku0((61))) or else
  (sudoku0((54)) /= (0) and then sudoku0((54)) = sudoku0((62))) or else
  (sudoku0((55)) /= (0) and then sudoku0((55)) = sudoku0((62))) or else
  (sudoku0((56)) /= (0) and then sudoku0((56)) = sudoku0((62))) or else
  (sudoku0((57)) /= (0) and then sudoku0((57)) = sudoku0((62))) or else
  (sudoku0((58)) /= (0) and then sudoku0((58)) = sudoku0((62))) or else
  (sudoku0((59)) /= (0) and then sudoku0((59)) = sudoku0((62))) or else
  (sudoku0((60)) /= (0) and then sudoku0((60)) = sudoku0((62))) or else
  (sudoku0((61)) /= (0) and then sudoku0((61)) = sudoku0((62))) or else
  (sudoku0((63)) /= (0) and then sudoku0((63)) = sudoku0((64))) or else
  (sudoku0((63)) /= (0) and then sudoku0((63)) = sudoku0((65))) or else
  (sudoku0((64)) /= (0) and then sudoku0((64)) = sudoku0((65))) or else
  (sudoku0((63)) /= (0) and then sudoku0((63)) = sudoku0((66))) or else
  (sudoku0((64)) /= (0) and then sudoku0((64)) = sudoku0((66))) or else
  (sudoku0((65)) /= (0) and then sudoku0((65)) = sudoku0((66))) or else
  (sudoku0((63)) /= (0) and then sudoku0((63)) = sudoku0((67))) or else
  (sudoku0((64)) /= (0) and then sudoku0((64)) = sudoku0((67))) or else
  (sudoku0((65)) /= (0) and then sudoku0((65)) = sudoku0((67))) or else
  (sudoku0((66)) /= (0) and then sudoku0((66)) = sudoku0((67))) or else
  (sudoku0((63)) /= (0) and then sudoku0((63)) = sudoku0((68))) or else
  (sudoku0((64)) /= (0) and then sudoku0((64)) = sudoku0((68))) or else
  (sudoku0((65)) /= (0) and then sudoku0((65)) = sudoku0((68))) or else
  (sudoku0((66)) /= (0) and then sudoku0((66)) = sudoku0((68))) or else
  (sudoku0((67)) /= (0) and then sudoku0((67)) = sudoku0((68))) or else
  (sudoku0((63)) /= (0) and then sudoku0((63)) = sudoku0((69))) or else
  (sudoku0((64)) /= (0) and then sudoku0((64)) = sudoku0((69))) or else
  (sudoku0((65)) /= (0) and then sudoku0((65)) = sudoku0((69))) or else
  (sudoku0((66)) /= (0) and then sudoku0((66)) = sudoku0((69))) or else
  (sudoku0((67)) /= (0) and then sudoku0((67)) = sudoku0((69))) or else
  (sudoku0((68)) /= (0) and then sudoku0((68)) = sudoku0((69))) or else
  (sudoku0((63)) /= (0) and then sudoku0((63)) = sudoku0((70))) or else
  (sudoku0((64)) /= (0) and then sudoku0((64)) = sudoku0((70))) or else
  (sudoku0((65)) /= (0) and then sudoku0((65)) = sudoku0((70))) or else
  (sudoku0((66)) /= (0) and then sudoku0((66)) = sudoku0((70))) or else
  (sudoku0((67)) /= (0) and then sudoku0((67)) = sudoku0((70))) or else
  (sudoku0((68)) /= (0) and then sudoku0((68)) = sudoku0((70))) or else
  (sudoku0((69)) /= (0) and then sudoku0((69)) = sudoku0((70))) or else
  (sudoku0((63)) /= (0) and then sudoku0((63)) = sudoku0((71))) or else
  (sudoku0((64)) /= (0) and then sudoku0((64)) = sudoku0((71))) or else
  (sudoku0((65)) /= (0) and then sudoku0((65)) = sudoku0((71))) or else
  (sudoku0((66)) /= (0) and then sudoku0((66)) = sudoku0((71))) or else
  (sudoku0((67)) /= (0) and then sudoku0((67)) = sudoku0((71))) or else
  (sudoku0((68)) /= (0) and then sudoku0((68)) = sudoku0((71))) or else
  (sudoku0((69)) /= (0) and then sudoku0((69)) = sudoku0((71))) or else
  (sudoku0((70)) /= (0) and then sudoku0((70)) = sudoku0((71))) or else
  (sudoku0((72)) /= (0) and then sudoku0((72)) = sudoku0((73))) or else
  (sudoku0((72)) /= (0) and then sudoku0((72)) = sudoku0((74))) or else
  (sudoku0((73)) /= (0) and then sudoku0((73)) = sudoku0((74))) or else
  (sudoku0((72)) /= (0) and then sudoku0((72)) = sudoku0((75))) or else
  (sudoku0((73)) /= (0) and then sudoku0((73)) = sudoku0((75))) or else
  (sudoku0((74)) /= (0) and then sudoku0((74)) = sudoku0((75))) or else
  (sudoku0((72)) /= (0) and then sudoku0((72)) = sudoku0((76))) or else
  (sudoku0((73)) /= (0) and then sudoku0((73)) = sudoku0((76))) or else
  (sudoku0((74)) /= (0) and then sudoku0((74)) = sudoku0((76))) or else
  (sudoku0((75)) /= (0) and then sudoku0((75)) = sudoku0((76))) or else
  (sudoku0((72)) /= (0) and then sudoku0((72)) = sudoku0((77))) or else
  (sudoku0((73)) /= (0) and then sudoku0((73)) = sudoku0((77))) or else
  (sudoku0((74)) /= (0) and then sudoku0((74)) = sudoku0((77))) or else
  (sudoku0((75)) /= (0) and then sudoku0((75)) = sudoku0((77))) or else
  (sudoku0((76)) /= (0) and then sudoku0((76)) = sudoku0((77))) or else
  (sudoku0((72)) /= (0) and then sudoku0((72)) = sudoku0((78))) or else
  (sudoku0((73)) /= (0) and then sudoku0((73)) = sudoku0((78))) or else
  (sudoku0((74)) /= (0) and then sudoku0((74)) = sudoku0((78))) or else
  (sudoku0((75)) /= (0) and then sudoku0((75)) = sudoku0((78))) or else
  (sudoku0((76)) /= (0) and then sudoku0((76)) = sudoku0((78))) or else
  (sudoku0((77)) /= (0) and then sudoku0((77)) = sudoku0((78))) or else
  (sudoku0((72)) /= (0) and then sudoku0((72)) = sudoku0((79))) or else
  (sudoku0((73)) /= (0) and then sudoku0((73)) = sudoku0((79))) or else
  (sudoku0((74)) /= (0) and then sudoku0((74)) = sudoku0((79))) or else
  (sudoku0((75)) /= (0) and then sudoku0((75)) = sudoku0((79))) or else
  (sudoku0((76)) /= (0) and then sudoku0((76)) = sudoku0((79))) or else
  (sudoku0((77)) /= (0) and then sudoku0((77)) = sudoku0((79))) or else
  (sudoku0((78)) /= (0) and then sudoku0((78)) = sudoku0((79))) or else
  (sudoku0((72)) /= (0) and then sudoku0((72)) = sudoku0((80))) or else
  (sudoku0((73)) /= (0) and then sudoku0((73)) = sudoku0((80))) or else
  (sudoku0((74)) /= (0) and then sudoku0((74)) = sudoku0((80))) or else
  (sudoku0((75)) /= (0) and then sudoku0((75)) = sudoku0((80))) or else
  (sudoku0((76)) /= (0) and then sudoku0((76)) = sudoku0((80))) or else
  (sudoku0((77)) /= (0) and then sudoku0((77)) = sudoku0((80))) or else
  (sudoku0((78)) /= (0) and then sudoku0((78)) = sudoku0((80))) or else
  (sudoku0((79)) /= (0) and then sudoku0((79)) = sudoku0((80))) or else
  (sudoku0((0)) /= (0) and then sudoku0((0)) = sudoku0((1))) or else
  (sudoku0((0)) /= (0) and then sudoku0((0)) = sudoku0((2))) or else
  (sudoku0((1)) /= (0) and then sudoku0((1)) = sudoku0((2))) or else
  (sudoku0((0)) /= (0) and then sudoku0((0)) = sudoku0((9))) or else
  (sudoku0((1)) /= (0) and then sudoku0((1)) = sudoku0((9))) or else
  (sudoku0((2)) /= (0) and then sudoku0((2)) = sudoku0((9))) or else
  (sudoku0((0)) /= (0) and then sudoku0((0)) = sudoku0((10))) or else
  (sudoku0((1)) /= (0) and then sudoku0((1)) = sudoku0((10))) or else
  (sudoku0((2)) /= (0) and then sudoku0((2)) = sudoku0((10))) or else
  (sudoku0((9)) /= (0) and then sudoku0((9)) = sudoku0((10))) or else
  (sudoku0((0)) /= (0) and then sudoku0((0)) = sudoku0((11))) or else
  (sudoku0((1)) /= (0) and then sudoku0((1)) = sudoku0((11))) or else
  (sudoku0((2)) /= (0) and then sudoku0((2)) = sudoku0((11))) or else
  (sudoku0((9)) /= (0) and then sudoku0((9)) = sudoku0((11))) or else
  (sudoku0((10)) /= (0) and then sudoku0((10)) = sudoku0((11))) or else
  (sudoku0((0)) /= (0) and then sudoku0((0)) = sudoku0((18))) or else
  (sudoku0((1)) /= (0) and then sudoku0((1)) = sudoku0((18))) or else
  (sudoku0((2)) /= (0) and then sudoku0((2)) = sudoku0((18))) or else
  (sudoku0((9)) /= (0) and then sudoku0((9)) = sudoku0((18))) or else
  (sudoku0((10)) /= (0) and then sudoku0((10)) = sudoku0((18))) or else
  (sudoku0((11)) /= (0) and then sudoku0((11)) = sudoku0((18))) or else
  (sudoku0((0)) /= (0) and then sudoku0((0)) = sudoku0((19))) or else
  (sudoku0((1)) /= (0) and then sudoku0((1)) = sudoku0((19))) or else
  (sudoku0((2)) /= (0) and then sudoku0((2)) = sudoku0((19))) or else
  (sudoku0((9)) /= (0) and then sudoku0((9)) = sudoku0((19))) or else
  (sudoku0((10)) /= (0) and then sudoku0((10)) = sudoku0((19))) or else
  (sudoku0((11)) /= (0) and then sudoku0((11)) = sudoku0((19))) or else
  (sudoku0((18)) /= (0) and then sudoku0((18)) = sudoku0((19))) or else
  (sudoku0((0)) /= (0) and then sudoku0((0)) = sudoku0((20))) or else
  (sudoku0((1)) /= (0) and then sudoku0((1)) = sudoku0((20))) or else
  (sudoku0((2)) /= (0) and then sudoku0((2)) = sudoku0((20))) or else
  (sudoku0((9)) /= (0) and then sudoku0((9)) = sudoku0((20))) or else
  (sudoku0((10)) /= (0) and then sudoku0((10)) = sudoku0((20))) or else
  (sudoku0((11)) /= (0) and then sudoku0((11)) = sudoku0((20))) or else
  (sudoku0((18)) /= (0) and then sudoku0((18)) = sudoku0((20))) or else
  (sudoku0((19)) /= (0) and then sudoku0((19)) = sudoku0((20))) or else
  (sudoku0((27)) /= (0) and then sudoku0((27)) = sudoku0((28))) or else
  (sudoku0((27)) /= (0) and then sudoku0((27)) = sudoku0((29))) or else
  (sudoku0((28)) /= (0) and then sudoku0((28)) = sudoku0((29))) or else
  (sudoku0((27)) /= (0) and then sudoku0((27)) = sudoku0((36))) or else
  (sudoku0((28)) /= (0) and then sudoku0((28)) = sudoku0((36))) or else
  (sudoku0((29)) /= (0) and then sudoku0((29)) = sudoku0((36))) or else
  (sudoku0((27)) /= (0) and then sudoku0((27)) = sudoku0((37))) or else
  (sudoku0((28)) /= (0) and then sudoku0((28)) = sudoku0((37))) or else
  (sudoku0((29)) /= (0) and then sudoku0((29)) = sudoku0((37))) or else
  (sudoku0((36)) /= (0) and then sudoku0((36)) = sudoku0((37))) or else
  (sudoku0((27)) /= (0) and then sudoku0((27)) = sudoku0((38))) or else
  (sudoku0((28)) /= (0) and then sudoku0((28)) = sudoku0((38))) or else
  (sudoku0((29)) /= (0) and then sudoku0((29)) = sudoku0((38))) or else
  (sudoku0((36)) /= (0) and then sudoku0((36)) = sudoku0((38))) or else
  (sudoku0((37)) /= (0) and then sudoku0((37)) = sudoku0((38))) or else
  (sudoku0((27)) /= (0) and then sudoku0((27)) = sudoku0((45))) or else
  (sudoku0((28)) /= (0) and then sudoku0((28)) = sudoku0((45))) or else
  (sudoku0((29)) /= (0) and then sudoku0((29)) = sudoku0((45))) or else
  (sudoku0((36)) /= (0) and then sudoku0((36)) = sudoku0((45))) or else
  (sudoku0((37)) /= (0) and then sudoku0((37)) = sudoku0((45))) or else
  (sudoku0((38)) /= (0) and then sudoku0((38)) = sudoku0((45))) or else
  (sudoku0((27)) /= (0) and then sudoku0((27)) = sudoku0((46))) or else
  (sudoku0((28)) /= (0) and then sudoku0((28)) = sudoku0((46))) or else
  (sudoku0((29)) /= (0) and then sudoku0((29)) = sudoku0((46))) or else
  (sudoku0((36)) /= (0) and then sudoku0((36)) = sudoku0((46))) or else
  (sudoku0((37)) /= (0) and then sudoku0((37)) = sudoku0((46))) or else
  (sudoku0((38)) /= (0) and then sudoku0((38)) = sudoku0((46))) or else
  (sudoku0((45)) /= (0) and then sudoku0((45)) = sudoku0((46))) or else
  (sudoku0((27)) /= (0) and then sudoku0((27)) = sudoku0((47))) or else
  (sudoku0((28)) /= (0) and then sudoku0((28)) = sudoku0((47))) or else
  (sudoku0((29)) /= (0) and then sudoku0((29)) = sudoku0((47))) or else
  (sudoku0((36)) /= (0) and then sudoku0((36)) = sudoku0((47))) or else
  (sudoku0((37)) /= (0) and then sudoku0((37)) = sudoku0((47))) or else
  (sudoku0((38)) /= (0) and then sudoku0((38)) = sudoku0((47))) or else
  (sudoku0((45)) /= (0) and then sudoku0((45)) = sudoku0((47))) or else
  (sudoku0((46)) /= (0) and then sudoku0((46)) = sudoku0((47))) or else
  (sudoku0((54)) /= (0) and then sudoku0((54)) = sudoku0((55))) or else
  (sudoku0((54)) /= (0) and then sudoku0((54)) = sudoku0((56))) or else
  (sudoku0((55)) /= (0) and then sudoku0((55)) = sudoku0((56))) or else
  (sudoku0((54)) /= (0) and then sudoku0((54)) = sudoku0((63))) or else
  (sudoku0((55)) /= (0) and then sudoku0((55)) = sudoku0((63))) or else
  (sudoku0((56)) /= (0) and then sudoku0((56)) = sudoku0((63))) or else
  (sudoku0((54)) /= (0) and then sudoku0((54)) = sudoku0((64))) or else
  (sudoku0((55)) /= (0) and then sudoku0((55)) = sudoku0((64))) or else
  (sudoku0((56)) /= (0) and then sudoku0((56)) = sudoku0((64))) or else
  (sudoku0((63)) /= (0) and then sudoku0((63)) = sudoku0((64))) or else
  (sudoku0((54)) /= (0) and then sudoku0((54)) = sudoku0((65))) or else
  (sudoku0((55)) /= (0) and then sudoku0((55)) = sudoku0((65))) or else
  (sudoku0((56)) /= (0) and then sudoku0((56)) = sudoku0((65))) or else
  (sudoku0((63)) /= (0) and then sudoku0((63)) = sudoku0((65))) or else
  (sudoku0((64)) /= (0) and then sudoku0((64)) = sudoku0((65))) or else
  (sudoku0((54)) /= (0) and then sudoku0((54)) = sudoku0((72))) or else
  (sudoku0((55)) /= (0) and then sudoku0((55)) = sudoku0((72))) or else
  (sudoku0((56)) /= (0) and then sudoku0((56)) = sudoku0((72))) or else
  (sudoku0((63)) /= (0) and then sudoku0((63)) = sudoku0((72))) or else
  (sudoku0((64)) /= (0) and then sudoku0((64)) = sudoku0((72))) or else
  (sudoku0((65)) /= (0) and then sudoku0((65)) = sudoku0((72))) or else
  (sudoku0((54)) /= (0) and then sudoku0((54)) = sudoku0((73))) or else
  (sudoku0((55)) /= (0) and then sudoku0((55)) = sudoku0((73))) or else
  (sudoku0((56)) /= (0) and then sudoku0((56)) = sudoku0((73))) or else
  (sudoku0((63)) /= (0) and then sudoku0((63)) = sudoku0((73))) or else
  (sudoku0((64)) /= (0) and then sudoku0((64)) = sudoku0((73))) or else
  (sudoku0((65)) /= (0) and then sudoku0((65)) = sudoku0((73))) or else
  (sudoku0((72)) /= (0) and then sudoku0((72)) = sudoku0((73))) or else
  (sudoku0((54)) /= (0) and then sudoku0((54)) = sudoku0((74))) or else
  (sudoku0((55)) /= (0) and then sudoku0((55)) = sudoku0((74))) or else
  (sudoku0((56)) /= (0) and then sudoku0((56)) = sudoku0((74))) or else
  (sudoku0((63)) /= (0) and then sudoku0((63)) = sudoku0((74))) or else
  (sudoku0((64)) /= (0) and then sudoku0((64)) = sudoku0((74))) or else
  (sudoku0((65)) /= (0) and then sudoku0((65)) = sudoku0((74))) or else
  (sudoku0((72)) /= (0) and then sudoku0((72)) = sudoku0((74))) or else
  (sudoku0((73)) /= (0) and then sudoku0((73)) = sudoku0((74))) or else
  (sudoku0((3)) /= (0) and then sudoku0((3)) = sudoku0((4))) or else
  (sudoku0((3)) /= (0) and then sudoku0((3)) = sudoku0((5))) or else
  (sudoku0((4)) /= (0) and then sudoku0((4)) = sudoku0((5))) or else
  (sudoku0((3)) /= (0) and then sudoku0((3)) = sudoku0((12))) or else
  (sudoku0((4)) /= (0) and then sudoku0((4)) = sudoku0((12))) or else
  (sudoku0((5)) /= (0) and then sudoku0((5)) = sudoku0((12))) or else
  (sudoku0((3)) /= (0) and then sudoku0((3)) = sudoku0((13))) or else
  (sudoku0((4)) /= (0) and then sudoku0((4)) = sudoku0((13))) or else
  (sudoku0((5)) /= (0) and then sudoku0((5)) = sudoku0((13))) or else
  (sudoku0((12)) /= (0) and then sudoku0((12)) = sudoku0((13))) or else
  (sudoku0((3)) /= (0) and then sudoku0((3)) = sudoku0((14))) or else
  (sudoku0((4)) /= (0) and then sudoku0((4)) = sudoku0((14))) or else
  (sudoku0((5)) /= (0) and then sudoku0((5)) = sudoku0((14))) or else
  (sudoku0((12)) /= (0) and then sudoku0((12)) = sudoku0((14))) or else
  (sudoku0((13)) /= (0) and then sudoku0((13)) = sudoku0((14))) or else
  (sudoku0((3)) /= (0) and then sudoku0((3)) = sudoku0((21))) or else
  (sudoku0((4)) /= (0) and then sudoku0((4)) = sudoku0((21))) or else
  (sudoku0((5)) /= (0) and then sudoku0((5)) = sudoku0((21))) or else
  (sudoku0((12)) /= (0) and then sudoku0((12)) = sudoku0((21))) or else
  (sudoku0((13)) /= (0) and then sudoku0((13)) = sudoku0((21))) or else
  (sudoku0((14)) /= (0) and then sudoku0((14)) = sudoku0((21))) or else
  (sudoku0((3)) /= (0) and then sudoku0((3)) = sudoku0((22))) or else
  (sudoku0((4)) /= (0) and then sudoku0((4)) = sudoku0((22))) or else
  (sudoku0((5)) /= (0) and then sudoku0((5)) = sudoku0((22))) or else
  (sudoku0((12)) /= (0) and then sudoku0((12)) = sudoku0((22))) or else
  (sudoku0((13)) /= (0) and then sudoku0((13)) = sudoku0((22))) or else
  (sudoku0((14)) /= (0) and then sudoku0((14)) = sudoku0((22))) or else
  (sudoku0((21)) /= (0) and then sudoku0((21)) = sudoku0((22))) or else
  (sudoku0((3)) /= (0) and then sudoku0((3)) = sudoku0((23))) or else
  (sudoku0((4)) /= (0) and then sudoku0((4)) = sudoku0((23))) or else
  (sudoku0((5)) /= (0) and then sudoku0((5)) = sudoku0((23))) or else
  (sudoku0((12)) /= (0) and then sudoku0((12)) = sudoku0((23))) or else
  (sudoku0((13)) /= (0) and then sudoku0((13)) = sudoku0((23))) or else
  (sudoku0((14)) /= (0) and then sudoku0((14)) = sudoku0((23))) or else
  (sudoku0((21)) /= (0) and then sudoku0((21)) = sudoku0((23))) or else
  (sudoku0((22)) /= (0) and then sudoku0((22)) = sudoku0((23))) or else
  (sudoku0((30)) /= (0) and then sudoku0((30)) = sudoku0((31))) or else
  (sudoku0((30)) /= (0) and then sudoku0((30)) = sudoku0((32))) or else
  (sudoku0((31)) /= (0) and then sudoku0((31)) = sudoku0((32))) or else
  (sudoku0((30)) /= (0) and then sudoku0((30)) = sudoku0((39))) or else
  (sudoku0((31)) /= (0) and then sudoku0((31)) = sudoku0((39))) or else
  (sudoku0((32)) /= (0) and then sudoku0((32)) = sudoku0((39))) or else
  (sudoku0((30)) /= (0) and then sudoku0((30)) = sudoku0((40))) or else
  (sudoku0((31)) /= (0) and then sudoku0((31)) = sudoku0((40))) or else
  (sudoku0((32)) /= (0) and then sudoku0((32)) = sudoku0((40))) or else
  (sudoku0((39)) /= (0) and then sudoku0((39)) = sudoku0((40))) or else
  (sudoku0((30)) /= (0) and then sudoku0((30)) = sudoku0((41))) or else
  (sudoku0((31)) /= (0) and then sudoku0((31)) = sudoku0((41))) or else
  (sudoku0((32)) /= (0) and then sudoku0((32)) = sudoku0((41))) or else
  (sudoku0((39)) /= (0) and then sudoku0((39)) = sudoku0((41))) or else
  (sudoku0((40)) /= (0) and then sudoku0((40)) = sudoku0((41))) or else
  (sudoku0((30)) /= (0) and then sudoku0((30)) = sudoku0((48))) or else
  (sudoku0((31)) /= (0) and then sudoku0((31)) = sudoku0((48))) or else
  (sudoku0((32)) /= (0) and then sudoku0((32)) = sudoku0((48))) or else
  (sudoku0((39)) /= (0) and then sudoku0((39)) = sudoku0((48))) or else
  (sudoku0((40)) /= (0) and then sudoku0((40)) = sudoku0((48))) or else
  (sudoku0((41)) /= (0) and then sudoku0((41)) = sudoku0((48))) or else
  (sudoku0((30)) /= (0) and then sudoku0((30)) = sudoku0((49))) or else
  (sudoku0((31)) /= (0) and then sudoku0((31)) = sudoku0((49))) or else
  (sudoku0((32)) /= (0) and then sudoku0((32)) = sudoku0((49))) or else
  (sudoku0((39)) /= (0) and then sudoku0((39)) = sudoku0((49))) or else
  (sudoku0((40)) /= (0) and then sudoku0((40)) = sudoku0((49))) or else
  (sudoku0((41)) /= (0) and then sudoku0((41)) = sudoku0((49))) or else
  (sudoku0((48)) /= (0) and then sudoku0((48)) = sudoku0((49))) or else
  (sudoku0((30)) /= (0) and then sudoku0((30)) = sudoku0((50))) or else
  (sudoku0((31)) /= (0) and then sudoku0((31)) = sudoku0((50))) or else
  (sudoku0((32)) /= (0) and then sudoku0((32)) = sudoku0((50))) or else
  (sudoku0((39)) /= (0) and then sudoku0((39)) = sudoku0((50))) or else
  (sudoku0((40)) /= (0) and then sudoku0((40)) = sudoku0((50))) or else
  (sudoku0((41)) /= (0) and then sudoku0((41)) = sudoku0((50))) or else
  (sudoku0((48)) /= (0) and then sudoku0((48)) = sudoku0((50))) or else
  (sudoku0((49)) /= (0) and then sudoku0((49)) = sudoku0((50))) or else
  (sudoku0((57)) /= (0) and then sudoku0((57)) = sudoku0((58))) or else
  (sudoku0((57)) /= (0) and then sudoku0((57)) = sudoku0((59))) or else
  (sudoku0((58)) /= (0) and then sudoku0((58)) = sudoku0((59))) or else
  (sudoku0((57)) /= (0) and then sudoku0((57)) = sudoku0((66))) or else
  (sudoku0((58)) /= (0) and then sudoku0((58)) = sudoku0((66))) or else
  (sudoku0((59)) /= (0) and then sudoku0((59)) = sudoku0((66))) or else
  (sudoku0((57)) /= (0) and then sudoku0((57)) = sudoku0((67))) or else
  (sudoku0((58)) /= (0) and then sudoku0((58)) = sudoku0((67))) or else
  (sudoku0((59)) /= (0) and then sudoku0((59)) = sudoku0((67))) or else
  (sudoku0((66)) /= (0) and then sudoku0((66)) = sudoku0((67))) or else
  (sudoku0((57)) /= (0) and then sudoku0((57)) = sudoku0((68))) or else
  (sudoku0((58)) /= (0) and then sudoku0((58)) = sudoku0((68))) or else
  (sudoku0((59)) /= (0) and then sudoku0((59)) = sudoku0((68))) or else
  (sudoku0((66)) /= (0) and then sudoku0((66)) = sudoku0((68))) or else
  (sudoku0((67)) /= (0) and then sudoku0((67)) = sudoku0((68))) or else
  (sudoku0((57)) /= (0) and then sudoku0((57)) = sudoku0((75))) or else
  (sudoku0((58)) /= (0) and then sudoku0((58)) = sudoku0((75))) or else
  (sudoku0((59)) /= (0) and then sudoku0((59)) = sudoku0((75))) or else
  (sudoku0((66)) /= (0) and then sudoku0((66)) = sudoku0((75))) or else
  (sudoku0((67)) /= (0) and then sudoku0((67)) = sudoku0((75))) or else
  (sudoku0((68)) /= (0) and then sudoku0((68)) = sudoku0((75))) or else
  (sudoku0((57)) /= (0) and then sudoku0((57)) = sudoku0((76))) or else
  (sudoku0((58)) /= (0) and then sudoku0((58)) = sudoku0((76))) or else
  (sudoku0((59)) /= (0) and then sudoku0((59)) = sudoku0((76))) or else
  (sudoku0((66)) /= (0) and then sudoku0((66)) = sudoku0((76))) or else
  (sudoku0((67)) /= (0) and then sudoku0((67)) = sudoku0((76))) or else
  (sudoku0((68)) /= (0) and then sudoku0((68)) = sudoku0((76))) or else
  (sudoku0((75)) /= (0) and then sudoku0((75)) = sudoku0((76))) or else
  (sudoku0((57)) /= (0) and then sudoku0((57)) = sudoku0((77))) or else
  (sudoku0((58)) /= (0) and then sudoku0((58)) = sudoku0((77))) or else
  (sudoku0((59)) /= (0) and then sudoku0((59)) = sudoku0((77))) or else
  (sudoku0((66)) /= (0) and then sudoku0((66)) = sudoku0((77))) or else
  (sudoku0((67)) /= (0) and then sudoku0((67)) = sudoku0((77))) or else
  (sudoku0((68)) /= (0) and then sudoku0((68)) = sudoku0((77))) or else
  (sudoku0((75)) /= (0) and then sudoku0((75)) = sudoku0((77))) or else
  (sudoku0((76)) /= (0) and then sudoku0((76)) = sudoku0((77))) or else
  (sudoku0((6)) /= (0) and then sudoku0((6)) = sudoku0((7))) or else
  (sudoku0((6)) /= (0) and then sudoku0((6)) = sudoku0((8))) or else
  (sudoku0((7)) /= (0) and then sudoku0((7)) = sudoku0((8))) or else
  (sudoku0((6)) /= (0) and then sudoku0((6)) = sudoku0((15))) or else
  (sudoku0((7)) /= (0) and then sudoku0((7)) = sudoku0((15))) or else
  (sudoku0((8)) /= (0) and then sudoku0((8)) = sudoku0((15))) or else
  (sudoku0((6)) /= (0) and then sudoku0((6)) = sudoku0((16))) or else
  (sudoku0((7)) /= (0) and then sudoku0((7)) = sudoku0((16))) or else
  (sudoku0((8)) /= (0) and then sudoku0((8)) = sudoku0((16))) or else
  (sudoku0((15)) /= (0) and then sudoku0((15)) = sudoku0((16))) or else
  (sudoku0((6)) /= (0) and then sudoku0((6)) = sudoku0((17))) or else
  (sudoku0((7)) /= (0) and then sudoku0((7)) = sudoku0((17))) or else
  (sudoku0((8)) /= (0) and then sudoku0((8)) = sudoku0((17))) or else
  (sudoku0((15)) /= (0) and then sudoku0((15)) = sudoku0((17))) or else
  (sudoku0((16)) /= (0) and then sudoku0((16)) = sudoku0((17))) or else
  (sudoku0((6)) /= (0) and then sudoku0((6)) = sudoku0((24))) or else
  (sudoku0((7)) /= (0) and then sudoku0((7)) = sudoku0((24))) or else
  (sudoku0((8)) /= (0) and then sudoku0((8)) = sudoku0((24))) or else
  (sudoku0((15)) /= (0) and then sudoku0((15)) = sudoku0((24))) or else
  (sudoku0((16)) /= (0) and then sudoku0((16)) = sudoku0((24))) or else
  (sudoku0((17)) /= (0) and then sudoku0((17)) = sudoku0((24))) or else
  (sudoku0((6)) /= (0) and then sudoku0((6)) = sudoku0((25))) or else
  (sudoku0((7)) /= (0) and then sudoku0((7)) = sudoku0((25))) or else
  (sudoku0((8)) /= (0) and then sudoku0((8)) = sudoku0((25))) or else
  (sudoku0((15)) /= (0) and then sudoku0((15)) = sudoku0((25))) or else
  (sudoku0((16)) /= (0) and then sudoku0((16)) = sudoku0((25))) or else
  (sudoku0((17)) /= (0) and then sudoku0((17)) = sudoku0((25))) or else
  (sudoku0((24)) /= (0) and then sudoku0((24)) = sudoku0((25))) or else
  (sudoku0((6)) /= (0) and then sudoku0((6)) = sudoku0((26))) or else
  (sudoku0((7)) /= (0) and then sudoku0((7)) = sudoku0((26))) or else
  (sudoku0((8)) /= (0) and then sudoku0((8)) = sudoku0((26))) or else
  (sudoku0((15)) /= (0) and then sudoku0((15)) = sudoku0((26))) or else
  (sudoku0((16)) /= (0) and then sudoku0((16)) = sudoku0((26))) or else
  (sudoku0((17)) /= (0) and then sudoku0((17)) = sudoku0((26))) or else
  (sudoku0((24)) /= (0) and then sudoku0((24)) = sudoku0((26))) or else
  (sudoku0((25)) /= (0) and then sudoku0((25)) = sudoku0((26))) or else
  (sudoku0((33)) /= (0) and then sudoku0((33)) = sudoku0((34))) or else
  (sudoku0((33)) /= (0) and then sudoku0((33)) = sudoku0((35))) or else
  (sudoku0((34)) /= (0) and then sudoku0((34)) = sudoku0((35))) or else
  (sudoku0((33)) /= (0) and then sudoku0((33)) = sudoku0((42))) or else
  (sudoku0((34)) /= (0) and then sudoku0((34)) = sudoku0((42))) or else
  (sudoku0((35)) /= (0) and then sudoku0((35)) = sudoku0((42))) or else
  (sudoku0((33)) /= (0) and then sudoku0((33)) = sudoku0((43))) or else
  (sudoku0((34)) /= (0) and then sudoku0((34)) = sudoku0((43))) or else
  (sudoku0((35)) /= (0) and then sudoku0((35)) = sudoku0((43))) or else
  (sudoku0((42)) /= (0) and then sudoku0((42)) = sudoku0((43))) or else
  (sudoku0((33)) /= (0) and then sudoku0((33)) = sudoku0((44))) or else
  (sudoku0((34)) /= (0) and then sudoku0((34)) = sudoku0((44))) or else
  (sudoku0((35)) /= (0) and then sudoku0((35)) = sudoku0((44))) or else
  (sudoku0((42)) /= (0) and then sudoku0((42)) = sudoku0((44))) or else
  (sudoku0((43)) /= (0) and then sudoku0((43)) = sudoku0((44))) or else
  (sudoku0((33)) /= (0) and then sudoku0((33)) = sudoku0((51))) or else
  (sudoku0((34)) /= (0) and then sudoku0((34)) = sudoku0((51))) or else
  (sudoku0((35)) /= (0) and then sudoku0((35)) = sudoku0((51))) or else
  (sudoku0((42)) /= (0) and then sudoku0((42)) = sudoku0((51))) or else
  (sudoku0((43)) /= (0) and then sudoku0((43)) = sudoku0((51))) or else
  (sudoku0((44)) /= (0) and then sudoku0((44)) = sudoku0((51))) or else
  (sudoku0((33)) /= (0) and then sudoku0((33)) = sudoku0((52))) or else
  (sudoku0((34)) /= (0) and then sudoku0((34)) = sudoku0((52))) or else
  (sudoku0((35)) /= (0) and then sudoku0((35)) = sudoku0((52))) or else
  (sudoku0((42)) /= (0) and then sudoku0((42)) = sudoku0((52))) or else
  (sudoku0((43)) /= (0) and then sudoku0((43)) = sudoku0((52))) or else
  (sudoku0((44)) /= (0) and then sudoku0((44)) = sudoku0((52))) or else
  (sudoku0((51)) /= (0) and then sudoku0((51)) = sudoku0((52))) or else
  (sudoku0((33)) /= (0) and then sudoku0((33)) = sudoku0((53))) or else
  (sudoku0((34)) /= (0) and then sudoku0((34)) = sudoku0((53))) or else
  (sudoku0((35)) /= (0) and then sudoku0((35)) = sudoku0((53))) or else
  (sudoku0((42)) /= (0) and then sudoku0((42)) = sudoku0((53))) or else
  (sudoku0((43)) /= (0) and then sudoku0((43)) = sudoku0((53))) or else
  (sudoku0((44)) /= (0) and then sudoku0((44)) = sudoku0((53))) or else
  (sudoku0((51)) /= (0) and then sudoku0((51)) = sudoku0((53))) or else
  (sudoku0((52)) /= (0) and then sudoku0((52)) = sudoku0((53))) or else
  (sudoku0((60)) /= (0) and then sudoku0((60)) = sudoku0((61))) or else
  (sudoku0((60)) /= (0) and then sudoku0((60)) = sudoku0((62))) or else
  (sudoku0((61)) /= (0) and then sudoku0((61)) = sudoku0((62))) or else
  (sudoku0((60)) /= (0) and then sudoku0((60)) = sudoku0((69))) or else
  (sudoku0((61)) /= (0) and then sudoku0((61)) = sudoku0((69))) or else
  (sudoku0((62)) /= (0) and then sudoku0((62)) = sudoku0((69))) or else
  (sudoku0((60)) /= (0) and then sudoku0((60)) = sudoku0((70))) or else
  (sudoku0((61)) /= (0) and then sudoku0((61)) = sudoku0((70))) or else
  (sudoku0((62)) /= (0) and then sudoku0((62)) = sudoku0((70))) or else
  (sudoku0((69)) /= (0) and then sudoku0((69)) = sudoku0((70))) or else
  (sudoku0((60)) /= (0) and then sudoku0((60)) = sudoku0((71))) or else
  (sudoku0((61)) /= (0) and then sudoku0((61)) = sudoku0((71))) or else
  (sudoku0((62)) /= (0) and then sudoku0((62)) = sudoku0((71))) or else
  (sudoku0((69)) /= (0) and then sudoku0((69)) = sudoku0((71))) or else
  (sudoku0((70)) /= (0) and then sudoku0((70)) = sudoku0((71))) or else
  (sudoku0((60)) /= (0) and then sudoku0((60)) = sudoku0((78))) or else
  (sudoku0((61)) /= (0) and then sudoku0((61)) = sudoku0((78))) or else
  (sudoku0((62)) /= (0) and then sudoku0((62)) = sudoku0((78))) or else
  (sudoku0((69)) /= (0) and then sudoku0((69)) = sudoku0((78))) or else
  (sudoku0((70)) /= (0) and then sudoku0((70)) = sudoku0((78))) or else
  (sudoku0((71)) /= (0) and then sudoku0((71)) = sudoku0((78))) or else
  (sudoku0((60)) /= (0) and then sudoku0((60)) = sudoku0((79))) or else
  (sudoku0((61)) /= (0) and then sudoku0((61)) = sudoku0((79))) or else
  (sudoku0((62)) /= (0) and then sudoku0((62)) = sudoku0((79))) or else
  (sudoku0((69)) /= (0) and then sudoku0((69)) = sudoku0((79))) or else
  (sudoku0((70)) /= (0) and then sudoku0((70)) = sudoku0((79))) or else
  (sudoku0((71)) /= (0) and then sudoku0((71)) = sudoku0((79))) or else
  (sudoku0((78)) /= (0) and then sudoku0((78)) = sudoku0((79))) or else
  (sudoku0((60)) /= (0) and then sudoku0((60)) = sudoku0((80))) or else
  (sudoku0((61)) /= (0) and then sudoku0((61)) = sudoku0((80))) or else
  (sudoku0((62)) /= (0) and then sudoku0((62)) = sudoku0((80))) or else
  (sudoku0((69)) /= (0) and then sudoku0((69)) = sudoku0((80))) or else
  (sudoku0((70)) /= (0) and then sudoku0((70)) = sudoku0((80))) or else
  (sudoku0((71)) /= (0) and then sudoku0((71)) = sudoku0((80))) or else
  (sudoku0((78)) /= (0) and then sudoku0((78)) = sudoku0((80))) or else
  (sudoku0((79)) /= (0) and then sudoku0((79)) = sudoku0((80)))
  then
    return FALSE;
  end if;
  if sudoku_done(sudoku0)
  then
    return TRUE;
  end if;
  for i in integer range (0)..(80) loop
    if sudoku0(i) = (0)
    then
      for p in integer range (1)..(9) loop
        sudoku0(i) := p;
        if solve(sudoku0)
        then
          return TRUE;
        end if;
      end loop;
      sudoku0(i) := (0);
      return FALSE;
    end if;
  end loop;
  return FALSE;
end;


  sudoku0 : a_PTR;
begin
  sudoku0 := read_sudoku;
  print_sudoku(sudoku0);
  if solve(sudoku0)
  then
    print_sudoku(sudoku0);
  else
    String'Write (Text_Streams.Stream (Current_Output), "no solution" & Character'Val(10) & "");
  end if;
end;
