<?php
// api/jobs.php - Stellenangebote API
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');

require_once 'db.php';

$database = new Database();
$db = $database->getConnection();

try {
    $query = "SELECT * FROM jobs WHERE active = 1 ORDER BY sort_order ASC";
    $stmt = $db->prepare($query);
    $stmt->execute();

    $jobs = array();
    while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
        $jobs[] = $row;
    }

    echo json_encode(array("success" => true, "data" => $jobs));
} catch(Exception $e) {
    echo json_encode(array("success" => false, "message" => $e->getMessage()));
}
?>