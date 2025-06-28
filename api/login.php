<?php
session_start();
require_once 'db.php';
$msg = '';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
  $db = (new Database())->getConnection();
  $stmt = $db->prepare("SELECT * FROM users WHERE username = ?");
  $stmt->execute([$_POST['username']]);
  $user = $stmt->fetch(PDO::FETCH_ASSOC);

  if ($user && password_verify($_POST['password'], $user['password'])) {
    session_regenerate_id(true);
    $_SESSION['user_id'] = $user['id'];
    header('Location: /api/jobs_admin.php');
    exit;
  }
  $msg = 'Ungültige Zugangsdaten';
}
?>
<!DOCTYPE html><html><body>
<h1>Admin Login</h1>
<form method="POST">
  <input name="username" placeholder="Benutzer" required><br>
  <input type="password" name="password" placeholder="Passwort" required><br>
  <button>Login</button>
</form>
<p style="color:red;"><?= htmlspecialchars($msg) ?></p>
</body></html>
