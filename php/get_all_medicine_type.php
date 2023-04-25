<?php
require_once('db.php');

// Get user inputs
$username = $_POST['username'];

// Fetch medicine types for user
$query = "SELECT * FROM `medicineTypes` WHERE `username` = :username";
$stm = $db->prepare($query);
$stm->bindParam(':username', $username);
$stm->execute();
$rows = array();
while ($row = $stm->fetch(PDO::FETCH_ASSOC)) {
    $rows[] = $row;
}
echo json_encode($rows);
?>

