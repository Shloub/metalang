<?php

function f(&$tuple_){
  $c = $tuple_;
  $a = $c["tuple_int_int_field_0"];
  $b = $c["tuple_int_int_field_1"];
  $d = array(
    "tuple_int_int_field_0"=>$a + 1,
    "tuple_int_int_field_1"=>$b + 1
  );
  
  return $d;
}

$e = array(
  "tuple_int_int_field_0"=>0,
  "tuple_int_int_field_1"=>1
);

$t = f($e);
?>
