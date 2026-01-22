<?php
$host = "localhost";
$user = "root";       
$pass = ""; // sesuaikan dengan password dari DB Server
$db   = "fast_reports_db"; //sesuaikan dengan nama database yang ada di PHPMYAdmin

$conn = new mysqli($host, $user, $pass, $db);

if ($conn->connect_error) {
    die(json_encode(["status" => false, "message" => "Connection failed: " . $conn->connect_error]));
}
?>