<?php
// api/images.php - Bilder API
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');

require_once 'db.php';

$database = new Database();
$db = $database->getConnection();

try {
    $query = "SELECT * FROM project_images WHERE active = 1 ORDER BY sort_order ASC";
    $stmt = $db->prepare($query);
    $stmt->execute();

    $images = array();
    while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
        // Pfad zu den Bildern im img Ordner
        $row['image_url'] = '/img/' . $row['filename'];
        $images[] = $row;
    }

    echo json_encode(array("success" => true, "data" => $images));
} catch(Exception $e) {
    echo json_encode(array("success" => false, "message" => $e->getMessage()));
}
?>