<?php

$stdin='';
function stdin_(){   global $stdin; if ( !feof(STDIN)) $stdin.=fgets(STDIN)."\n";}
function scan($format){
 stdin_();
  global $stdin;
  $out = sscanf($stdin, $format);
  $stdin = substr($stdin, strlen($out[0]));
  return $out;
}
function cons(&$list, $i){
  $a = array(
    "head"=>$i,
    "tail"=>$list
  );
  
  $out_ = $a;
  return $out_;
}

function rev2(&$empty, &$acc, &$torev){
  if ($torev == $empty)
    return $acc;
  else
  {
    $b = array(
      "head"=>$torev["head"],
      "tail"=>$acc
    );
    
    $acc2 = $b;
    return rev2($empty, $acc, $torev["tail"]);
  }
}

function rev(&$empty, &$torev){
  return rev2($empty, $empty, $torev);
}

function test(&$empty){
  $list = $empty;
  $i = -1;
  while ($i != 0)
  {
    list($i) = scan("%d");
    if ($i != 0)
      $list = cons($list, $i);
  }
}


?>
