<?php
require_once('db.php');

// Get user inputs
$userName = $_POST['userName'];
$userPassword = $_POST['userPassword'];

// Authenticate user
$query = "SELECT COUNT(*) as count FROM `users` WHERE `userName` = :userName AND `userPassword` = :userPassword";
$stm = $db->prepare($query);
$stm->bindParam(':userName', $userName);
$stm->bindParam(':userPassword', $userPassword);
$stm->execute();
$row = $stm->fetch(PDO::FETCH_ASSOC);
if ($row['count'] > 0) {
    echo 'Authenticated';
} else {
    echo 'Unauthenticated';
}
?>
