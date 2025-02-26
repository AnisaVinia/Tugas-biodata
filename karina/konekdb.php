<?php 
header('Access-Control-Allow-Origin: *');

$dbn ="scan";
$dbs ="localhost";
$dbu ="root";
$pass ="";

$db = new PDO("mysql:host={$dbs};dbname={$dbn};charset=utf8", $dbu, $pass);
$db->setAttribute(PDO::ATTR_EMULATE_PREPARES,false);
$db->setAttribute(PDO::ATTR_ERRMODE,PDO::ERRMODE_EXCEPTION);
?>