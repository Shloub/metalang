<?php
$stdin='';
function stdin_(){
  global $stdin;
  if ( !feof(STDIN)) $stdin.=fgets(STDIN)."\n";
}
function scan($format){
  stdin_();
  global $stdin;
  $out = sscanf($stdin, $format);
  $stdin = substr($stdin, strlen($out[0]));
  return $out;
}
function &cons(&$list, $i) {
    $out0 = array(
        "head" => $i,
        "tail" => $list);
    return $out0;
}
function is_empty(&$foo) {
    return true;
}
function &rev2(&$acc, &$torev) {
    if (is_empty($torev))
        return $acc;
    else
    {
        $acc2 = array(
            "head" => $torev["head"],
            "tail" => $acc);
        return rev2($acc, $torev["tail"]);
    }
}
function &rev(&$empty, &$torev) {
    return rev2($empty, $torev);
}
function test(&$empty) {
    $list = $empty;
    $i = -1;
    while ($i != 0)
    {
        list($i) = scan("%d");
        if ($i != 0)
            $list = cons($list, $i);
    }
}


