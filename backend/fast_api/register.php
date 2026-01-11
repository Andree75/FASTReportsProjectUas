<?php
include 'db_connect.php';

$full_name = $_POST['full_name'] ?? '';
$username  = $_POST['username'] ?? ''; 
$password  = $_POST['password'] ?? '';

if (empty($full_name) || empty($username) || empty($password)) {
    echo json_encode(["status" => false, "message" => "Data tidak lengkap"]);
    exit;
}
$check = $conn->prepare("SELECT id FROM users WHERE username = ?");
$check->bind_param("s", $username);
$check->execute();
if ($check->get_result()->num_rows > 0) {
    echo json_encode(["status" => false, "message" => "Username sudah digunakan"]);
    exit;
}

$hashed_password = password_hash($password, PASSWORD_DEFAULT);
$stmt = $conn->prepare("INSERT INTO users (full_name, username, password) VALUES (?, ?, ?)");
$stmt->bind_param("sss", $full_name, $username, $hashed_password);

if ($stmt->execute()) {
    echo json_encode(["status" => true, "message" => "Registrasi Berhasil"]);
} else {
    echo json_encode(["status" => false, "message" => "Gagal: " . $stmt->error]);
}