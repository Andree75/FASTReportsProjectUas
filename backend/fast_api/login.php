<?php
include 'db_connect.php';

$username = $_POST['username'] ?? ''; 
$password = $_POST['password'] ?? '';

$stmt = $conn->prepare("SELECT id, full_name, password FROM users WHERE username = ?");
$stmt->bind_param("s", $username);
$stmt->execute();
$result = $stmt->get_result();

if ($result->num_rows > 0) {
    $row = $result->fetch_assoc();
    if (password_verify($password, $row['password'])) {
        echo json_encode([
            "status" => true,
            "message" => "Login Berhasil",
            "data" => [
                "user_id" => $row['id'],
                "full_name" => $row['full_name'],
                "username" => $username
            ]
        ]);
    } else {
        echo json_encode(["status" => false, "message" => "Password Salah"]);
    }
} else {
    echo json_encode(["status" => false, "message" => "Username tidak ditemukan"]);
}
?>