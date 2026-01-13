<?php
include 'db_connect.php';

$report_id = $_POST['id'] ?? '';

if (empty($report_id)) {
    echo json_encode(["status" => false, "message" => "ID Kosong"]);
    exit;
}
$query = $conn->prepare("SELECT image_path FROM reports WHERE id = ?");
$query->bind_param("i", $report_id);
$query->execute();
$result = $query->get_result();
$row = $result->fetch_assoc();
$stmt = $conn->prepare("DELETE FROM reports WHERE id = ?");
$stmt->bind_param("i", $report_id);

if ($stmt->execute()) {
    if ($row && !empty($row['image_path'])) {
        $full_path = __DIR__ . "/" . $row['image_path'];
        if (file_exists($full_path)) {
            unlink($full_path);
        }
    }
    echo json_encode(["status" => true, "message" => "Laporan dihapus"]);
} else {
    echo json_encode(["status" => false, "message" => "Gagal hapus DB"]);
}