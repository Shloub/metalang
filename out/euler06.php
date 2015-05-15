<?php
$lim = 100;
$sum = intval($lim * ($lim + 1) / 2);
$carressum = $sum * $sum;
$sumcarres = intval($lim * ($lim + 1) * (2 * $lim + 1) / 6);
echo $carressum - $sumcarres;
?>
