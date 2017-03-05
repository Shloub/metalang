object test_enum
{
  
  object Foo_t extends Enumeration {
    type Foo_t = Value;
    val Foo, Bar, Blah = Value
  }
  import Foo_t._
  def main(args : Array[String])
  {
    var foo_val: Foo_t = Foo;
  }
  
}

