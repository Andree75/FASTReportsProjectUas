<?php
include 'db_connect.php';

$username = $_POST['username'];
$password = $_POST['password'];

$sql = "SELECT * FROM admins WHERE username = '$username' AND password = '$password'";
$result = $conn->query($sql);

if ($result->num_rows > 0) {
    $row = $result->fetch_assoc();
    echo json_encode([
        "status" => true,
        "message" => "Login Admin Sukses",
        "data" => $row
    ]);
} else {
    echo json_encode(["status" => false, "message" => "Akun Admin tidak ditemukan"]);
}
?>