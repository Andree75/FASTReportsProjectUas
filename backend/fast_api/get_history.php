<?php
include 'db_connect.php';

$user_id = $_POST['user_id'] ?? '';

if (empty($user_id)) {
    echo json_encode(["status" => false, "message" => "User ID kosong"]);
    exit;
}

$query = "SELECT * FROM reports WHERE user_id = ? ORDER BY id DESC";

if ($stmt = $conn->prepare($query)) {
    $stmt->bind_param("i", $user_id);
    $stmt->execute();
    $result = $stmt->get_result();

    $data = [];
    while ($row = $result->fetch_assoc()) {
        $data[] = $row;
    }

    echo json_encode([
        "status" => true, 
        "data" => $data
    ]);
} else {
    echo json_encode(["status" => false, "message" => "Query Error"]);
}
?>