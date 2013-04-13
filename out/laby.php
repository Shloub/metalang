<?php



function can_open_right(&$state, $x, $y){
  return ($x < ($state["sizeX"] - 1)) && $state["cases"][$x + 1][$y]["free"];
}

function can_open_left(&$state, $x, $y){
  return ($x > 0) && $state["cases"][$x - 1][$y]["free"];
}

function can_open_bottom(&$state, $x, $y){
  return ($y < ($state["sizeY"] - 1)) && $state["cases"][$x][$y + 1]["free"];
}

function can_open_top(&$state, $x, $y){
  return ($y > 0) && $state["cases"][$x][$y - 1]["free"];
}

function open_left(&$state, $x, $y){
  $state["cases"][$x - 1][$y]["right"] = false;
  $state["cases"][$x][$y]["left"] = false;
  $state["cases"][$x - 1][$y]["free"] = false;
  $state["cases"][$x][$y]["free"] = false;
}

function open_right(&$state, $x, $y){
  $state["cases"][$x][$y]["right"] = false;
  $state["cases"][$x + 1][$y]["left"] = false;
  $state["cases"][$x][$y]["free"] = false;
  $state["cases"][$x + 1][$y]["free"] = false;
}

function open_top(&$state, $x, $y){
  $state["cases"][$x][$y - 1]["bottom"] = false;
  $state["cases"][$x][$y]["top"] = false;
  $state["cases"][$x][$y - 1]["free"] = false;
  $state["cases"][$x][$y]["free"] = false;
}

function open_bottom(&$state, $x, $y){
  $state["cases"][$x][$y + 1]["top"] = false;
  $state["cases"][$x][$y]["bottom"] = false;
  $state["cases"][$x][$y + 1]["free"] = false;
  $state["cases"][$x][$y]["free"] = false;
}

function init($x, $y){
  $cases = array();
  for ($i = 0 ; $i <= $x - 1; $i++)
  {
    $cases_x = array();
    for ($j = 0 ; $j <= $y - 1; $j++)
    {
      $reco = array(
        "left"=>true,
        "right"=>true,
        "top"=>true,
        "bottom"=>true,
        "free"=>true
      );
      
      $cases_x[$j] = $reco;
    }
    $cases[$i] = $cases_x;
  }
  $out_ = array(
    "sizeX"=>$x,
    "sizeY"=>$y,
    "cases"=>$cases
  );
  
  return $out_;
}

function print_lab(&$l){
  for ($x = 0 ; $x <= $l["sizeX"] - 1; $x++)
  {
    printf("%s", "__");
  }
  printf("%s", "\n");
  for ($y = 0 ; $y <= $l["sizeY"] - 1; $y++)
  {
    for ($x = 0 ; $x <= $l["sizeX"] - 1; $x++)
    {
      if ($l["cases"][$x][$y]["left"])
      {
        if ($l["cases"][$x][$y]["bottom"])
        {
          printf("%s", "|_");
        }
        else
        {
          printf("%s", "| ");
        }
      }
      else if ($l["cases"][$x][$y]["bottom"])
      {
        printf("%s", "__");
      }
      else
      {
        printf("%s", "  ");
      }
    }
    printf("%s", "|\n");
  }
  printf("%s", "\n");
}

function gen(&$lab, $x, $y){
  $m = 4;
  $order = array();
  for ($i = 0 ; $i <= $m - 1; $i++)
  {
    $order[$i] = $i;
  }
  for ($i = 0 ; $i <= 2; $i++)
  {
    $j = mt_rand(0, 4 -
$i - 1);
    $k = $order[$i];
    $order[$i] = $order[$j];
    $order[$j] = $k;
  }
  for ($i = 0 ; $i <= 3; $i++)
  {
    if ((0 == $order[$i]) && can_open_left($lab, $x, $y))
    {
      open_left($lab, $x, $y);
      gen($lab, $x - 1, $y);
    }
    if ((1 == $order[$i]) && can_open_right($lab, $x, $y))
    {
      open_right($lab, $x, $y);
      gen($lab, $x + 1, $y);
    }
    if ((2 == $order[$i]) && can_open_top($lab, $x, $y))
    {
      open_top($lab, $x, $y);
      gen($lab, $x, $y - 1);
    }
    if ((3 == $order[$i]) && can_open_bottom($lab, $x, $y))
    {
      open_bottom($lab, $x, $y);
      gen($lab, $x, $y + 1);
    }
  }
}


$stdin='';
while (!feof(STDIN)) $stdin.=fgets(STDIN);
function scan($format){
  global $stdin;
  $out = sscanf($stdin, $format);
  $stdin = substr($stdin, strlen($out[0]));
  return $out;
}
function scantrim(){
  global $stdin;
  $stdin = trim($stdin);
}
function nextChar(){
  global $stdin;
  $out = $stdin[0];
  $stdin = substr($stdin, 1);
  return $out;
}

$lab = init(10, 10);
gen($lab, 0, 0);
print_lab($lab);
?>
