<?php
require_once('db.php');

// Get user inputs
$username = $_POST['username'];
$medicineTypeName = $_POST['medicineTypeName'];

// Fetch medicines of a particular medicineType for user
$query = "SELECT * FROM `medicines` WHERE `medicineType` = :medicineTypeName AND `username` = :username";
$stm = $db->prepare($query);
$stm->bindParam(':medicineTypeName', $medicineTypeName);
$stm->bindParam(':username', $username);
$stm->execute();
$rows = array();
while ($row = $stm->fetch(PDO::FETCH_ASSOC)) {
    $rows[] = $row;
}
echo json_encode($rows);
?>
