<?php 
header('Content-Type: application/json'); // Perbaikan typo di header
include 'konekdb.php';

// Ambil data dari POST dengan validasi sederhana
$nama = $_POST['nama'] ?? '';
$nis = $_POST['nis'] ?? '';
$tplahir = $_POST['tplahir'] ?? '';
$tglahir = $_POST['tglahir'] ?? '';
$kelamin = $_POST['kelamin'] ?? '';
$agama = $_POST['agama'] ?? '';
$alamat = $_POST['alamat'] ?? '';

try {
    // Perbaikan: Hapus koma berlebih di akhir VALUES
    $stmt = $db->prepare("INSERT INTO siswa (nis, nama, tplahir, tglahir, kelamin, agama, alamat)
                          VALUES (?, ?, ?, ?, ?, ?, ?)");
    $result = $stmt->execute([$nis, $nama, $tplahir, $tglahir, $kelamin, $agama, $alamat]);

    echo json_encode([
        'success' => $result,
        'message' => $result ? 'Data berhasil disimpan.' : 'Gagal menyimpan data.',
    ]);
} catch (PDOException $e) {
    // Penanganan error jika terjadi masalah pada query
    echo json_encode([
        'success' => false,
        'message' => 'Error: ' . $e->getMessage(),
    ]);
}
?>
