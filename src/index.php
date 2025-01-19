<?php
$servername = getenv('LAMP_DB');
$username = getenv('USER');
$password = getenv('DB_PASSWORD');

$conn = new mysqli($servername, $username, $password);

if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}
echo "Connected successfully";
?>
