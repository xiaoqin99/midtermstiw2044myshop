<?php
$servername = "localhost";
$username   = "javathre_270088myshopadmin";
$password   = "TANxiaoqin991101";
$dbname     = "javathre_270088myshopdb";

$con = new mysqli($servername, $username, $password, $dbname);
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}
?>