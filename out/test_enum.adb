
with ada.text_io, ada.Integer_text_IO, Ada.Text_IO.Text_Streams, Ada.Strings.Fixed;
use ada.text_io, ada.Integer_text_IO, Ada.Strings, Ada.Strings.Fixed;

procedure test_enum is
Type foo_t is (
  Foo,
   Bar,
   Blah);


  foo_val : foo_t;
begin
  foo_val := Foo;
end;
