<?php

$dns = 'mysql:host=localhost;dbname="Enter Your Database Name"';
$user = 'Enter your user';
$pass = 'Your Password *******';

try{
    $db = new PDO($dns, $user, $pass);
    
}catch(PDOException $e){
    $error = $e->getMessage();
    echo $error;

}