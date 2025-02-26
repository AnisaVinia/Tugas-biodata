<?php
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *'); // Agar Flutter bisa akses

include "konekdb.php";

//try {
    $stmt = $db->prepare("SELECT id, nis, nama, tplahir, tglahir, kelamin, agama, alamat FROM siswa");
    $stmt->execute();
    $result = $stmt->fetchAll(PDO::FETCH_ASSOC);

    if ($result) {
        echo json_encode($result, JSON_PRETTY_PRINT); // Biar JSON rapi
    } else {
        echo json_encode(["message" => "No data found."]);
    }
//} catch (PDOException $e) {
//   echo json_encode(["error" => $e->getMessage()]);
//}
?>
