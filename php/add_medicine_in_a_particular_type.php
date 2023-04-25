<?php

require_once('db.php'); // include the database connection file

// Get medicine inputs
$medicineName = $_POST['medicineName'];
$medicineDescription = $_POST['medicineDescription'];
$medicineQuantity = $_POST['medicineQuantity'];
$medicineType = $_POST['medicineType'];
$username = $_POST['username'];
$medicineExpireDate = $_POST['medicineExpireDate'];

// Check if medicine type exists for the user
$query = "SELECT COUNT(*) as count FROM `medicineTypes` WHERE `medicineTypeName` = :medicineType AND `username` = :username";
$stm = $db->prepare($query);
$stm->bindParam(':medicineType', $medicineType);
$stm->bindParam(':username', $username);
$stm->execute();
$row = $stm->fetch(PDO::FETCH_ASSOC);

if ($row['count'] < 1) {
    echo 'Medicine type does not exist for this user';
    exit();
}

// Check if medicine name exists for the user
$query = "SELECT COUNT(*) as count FROM `medicines` WHERE `medicineName` = :medicineName AND `username` = :username";
$stm = $db->prepare($query);
$stm->bindParam(':medicineName', $medicineName);
$stm->bindParam(':username', $username);
$stm->execute();
$row = $stm->fetch(PDO::FETCH_ASSOC);

if ($row['count'] > 0) {
    echo 'Medicine name already exists for this user';
    exit();
}

// Insert new medicine
$query = "INSERT INTO `medicines` (`medicineName`, `medicineDescription`, `medicineQuantity`, `medicineType`, `username`, `medicineExpireDate`) VALUES (:medicineName, :medicineDescription, :medicineQuantity, :medicineType, :username, :medicineExpireDate)";
$stm = $db->prepare($query);
$stm->bindParam(':medicineName', $medicineName);
$stm->bindParam(':medicineDescription', $medicineDescription);
$stm->bindParam(':medicineQuantity', $medicineQuantity);
$stm->bindParam(':medicineType', $medicineType);
$stm->bindParam(':username', $username);
$stm->bindParam(':medicineExpireDate', $medicineExpireDate);

// Execute statement
if ($stm->execute()) {
    echo 'Medicine added successfully';
} else {
    $error = $stm->errorInfo();
    echo 'Error adding medicine: ' . $error[2];
}

?>
