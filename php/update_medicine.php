<?php

// Include the database connection file
require_once('db.php');

// Get medicine details from POST request
$medicineName = $_POST['medicineName'];
$medicineDescription = $_POST['medicineDescription'];
$medicineQuantity = $_POST['medicineQuantity'];
$medicineType = $_POST['medicineType'];
$medicineExpireDate = $_POST['medicineExpireDate'];
$username = $_POST['username'];

// Check if medicine exists for this user
$query = "SELECT COUNT(*) as count FROM `medicines` WHERE `medicineName` = :medicineName AND `username` = :username";
$statement = $db->prepare($query);
$statement->bindParam(':medicineName', $medicineName);
$statement->bindParam(':username', $username);
$statement->execute();
$row = $statement->fetch(PDO::FETCH_ASSOC);
if ($row['count'] == 0) {
    echo 'Medicine does not exist for this user';
    exit();
}

// Prepare update query
$query = "UPDATE `medicines` SET `medicineName` = :medicineName, `medicineDescription` = :medicineDescription, `medicineQuantity` = :medicineQuantity, `medicineType` = :medicineType, `medicineExpireDate` = :medicineExpireDate WHERE `medicineName` = :medicineName AND `username` = :username";
$statement = $db->prepare($query);

// Bind parameters
$statement->bindParam(':medicineName', $medicineName);
$statement->bindParam(':medicineDescription', $medicineDescription);
$statement->bindParam(':medicineQuantity', $medicineQuantity);
$statement->bindParam(':medicineType', $medicineType);
$statement->bindParam(':medicineExpireDate', $medicineExpireDate);
$statement->bindParam(':username', $username);

// Execute the query
if ($statement->execute()) {
    echo "Medicine updated successfully.";
} else {
    $error = $statement->errorInfo();
    echo "Error updating medicine: " . $error[2];
}

?>
