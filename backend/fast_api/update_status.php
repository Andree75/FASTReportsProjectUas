<?php
include 'db_connect.php';
header("Content-Type: application/json");

$report_id = isset($_POST['report_id']) ? $_POST['report_id'] : null;
$status    = isset($_POST['status']) ? $_POST['status'] : null;

if ($report_id && $status) {
    $sql = "UPDATE reports SET status = '$status' WHERE id = '$report_id'";

    if ($conn->query($sql) === TRUE) {
        echo json_encode(["status" => true, "message" => "Status berhasil diubah menjadi $status"]);
    } else {
        echo json_encode(["status" => false, "message" => "Database Error: " . $conn->error]);
    }
} else {
    echo json_encode(["status" => false, "message" => "Parameter report_id atau status kosong!"]);
}
?>