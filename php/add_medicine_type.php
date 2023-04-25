<?php
require_once('db.php');

// Get medicine type inputs
$medicineTypeName = $_POST['medicineTypeName'];
$medicineTypeDescription = $_POST['medicineTypeDescription'];
$medicineTypeQuantity = $_POST['medicineTypeQuantity'];
$username = $_POST['username'];

// Check if medicine type already exists for the user
$query = "SELECT COUNT(*) as count FROM `medicineTypes` WHERE `medicineTypeName` = :medicineTypeName AND `username` = :username";
$stm = $db->prepare($query);
$stm->bindParam(':medicineTypeName', $medicineTypeName);
$stm->bindParam(':username', $username);
$stm->execute();
$row = $stm->fetch(PDO::FETCH_ASSOC);
if ($row['count'] > 0) {
    echo 'Medicine type already exists for this user';
    exit();
}

// Insert new medicine type
$query = "INSERT INTO `medicineTypes` (`medicineTypeName`, `medicineTypeDescription`, `medicineTypeQuantity`, `username`) VALUES (:medicineTypeName, :medicineTypeDescription, :medicineTypeQuantity, :username)";
$stm = $db->prepare($query);
$stm->bindParam(':medicineTypeName', $medicineTypeName);
$stm->bindParam(':medicineTypeDescription', $medicineTypeDescription);
$stm->bindParam(':medicineTypeQuantity', $medicineTypeQuantity);
$stm->bindParam(':username', $username);

// Execute statement
if ($stm->execute()) {
    echo 'Medicine type added successfully';
} else {
    $error = $stm->errorInfo();
    echo 'Error adding medicine type: ' . $error[2];
}
?>
