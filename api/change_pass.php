<?php
session_start();
require_once 'db.php';
if (!isset($_SESSION['user_id'])) exit('Nur für eingeloggte Admins.');

if ($_SERVER['REQUEST_METHOD']==='POST') {
    $new = $_POST['new_pass'];
    $hash = password_hash($new, PASSWORD_DEFAULT);
    $db = (new Database())->getConnection();
    $stmt = $db->prepare("UPDATE users SET password = ? WHERE id = ?");
    $stmt->execute([$hash, $_SESSION['user_id']]);
    echo "Passwort geändert.";
    exit;
}
?>
<form method="POST">
  Neues Passwort: <input name="new_pass" required><br>
  <button>Ändern</button>
</form>
