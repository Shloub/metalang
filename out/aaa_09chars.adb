
with ada.text_io, ada.Integer_text_IO, Ada.Text_IO.Text_Streams, Ada.Strings.Fixed;
use ada.text_io, ada.Integer_text_IO, Ada.Strings, Ada.Strings.Fixed;

procedure aaa_09chars is
procedure PString(s : String) is
begin
  String'Write (Text_Streams.Stream (Current_Output), s);
end;
procedure PChar(c : in Character) is
begin
  Character'Write (Text_Streams.Stream (Current_Output), c);
end;
procedure PInt(i : in Integer) is
begin
  String'Write (Text_Streams.Stream (Current_Output), Trim(Integer'Image(i), Left));
end;

begin
  PInt(1);
  PString("=>");
  PChar(Character'Val(1));
  PString(" ");
  PInt(Character'Pos(Character'Val(1)));
  PString(" ");
  PChar(Character'Val(1));
  PString("" & Character'Val(10));
  PInt(2);
  PString("=>");
  PChar(Character'Val(2));
  PString(" ");
  PInt(Character'Pos(Character'Val(2)));
  PString(" ");
  PChar(Character'Val(2));
  PString("" & Character'Val(10));
  PInt(3);
  PString("=>");
  PChar(Character'Val(3));
  PString(" ");
  PInt(Character'Pos(Character'Val(3)));
  PString(" ");
  PChar(Character'Val(3));
  PString("" & Character'Val(10));
  PInt(4);
  PString("=>");
  PChar(Character'Val(4));
  PString(" ");
  PInt(Character'Pos(Character'Val(4)));
  PString(" ");
  PChar(Character'Val(4));
  PString("" & Character'Val(10));
  PInt(5);
  PString("=>");
  PChar(Character'Val(5));
  PString(" ");
  PInt(Character'Pos(Character'Val(5)));
  PString(" ");
  PChar(Character'Val(5));
  PString("" & Character'Val(10));
  PInt(6);
  PString("=>");
  PChar(Character'Val(6));
  PString(" ");
  PInt(Character'Pos(Character'Val(6)));
  PString(" ");
  PChar(Character'Val(6));
  PString("" & Character'Val(10));
  PInt(7);
  PString("=>");
  PChar(Character'Val(7));
  PString(" ");
  PInt(Character'Pos(Character'Val(7)));
  PString(" ");
  PChar(Character'Val(7));
  PString("" & Character'Val(10));
  PInt(8);
  PString("=>");
  PChar(Character'Val(8));
  PString(" ");
  PInt(Character'Pos(Character'Val(8)));
  PString(" ");
  PChar(Character'Val(8));
  PString("" & Character'Val(10));
  PInt(9);
  PString("=>");
  PChar(Character'Val(9));
  PString(" ");
  PInt(Character'Pos(Character'Val(9)));
  PString(" ");
  PChar(Character'Val(9));
  PString("" & Character'Val(10));
  PInt(10);
  PString("=>");
  PChar(Character'Val(10));
  PString(" ");
  PInt(Character'Pos(Character'Val(10)));
  PString(" ");
  PChar(Character'Val(10));
  PString("" & Character'Val(10));
  PInt(11);
  PString("=>");
  PChar(Character'Val(11));
  PString(" ");
  PInt(Character'Pos(Character'Val(11)));
  PString(" ");
  PChar(Character'Val(11));
  PString("" & Character'Val(10));
  PInt(12);
  PString("=>");
  PChar(Character'Val(12));
  PString(" ");
  PInt(Character'Pos(Character'Val(12)));
  PString(" ");
  PChar(Character'Val(12));
  PString("" & Character'Val(10));
  PInt(13);
  PString("=>");
  PChar(Character'Val(13));
  PString(" ");
  PInt(Character'Pos(Character'Val(13)));
  PString(" ");
  PChar(Character'Val(13));
  PString("" & Character'Val(10));
  PInt(14);
  PString("=>");
  PChar(Character'Val(14));
  PString(" ");
  PInt(Character'Pos(Character'Val(14)));
  PString(" ");
  PChar(Character'Val(14));
  PString("" & Character'Val(10));
  PInt(15);
  PString("=>");
  PChar(Character'Val(15));
  PString(" ");
  PInt(Character'Pos(Character'Val(15)));
  PString(" ");
  PChar(Character'Val(15));
  PString("" & Character'Val(10));
  PInt(16);
  PString("=>");
  PChar(Character'Val(16));
  PString(" ");
  PInt(Character'Pos(Character'Val(16)));
  PString(" ");
  PChar(Character'Val(16));
  PString("" & Character'Val(10));
  PInt(17);
  PString("=>");
  PChar(Character'Val(17));
  PString(" ");
  PInt(Character'Pos(Character'Val(17)));
  PString(" ");
  PChar(Character'Val(17));
  PString("" & Character'Val(10));
  PInt(18);
  PString("=>");
  PChar(Character'Val(18));
  PString(" ");
  PInt(Character'Pos(Character'Val(18)));
  PString(" ");
  PChar(Character'Val(18));
  PString("" & Character'Val(10));
  PInt(19);
  PString("=>");
  PChar(Character'Val(19));
  PString(" ");
  PInt(Character'Pos(Character'Val(19)));
  PString(" ");
  PChar(Character'Val(19));
  PString("" & Character'Val(10));
  PInt(20);
  PString("=>");
  PChar(Character'Val(20));
  PString(" ");
  PInt(Character'Pos(Character'Val(20)));
  PString(" ");
  PChar(Character'Val(20));
  PString("" & Character'Val(10));
  PInt(21);
  PString("=>");
  PChar(Character'Val(21));
  PString(" ");
  PInt(Character'Pos(Character'Val(21)));
  PString(" ");
  PChar(Character'Val(21));
  PString("" & Character'Val(10));
  PInt(22);
  PString("=>");
  PChar(Character'Val(22));
  PString(" ");
  PInt(Character'Pos(Character'Val(22)));
  PString(" ");
  PChar(Character'Val(22));
  PString("" & Character'Val(10));
  PInt(23);
  PString("=>");
  PChar(Character'Val(23));
  PString(" ");
  PInt(Character'Pos(Character'Val(23)));
  PString(" ");
  PChar(Character'Val(23));
  PString("" & Character'Val(10));
  PInt(24);
  PString("=>");
  PChar(Character'Val(24));
  PString(" ");
  PInt(Character'Pos(Character'Val(24)));
  PString(" ");
  PChar(Character'Val(24));
  PString("" & Character'Val(10));
  PInt(25);
  PString("=>");
  PChar(Character'Val(25));
  PString(" ");
  PInt(Character'Pos(Character'Val(25)));
  PString(" ");
  PChar(Character'Val(25));
  PString("" & Character'Val(10));
  PInt(26);
  PString("=>");
  PChar(Character'Val(26));
  PString(" ");
  PInt(Character'Pos(Character'Val(26)));
  PString(" ");
  PChar(Character'Val(26));
  PString("" & Character'Val(10));
  PInt(27);
  PString("=>");
  PChar(Character'Val(27));
  PString(" ");
  PInt(Character'Pos(Character'Val(27)));
  PString(" ");
  PChar(Character'Val(27));
  PString("" & Character'Val(10));
  PInt(28);
  PString("=>");
  PChar(Character'Val(28));
  PString(" ");
  PInt(Character'Pos(Character'Val(28)));
  PString(" ");
  PChar(Character'Val(28));
  PString("" & Character'Val(10));
  PInt(29);
  PString("=>");
  PChar(Character'Val(29));
  PString(" ");
  PInt(Character'Pos(Character'Val(29)));
  PString(" ");
  PChar(Character'Val(29));
  PString("" & Character'Val(10));
  PInt(30);
  PString("=>");
  PChar(Character'Val(30));
  PString(" ");
  PInt(Character'Pos(Character'Val(30)));
  PString(" ");
  PChar(Character'Val(30));
  PString("" & Character'Val(10));
  PInt(31);
  PString("=>");
  PChar(Character'Val(31));
  PString(" ");
  PInt(Character'Pos(Character'Val(31)));
  PString(" ");
  PChar(Character'Val(31));
  PString("" & Character'Val(10));
  PInt(32);
  PString("=>");
  PChar(' ');
  PString(" ");
  PInt(Character'Pos(' '));
  PString(" ");
  PChar(Character'Val(32));
  PString("" & Character'Val(10));
  PInt(33);
  PString("=>");
  PChar('!');
  PString(" ");
  PInt(Character'Pos('!'));
  PString(" ");
  PChar(Character'Val(33));
  PString("" & Character'Val(10));
  PInt(34);
  PString("=>");
  PChar('"');
  PString(" ");
  PInt(Character'Pos('"'));
  PString(" ");
  PChar(Character'Val(34));
  PString("" & Character'Val(10));
  PInt(35);
  PString("=>");
  PChar('#');
  PString(" ");
  PInt(Character'Pos('#'));
  PString(" ");
  PChar(Character'Val(35));
  PString("" & Character'Val(10));
  PInt(36);
  PString("=>");
  PChar('$');
  PString(" ");
  PInt(Character'Pos('$'));
  PString(" ");
  PChar(Character'Val(36));
  PString("" & Character'Val(10));
  PInt(37);
  PString("=>");
  PChar('%');
  PString(" ");
  PInt(Character'Pos('%'));
  PString(" ");
  PChar(Character'Val(37));
  PString("" & Character'Val(10));
  PInt(38);
  PString("=>");
  PChar('&');
  PString(" ");
  PInt(Character'Pos('&'));
  PString(" ");
  PChar(Character'Val(38));
  PString("" & Character'Val(10));
  PInt(39);
  PString("=>");
  PChar(Character'Val(39));
  PString(" ");
  PInt(Character'Pos(Character'Val(39)));
  PString(" ");
  PChar(Character'Val(39));
  PString("" & Character'Val(10));
  PInt(40);
  PString("=>");
  PChar('(');
  PString(" ");
  PInt(Character'Pos('('));
  PString(" ");
  PChar(Character'Val(40));
  PString("" & Character'Val(10));
  PInt(41);
  PString("=>");
  PChar(')');
  PString(" ");
  PInt(Character'Pos(')'));
  PString(" ");
  PChar(Character'Val(41));
  PString("" & Character'Val(10));
  PInt(42);
  PString("=>");
  PChar('*');
  PString(" ");
  PInt(Character'Pos('*'));
  PString(" ");
  PChar(Character'Val(42));
  PString("" & Character'Val(10));
  PInt(43);
  PString("=>");
  PChar('+');
  PString(" ");
  PInt(Character'Pos('+'));
  PString(" ");
  PChar(Character'Val(43));
  PString("" & Character'Val(10));
  PInt(44);
  PString("=>");
  PChar(',');
  PString(" ");
  PInt(Character'Pos(','));
  PString(" ");
  PChar(Character'Val(44));
  PString("" & Character'Val(10));
  PInt(45);
  PString("=>");
  PChar('-');
  PString(" ");
  PInt(Character'Pos('-'));
  PString(" ");
  PChar(Character'Val(45));
  PString("" & Character'Val(10));
  PInt(46);
  PString("=>");
  PChar('.');
  PString(" ");
  PInt(Character'Pos('.'));
  PString(" ");
  PChar(Character'Val(46));
  PString("" & Character'Val(10));
  PInt(47);
  PString("=>");
  PChar('/');
  PString(" ");
  PInt(Character'Pos('/'));
  PString(" ");
  PChar(Character'Val(47));
  PString("" & Character'Val(10));
  PInt(48);
  PString("=>");
  PChar('0');
  PString(" ");
  PInt(Character'Pos('0'));
  PString(" ");
  PChar(Character'Val(48));
  PString("" & Character'Val(10));
  PInt(49);
  PString("=>");
  PChar('1');
  PString(" ");
  PInt(Character'Pos('1'));
  PString(" ");
  PChar(Character'Val(49));
  PString("" & Character'Val(10));
  PInt(50);
  PString("=>");
  PChar('2');
  PString(" ");
  PInt(Character'Pos('2'));
  PString(" ");
  PChar(Character'Val(50));
  PString("" & Character'Val(10));
  PInt(51);
  PString("=>");
  PChar('3');
  PString(" ");
  PInt(Character'Pos('3'));
  PString(" ");
  PChar(Character'Val(51));
  PString("" & Character'Val(10));
  PInt(52);
  PString("=>");
  PChar('4');
  PString(" ");
  PInt(Character'Pos('4'));
  PString(" ");
  PChar(Character'Val(52));
  PString("" & Character'Val(10));
  PInt(53);
  PString("=>");
  PChar('5');
  PString(" ");
  PInt(Character'Pos('5'));
  PString(" ");
  PChar(Character'Val(53));
  PString("" & Character'Val(10));
  PInt(54);
  PString("=>");
  PChar('6');
  PString(" ");
  PInt(Character'Pos('6'));
  PString(" ");
  PChar(Character'Val(54));
  PString("" & Character'Val(10));
  PInt(55);
  PString("=>");
  PChar('7');
  PString(" ");
  PInt(Character'Pos('7'));
  PString(" ");
  PChar(Character'Val(55));
  PString("" & Character'Val(10));
  PInt(56);
  PString("=>");
  PChar('8');
  PString(" ");
  PInt(Character'Pos('8'));
  PString(" ");
  PChar(Character'Val(56));
  PString("" & Character'Val(10));
  PInt(57);
  PString("=>");
  PChar('9');
  PString(" ");
  PInt(Character'Pos('9'));
  PString(" ");
  PChar(Character'Val(57));
  PString("" & Character'Val(10));
  PInt(58);
  PString("=>");
  PChar(':');
  PString(" ");
  PInt(Character'Pos(':'));
  PString(" ");
  PChar(Character'Val(58));
  PString("" & Character'Val(10));
  PInt(59);
  PString("=>");
  PChar(';');
  PString(" ");
  PInt(Character'Pos(';'));
  PString(" ");
  PChar(Character'Val(59));
  PString("" & Character'Val(10));
  PInt(60);
  PString("=>");
  PChar('<');
  PString(" ");
  PInt(Character'Pos('<'));
  PString(" ");
  PChar(Character'Val(60));
  PString("" & Character'Val(10));
  PInt(61);
  PString("=>");
  PChar('=');
  PString(" ");
  PInt(Character'Pos('='));
  PString(" ");
  PChar(Character'Val(61));
  PString("" & Character'Val(10));
  PInt(62);
  PString("=>");
  PChar('>');
  PString(" ");
  PInt(Character'Pos('>'));
  PString(" ");
  PChar(Character'Val(62));
  PString("" & Character'Val(10));
  PInt(63);
  PString("=>");
  PChar('?');
  PString(" ");
  PInt(Character'Pos('?'));
  PString(" ");
  PChar(Character'Val(63));
  PString("" & Character'Val(10));
  PInt(64);
  PString("=>");
  PChar('@');
  PString(" ");
  PInt(Character'Pos('@'));
  PString(" ");
  PChar(Character'Val(64));
  PString("" & Character'Val(10));
  PInt(65);
  PString("=>");
  PChar('A');
  PString(" ");
  PInt(Character'Pos('A'));
  PString(" ");
  PChar(Character'Val(65));
  PString("" & Character'Val(10));
  PInt(66);
  PString("=>");
  PChar('B');
  PString(" ");
  PInt(Character'Pos('B'));
  PString(" ");
  PChar(Character'Val(66));
  PString("" & Character'Val(10));
  PInt(67);
  PString("=>");
  PChar('C');
  PString(" ");
  PInt(Character'Pos('C'));
  PString(" ");
  PChar(Character'Val(67));
  PString("" & Character'Val(10));
  PInt(68);
  PString("=>");
  PChar('D');
  PString(" ");
  PInt(Character'Pos('D'));
  PString(" ");
  PChar(Character'Val(68));
  PString("" & Character'Val(10));
  PInt(69);
  PString("=>");
  PChar('E');
  PString(" ");
  PInt(Character'Pos('E'));
  PString(" ");
  PChar(Character'Val(69));
  PString("" & Character'Val(10));
  PInt(70);
  PString("=>");
  PChar('F');
  PString(" ");
  PInt(Character'Pos('F'));
  PString(" ");
  PChar(Character'Val(70));
  PString("" & Character'Val(10));
  PInt(71);
  PString("=>");
  PChar('G');
  PString(" ");
  PInt(Character'Pos('G'));
  PString(" ");
  PChar(Character'Val(71));
  PString("" & Character'Val(10));
  PInt(72);
  PString("=>");
  PChar('H');
  PString(" ");
  PInt(Character'Pos('H'));
  PString(" ");
  PChar(Character'Val(72));
  PString("" & Character'Val(10));
  PInt(73);
  PString("=>");
  PChar('I');
  PString(" ");
  PInt(Character'Pos('I'));
  PString(" ");
  PChar(Character'Val(73));
  PString("" & Character'Val(10));
  PInt(74);
  PString("=>");
  PChar('J');
  PString(" ");
  PInt(Character'Pos('J'));
  PString(" ");
  PChar(Character'Val(74));
  PString("" & Character'Val(10));
  PInt(75);
  PString("=>");
  PChar('K');
  PString(" ");
  PInt(Character'Pos('K'));
  PString(" ");
  PChar(Character'Val(75));
  PString("" & Character'Val(10));
  PInt(76);
  PString("=>");
  PChar('L');
  PString(" ");
  PInt(Character'Pos('L'));
  PString(" ");
  PChar(Character'Val(76));
  PString("" & Character'Val(10));
  PInt(77);
  PString("=>");
  PChar('M');
  PString(" ");
  PInt(Character'Pos('M'));
  PString(" ");
  PChar(Character'Val(77));
  PString("" & Character'Val(10));
  PInt(78);
  PString("=>");
  PChar('N');
  PString(" ");
  PInt(Character'Pos('N'));
  PString(" ");
  PChar(Character'Val(78));
  PString("" & Character'Val(10));
  PInt(79);
  PString("=>");
  PChar('O');
  PString(" ");
  PInt(Character'Pos('O'));
  PString(" ");
  PChar(Character'Val(79));
  PString("" & Character'Val(10));
  PInt(80);
  PString("=>");
  PChar('P');
  PString(" ");
  PInt(Character'Pos('P'));
  PString(" ");
  PChar(Character'Val(80));
  PString("" & Character'Val(10));
  PInt(81);
  PString("=>");
  PChar('Q');
  PString(" ");
  PInt(Character'Pos('Q'));
  PString(" ");
  PChar(Character'Val(81));
  PString("" & Character'Val(10));
  PInt(82);
  PString("=>");
  PChar('R');
  PString(" ");
  PInt(Character'Pos('R'));
  PString(" ");
  PChar(Character'Val(82));
  PString("" & Character'Val(10));
  PInt(83);
  PString("=>");
  PChar('S');
  PString(" ");
  PInt(Character'Pos('S'));
  PString(" ");
  PChar(Character'Val(83));
  PString("" & Character'Val(10));
  PInt(84);
  PString("=>");
  PChar('T');
  PString(" ");
  PInt(Character'Pos('T'));
  PString(" ");
  PChar(Character'Val(84));
  PString("" & Character'Val(10));
  PInt(85);
  PString("=>");
  PChar('U');
  PString(" ");
  PInt(Character'Pos('U'));
  PString(" ");
  PChar(Character'Val(85));
  PString("" & Character'Val(10));
  PInt(86);
  PString("=>");
  PChar('V');
  PString(" ");
  PInt(Character'Pos('V'));
  PString(" ");
  PChar(Character'Val(86));
  PString("" & Character'Val(10));
  PInt(87);
  PString("=>");
  PChar('W');
  PString(" ");
  PInt(Character'Pos('W'));
  PString(" ");
  PChar(Character'Val(87));
  PString("" & Character'Val(10));
  PInt(88);
  PString("=>");
  PChar('X');
  PString(" ");
  PInt(Character'Pos('X'));
  PString(" ");
  PChar(Character'Val(88));
  PString("" & Character'Val(10));
  PInt(89);
  PString("=>");
  PChar('Y');
  PString(" ");
  PInt(Character'Pos('Y'));
  PString(" ");
  PChar(Character'Val(89));
  PString("" & Character'Val(10));
  PInt(90);
  PString("=>");
  PChar('Z');
  PString(" ");
  PInt(Character'Pos('Z'));
  PString(" ");
  PChar(Character'Val(90));
  PString("" & Character'Val(10));
  PInt(91);
  PString("=>");
  PChar('[');
  PString(" ");
  PInt(Character'Pos('['));
  PString(" ");
  PChar(Character'Val(91));
  PString("" & Character'Val(10));
  PInt(92);
  PString("=>");
  PChar(Character'Val(92));
  PString(" ");
  PInt(Character'Pos(Character'Val(92)));
  PString(" ");
  PChar(Character'Val(92));
  PString("" & Character'Val(10));
  PInt(93);
  PString("=>");
  PChar(']');
  PString(" ");
  PInt(Character'Pos(']'));
  PString(" ");
  PChar(Character'Val(93));
  PString("" & Character'Val(10));
  PInt(94);
  PString("=>");
  PChar('^');
  PString(" ");
  PInt(Character'Pos('^'));
  PString(" ");
  PChar(Character'Val(94));
  PString("" & Character'Val(10));
  PInt(95);
  PString("=>");
  PChar('_');
  PString(" ");
  PInt(Character'Pos('_'));
  PString(" ");
  PChar(Character'Val(95));
  PString("" & Character'Val(10));
  PInt(96);
  PString("=>");
  PChar('`');
  PString(" ");
  PInt(Character'Pos('`'));
  PString(" ");
  PChar(Character'Val(96));
  PString("" & Character'Val(10));
  PInt(97);
  PString("=>");
  PChar('a');
  PString(" ");
  PInt(Character'Pos('a'));
  PString(" ");
  PChar(Character'Val(97));
  PString("" & Character'Val(10));
  PInt(98);
  PString("=>");
  PChar('b');
  PString(" ");
  PInt(Character'Pos('b'));
  PString(" ");
  PChar(Character'Val(98));
  PString("" & Character'Val(10));
  PInt(99);
  PString("=>");
  PChar('c');
  PString(" ");
  PInt(Character'Pos('c'));
  PString(" ");
  PChar(Character'Val(99));
  PString("" & Character'Val(10));
  PInt(100);
  PString("=>");
  PChar('d');
  PString(" ");
  PInt(Character'Pos('d'));
  PString(" ");
  PChar(Character'Val(100));
  PString("" & Character'Val(10));
  PInt(101);
  PString("=>");
  PChar('e');
  PString(" ");
  PInt(Character'Pos('e'));
  PString(" ");
  PChar(Character'Val(101));
  PString("" & Character'Val(10));
  PInt(102);
  PString("=>");
  PChar('f');
  PString(" ");
  PInt(Character'Pos('f'));
  PString(" ");
  PChar(Character'Val(102));
  PString("" & Character'Val(10));
  PInt(103);
  PString("=>");
  PChar('g');
  PString(" ");
  PInt(Character'Pos('g'));
  PString(" ");
  PChar(Character'Val(103));
  PString("" & Character'Val(10));
  PInt(104);
  PString("=>");
  PChar('h');
  PString(" ");
  PInt(Character'Pos('h'));
  PString(" ");
  PChar(Character'Val(104));
  PString("" & Character'Val(10));
  PInt(105);
  PString("=>");
  PChar('i');
  PString(" ");
  PInt(Character'Pos('i'));
  PString(" ");
  PChar(Character'Val(105));
  PString("" & Character'Val(10));
  PInt(106);
  PString("=>");
  PChar('j');
  PString(" ");
  PInt(Character'Pos('j'));
  PString(" ");
  PChar(Character'Val(106));
  PString("" & Character'Val(10));
  PInt(107);
  PString("=>");
  PChar('k');
  PString(" ");
  PInt(Character'Pos('k'));
  PString(" ");
  PChar(Character'Val(107));
  PString("" & Character'Val(10));
  PInt(108);
  PString("=>");
  PChar('l');
  PString(" ");
  PInt(Character'Pos('l'));
  PString(" ");
  PChar(Character'Val(108));
  PString("" & Character'Val(10));
  PInt(109);
  PString("=>");
  PChar('m');
  PString(" ");
  PInt(Character'Pos('m'));
  PString(" ");
  PChar(Character'Val(109));
  PString("" & Character'Val(10));
  PInt(110);
  PString("=>");
  PChar('n');
  PString(" ");
  PInt(Character'Pos('n'));
  PString(" ");
  PChar(Character'Val(110));
  PString("" & Character'Val(10));
  PInt(111);
  PString("=>");
  PChar('o');
  PString(" ");
  PInt(Character'Pos('o'));
  PString(" ");
  PChar(Character'Val(111));
  PString("" & Character'Val(10));
  PInt(112);
  PString("=>");
  PChar('p');
  PString(" ");
  PInt(Character'Pos('p'));
  PString(" ");
  PChar(Character'Val(112));
  PString("" & Character'Val(10));
  PInt(113);
  PString("=>");
  PChar('q');
  PString(" ");
  PInt(Character'Pos('q'));
  PString(" ");
  PChar(Character'Val(113));
  PString("" & Character'Val(10));
  PInt(114);
  PString("=>");
  PChar('r');
  PString(" ");
  PInt(Character'Pos('r'));
  PString(" ");
  PChar(Character'Val(114));
  PString("" & Character'Val(10));
  PInt(115);
  PString("=>");
  PChar('s');
  PString(" ");
  PInt(Character'Pos('s'));
  PString(" ");
  PChar(Character'Val(115));
  PString("" & Character'Val(10));
  PInt(116);
  PString("=>");
  PChar('t');
  PString(" ");
  PInt(Character'Pos('t'));
  PString(" ");
  PChar(Character'Val(116));
  PString("" & Character'Val(10));
  PInt(117);
  PString("=>");
  PChar('u');
  PString(" ");
  PInt(Character'Pos('u'));
  PString(" ");
  PChar(Character'Val(117));
  PString("" & Character'Val(10));
  PInt(118);
  PString("=>");
  PChar('v');
  PString(" ");
  PInt(Character'Pos('v'));
  PString(" ");
  PChar(Character'Val(118));
  PString("" & Character'Val(10));
  PInt(119);
  PString("=>");
  PChar('w');
  PString(" ");
  PInt(Character'Pos('w'));
  PString(" ");
  PChar(Character'Val(119));
  PString("" & Character'Val(10));
  PInt(120);
  PString("=>");
  PChar('x');
  PString(" ");
  PInt(Character'Pos('x'));
  PString(" ");
  PChar(Character'Val(120));
  PString("" & Character'Val(10));
  PInt(121);
  PString("=>");
  PChar('y');
  PString(" ");
  PInt(Character'Pos('y'));
  PString(" ");
  PChar(Character'Val(121));
  PString("" & Character'Val(10));
  PInt(122);
  PString("=>");
  PChar('z');
  PString(" ");
  PInt(Character'Pos('z'));
  PString(" ");
  PChar(Character'Val(122));
  PString("" & Character'Val(10));
  PInt(123);
  PString("=>");
  PChar('{');
  PString(" ");
  PInt(Character'Pos('{'));
  PString(" ");
  PChar(Character'Val(123));
  PString("" & Character'Val(10));
  PInt(124);
  PString("=>");
  PChar('|');
  PString(" ");
  PInt(Character'Pos('|'));
  PString(" ");
  PChar(Character'Val(124));
  PString("" & Character'Val(10));
  PInt(125);
  PString("=>");
  PChar('}');
  PString(" ");
  PInt(Character'Pos('}'));
  PString(" ");
  PChar(Character'Val(125));
  PString("" & Character'Val(10));
  PInt(126);
  PString("=>");
  PChar('~');
  PString(" ");
  PInt(Character'Pos('~'));
  PString(" ");
  PChar(Character'Val(126));
  PString("" & Character'Val(10));
  PInt(127);
  PString("=>");
  PChar(Character'Val(127));
  PString(" ");
  PInt(Character'Pos(Character'Val(127)));
  PString(" ");
  PChar(Character'Val(127));
  PString("" & Character'Val(10));
end;
