<?php
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);

include 'db_connect.php';

$user_id     = $_POST['user_id'] ?? '';
$title       = $_POST['title'] ?? '';
$description = $_POST['description'] ?? '';
$category    = $_POST['category'] ?? 'Lainnya';
$latitude    = $_POST['latitude'] ?? 0.0;
$longitude   = $_POST['longitude'] ?? 0.0;
$metadata    = $_POST['metadata'] ?? '{}'; 
$urgency     = $_POST['urgency'] ?? 'Biasa'; 

if (!isset($_FILES['image']['name'])) {
    echo json_encode(["status" => false, "message" => "Gambar wajib diupload"]);
    exit;
}

$target_dir = "uploads/";
$file_name  = time() . "_" . basename($_FILES["image"]["name"]);
$target_file = $target_dir . $file_name;

if (!is_dir($target_dir)) {
    mkdir($target_dir, 0777, true);
}

if (move_uploaded_file($_FILES["image"]["tmp_name"], $target_file)) {
    $query = "INSERT INTO reports (user_id, title, description, category, image_path, latitude, longitude, metadata, urgency) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
    
    if ($stmt = $conn->prepare($query)) {
        $stmt->bind_param("issssddss", $user_id, $title, $description, $category, $target_file, $latitude, $longitude, $metadata, $urgency);
        
        if ($stmt->execute()) {
            echo json_encode(["status" => true, "message" => "Laporan Berhasil Disimpan"]);
        } else {
            unlink($target_file); 
            echo json_encode(["status" => false, "message" => "Database Error: " . $stmt->error]);
        }
        $stmt->close();
    } else {
        echo json_encode(["status" => false, "message" => "Query Prepare Error: " . $conn->error]);
    }
} else {
    echo json_encode(["status" => false, "message" => "Gagal upload gambar"]);
}

$conn->close();