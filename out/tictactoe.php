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
function scantrim(){
  global $stdin;
  while(true){
    $stdin = ltrim($stdin);
    if ($stdin != '' || feof(STDIN)) break;
    stdin_();
  }
}
/*
Tictactoe : un tictactoe avec une IA
*/
/* La structure de donnée */

/* Un Mouvement */

/* On affiche l'état */
function print_state(&$g) {
    echo "\n|";
    for ($y = 0; $y <= 2; $y += 1)
    {
        for ($x = 0; $x <= 2; $x += 1)
        {
            if ($g["cases"][$x][$y] == 0)
                echo " ";
            else if ($g["cases"][$x][$y] == 1)
                echo "O";
            else
                echo "X";
            echo "|";
        }
        if ($y != 2)
            echo "\n|-|-|-|\n|";
    }
    echo "\n";
}

/* On dit qui gagne (info stoquées dans g.ended et g.note ) */
function eval0(&$g) {
    $win = 0;
    $freecase = 0;
    for ($y = 0; $y <= 2; $y += 1)
    {
        $col = -1;
        $lin = -1;
        for ($x = 0; $x <= 2; $x += 1)
        {
            if ($g["cases"][$x][$y] == 0)
                $freecase += 1;
            $colv = $g["cases"][$x][$y];
            $linv = $g["cases"][$y][$x];
            if ($col == -1 && $colv != 0)
                $col = $colv;
            else if ($colv != $col)
                $col = -2;
            if ($lin == -1 && $linv != 0)
                $lin = $linv;
            else if ($linv != $lin)
                $lin = -2;
        }
        if ($col >= 0)
            $win = $col;
        else if ($lin >= 0)
            $win = $lin;
    }
    for ($x = 1; $x <= 2; $x += 1)
    {
        if ($g["cases"][0][0] == $x && $g["cases"][1][1] == $x && $g["cases"][2][2] == $x)
            $win = $x;
        if ($g["cases"][0][2] == $x && $g["cases"][1][1] == $x && $g["cases"][2][0] == $x)
            $win = $x;
    }
    $g["ended"] = $win != 0 || $freecase == 0;
    if ($win == 1)
        $g["note"] = 1000;
    else if ($win == 2)
        $g["note"] = -1000;
    else
        $g["note"] = 0;
}

/* On applique un mouvement */
function apply_move_xy($x, $y, &$g) {
    $player = 2;
    if ($g["firstToPlay"])
        $player = 1;
    $g["cases"][$x][$y] = $player;
    $g["firstToPlay"] = !$g["firstToPlay"];
}

function apply_move(&$m, &$g) {
    apply_move_xy($m["x"], $m["y"], $g);
}

function cancel_move_xy($x, $y, &$g) {
    $g["cases"][$x][$y] = 0;
    $g["firstToPlay"] = !$g["firstToPlay"];
    $g["ended"] = false;
}

function cancel_move(&$m, &$g) {
    cancel_move_xy($m["x"], $m["y"], $g);
}

function can_move_xy($x, $y, &$g) {
    return $g["cases"][$x][$y] == 0;
}

function can_move(&$m, &$g) {
    return can_move_xy($m["x"], $m["y"], $g);
}

/*
Un minimax classique, renvoie la note du plateau
*/
function minmax(&$g) {
    eval0($g);
    if ($g["ended"])
        return $g["note"];
    $maxNote = -10000;
    if (!$g["firstToPlay"])
        $maxNote = 10000;
    for ($x = 0; $x <= 2; $x += 1)
        for ($y = 0; $y <= 2; $y += 1)
            if (can_move_xy($x, $y, $g))
            {
                apply_move_xy($x, $y, $g);
                $currentNote = minmax($g);
                cancel_move_xy($x, $y, $g);
                /* Minimum ou Maximum selon le coté ou l'on joue*/
                if ($currentNote > $maxNote == $g["firstToPlay"])
                    $maxNote = $currentNote;
            }
    return $maxNote;
}

/*
Renvoie le coup de l'IA
*/
function &play(&$g) {
    $minMove = array(
        "x" => 0,
        "y" => 0);
    $minNote = 10000;
    for ($x = 0; $x <= 2; $x += 1)
        for ($y = 0; $y <= 2; $y += 1)
            if (can_move_xy($x, $y, $g))
            {
                apply_move_xy($x, $y, $g);
                $currentNote = minmax($g);
                echo $x, ", ", $y, ", ", $currentNote, "\n";
                cancel_move_xy($x, $y, $g);
                if ($currentNote < $minNote)
                {
                    $minNote = $currentNote;
                    $minMove["x"] = $x;
                    $minMove["y"] = $y;
                }
            }
    echo $minMove["x"], $minMove["y"], "\n";
    return $minMove;
}

function &init0() {
    $cases = array();
    for ($i = 0; $i < 3; $i += 1)
    {
        $tab = array_fill(0, 3, 0);
        $cases[$i] = $tab;
    }
    $a = array(
        "cases" => $cases,
        "firstToPlay" => true,
        "note" => 0,
        "ended" => false);
    return $a;
}

function &read_move() {
    list($x) = scan("%d");
    scantrim();
    list($y) = scan("%d");
    scantrim();
    $b = array(
        "x" => $x,
        "y" => $y);
    return $b;
}

for ($i = 0; $i <= 1; $i += 1)
{
    $state = init0();
    $c = array(
        "x" => 1,
        "y" => 1);
    apply_move($c, $state);
    $d = array(
        "x" => 0,
        "y" => 0);
    apply_move($d, $state);
    while (!$state["ended"])
    {
        print_state($state);
        apply_move(play($state), $state);
        eval0($state);
        print_state($state);
        if (!$state["ended"])
        {
            apply_move(play($state), $state);
            eval0($state);
        }
    }
    print_state($state);
    echo $state["note"], "\n";
}

