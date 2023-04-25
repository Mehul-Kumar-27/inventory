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
if ($row['count'] == 0) {
    echo 'Medicine type does not exist for this user';
    exit();
}

// Update medicine type
$query = "UPDATE `medicineTypes` SET `medicineTypeDescription` = :medicineTypeDescription, `medicineTypeQuantity` = :medicineTypeQuantity WHERE `medicineTypeName` = :medicineTypeName AND `username` = :username";
$stm = $db->prepare($query);
$stm->bindParam(':medicineTypeName', $medicineTypeName);
$stm->bindParam(':medicineTypeDescription', $medicineTypeDescription);
$stm->bindParam(':medicineTypeQuantity', $medicineTypeQuantity);
$stm->bindParam(':username', $username);

// Execute statement
if ($stm->execute()) {
    echo 'Medicine type updated successfully';
} else {
    $error = $stm->errorInfo();
    echo 'Error updating medicine type: ' . $error[2];
}
?>
