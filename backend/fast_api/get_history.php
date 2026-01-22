<?php
include 'db_connect.php';
header("Content-Type: application/json");
header("Access-Control-Allow-Origin: *"); 

if (isset($_REQUEST['user_id'])) {
    $user_id = $_REQUEST['user_id'];
    $sql = "SELECT * FROM reports WHERE user_id = '$user_id' ORDER BY created_at DESC";
} else {
    $sql = "SELECT * FROM reports ORDER BY created_at DESC";
}

$result = $conn->query($sql);

$data = array();
if ($result) {
    while($row = $result->fetch_assoc()) {
        $data[] = $row;
    }
    echo json_encode(["status" => true, "data" => $data]);
} else {
    echo json_encode(["status" => false, "message" => "Gagal mengambil data"]);
}
?>