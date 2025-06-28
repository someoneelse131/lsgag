<?php
session_start();
if (!isset($_SESSION['user_id'])) {
  header('Location: /api/login.php');
  exit;
}
require_once 'db.php';
$db = (new Database())->getConnection();

// Delete
if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['delete_job'])) {
  $stmt = $db->prepare("DELETE FROM jobs WHERE id = ?");
  $stmt->execute([$_POST['delete_job']]);
  header('Location: /api/jobs_admin.php');
  exit;
}

// Add
if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['add_job'])) {
  $stmt = $db->prepare("INSERT INTO jobs (title, description, active, sort_order, type, location, requirements)
    VALUES (?, ?, 1, 0, ?, ?, ?)");
  $stmt->execute([
    $_POST['title'],
    $_POST['description'],
    $_POST['type'],
    $_POST['location'],
    $_POST['requirements']
  ]);
  header('Location: /api/jobs_admin.php');
  exit;
}

// Fetch
$stmt = $db->prepare("SELECT * FROM jobs WHERE active = 1 ORDER BY sort_order ASC");
$stmt->execute();
$jobs = $stmt->fetchAll(PDO::FETCH_ASSOC);
?>
<!DOCTYPE html><html><body>
<a href="/api/logout.php">Logout</a>
<h1>Stellenverwaltung</h1>

<h2>Neue Stelle hinzufügen</h2>
<form method="POST">
  <input name="title" placeholder="Titel" required><br>
  <input name="type" placeholder="Typ" required><br>
  <input name="location" placeholder="Ort" required><br>
  <textarea name="description" placeholder="Beschreibung" required></textarea><br>
  <textarea name="requirements" placeholder="Anforderungen" required></textarea><br>
  <button name="add_job">Hinzufügen</button>
</form>

<h2>Aktive Stellen</h2>
<?php if (empty($jobs)): ?>
  <p>Aktuell sind keine Stellen online.</p>
<?php else: ?>
  <table border="1">
    <tr><th>Titel</th><th>Typ</th><th>Ort</th><th>Beschreibung</th><th>Anforderungen</th><th>Aktion</th></tr>
    <?php foreach ($jobs as $j): ?>
      <tr>
        <td><?= htmlspecialchars($j['title']) ?></td>
        <td><?= htmlspecialchars($j['type']) ?></td>
        <td><?= htmlspecialchars($j['location']) ?></td>
        <td><?= nl2br(htmlspecialchars($j['description'])) ?></td>
        <td><?= nl2br(htmlspecialchars($j['requirements'])) ?></td>
        <td>
          <form method="POST" style="display:inline">
            <button name="delete_job" value="<?= $j['id'] ?>" onclick="return confirm('Löschen?')">
              Löschen
            </button>
          </form>
        </td>
      </tr>
    <?php endforeach; ?>
  </table>
<?php endif; ?>
</body></html>
