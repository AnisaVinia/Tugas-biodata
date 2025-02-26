<?php 
header('Content-Typer: application/json');
include "konekdb.php";

$id=$_POST['id'];
$stmt = $db->prepare("SELECT * FROM siswa WHERE id = ?");
$result = $stmt->execute([$id]);
$result = $stmt->fetchAll(PDO::FETCH_ASSOC);

echo json_encode($result);
?>