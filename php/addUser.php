<?php
require_once('db.php');

// Get user inputs
$userName = $_POST['userName'];
$userPassword = $_POST['userPassword'];

// Check if user already exists
$query = "SELECT COUNT(*) as count FROM `users` WHERE `userName` = :userName";
$stm = $db->prepare($query);
$stm->bindParam(':userName', $userName);
$stm->execute();
$row = $stm->fetch(PDO::FETCH_ASSOC);
if ($row['count'] > 0) {
    echo 'User exists';
    exit();
}

// Insert new user
$query = "INSERT INTO `users` (`userName`, `userPassword`) VALUES (:userName, :userPassword)";
$stm = $db->prepare($query);
$stm->bindParam(':userName', $userName);
$stm->bindParam(':userPassword', $userPassword);

// Execute statement
if ($stm->execute()) {
    echo 'User added successfully';
} else {
    $error = $stm->errorInfo();
    echo 'Error adding user: ' . $error[2];
}
?>