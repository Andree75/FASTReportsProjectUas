<?php
$host = "localhost";
$user = "root";       
$pass = "as"; 
$db   = "fast_reports_db";

$conn = new mysqli($host, $user, $pass, $db);

if ($conn->connect_error) {
    die(json_encode(["status" => false, "message" => "Connection failed: " . $conn->connect_error]));
}