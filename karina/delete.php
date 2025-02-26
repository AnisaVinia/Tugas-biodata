<?php 
header('Content-Typer: application/json');
include "konekdb.php";

$id=$_POST['id'];
$stmt = $db->prepare("DELETE FROM siswa WHERE id = ?");
$result = $stmt->execute([$id]);

echo json_encode([
    'success' =>$result
]);
?>