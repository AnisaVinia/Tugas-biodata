<?php
header('Content-Type: application/json'); // ✅ Perbaikan header

include "konekdb.php";

// ✅ Ambil data POST dengan validasi sederhana
$id = isset($_POST['id']) ? $_POST['id'] : null;
$nama = isset($_POST['nama']) ? $_POST['nama'] : '';
$nis = isset($_POST['nis']) ? $_POST['nis'] : '';
$tplahir = isset($_POST['tplahir']) ? $_POST['tplahir'] : '';
$tglahir = isset($_POST['tglahir']) ? $_POST['tglahir'] : '';
$kelamin = isset($_POST['kelamin']) ? $_POST['kelamin'] : '';
$agama = isset($_POST['agama']) ? $_POST['agama'] : '';
$alamat = isset($_POST['alamat']) ? $_POST['alamat'] : '';

$response = ['success' => false]; // Default response gagal

if ($id) {
    try {
        $stmt = $db->prepare(
            "UPDATE siswa 
            SET nis = ?, nama = ?, tplahir = ?, tglahir = ?, kelamin = ?, agama = ?, alamat = ? 
            WHERE id = ?"
        );

        $result = $stmt->execute([$nis, $nama, $tplahir, $tglahir, $kelamin, $agama, $alamat, $id]);
        $response['success'] = $result;
    } catch (PDOException $e) {
        $response['success'] = false;
        $response['error'] = $e->getMessage(); // Untuk debug (hapus di production)
    }
} else {
    $response['success'] = false;
    $response['error'] = 'ID tidak ditemukan.';
}

echo json_encode($response);
?>
