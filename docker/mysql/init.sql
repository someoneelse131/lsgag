-- Erstelle Datenbank
CREATE DATABASE IF NOT EXISTS lsgag_db;
USE lsgag_db;

-- Tabelle für Projektbilder
CREATE TABLE IF NOT EXISTS project_images (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    filename VARCHAR(255) NOT NULL,
    description TEXT,
    sort_order INT DEFAULT 0,
    active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabelle für Stellenangebote
CREATE TABLE IF NOT EXISTS jobs (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    type VARCHAR(100) NOT NULL,
    location VARCHAR(255) NOT NULL,
    description TEXT,
    requirements TEXT,
    sort_order INT DEFAULT 0,
    active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Beispiel-Stellenangebote einfügen
INSERT INTO jobs (title, type, location, description, requirements, sort_order) VALUES
('Elektriker/in EFZ', 'Vollzeit', 'Emmenbrücke',
 'Wir suchen einen qualifizierten Elektriker für unser Team. Zu Ihren Aufgaben gehören Installation, Wartung und Reparatur elektrischer Anlagen.',
 'Abgeschlossene Lehre als Elektriker/in EFZ, Berufserfahrung von Vorteil, Führerschein Kategorie B', 1),

('Mechaniker/in', 'Vollzeit', 'Emmenbrücke',
 'Verstärken Sie unser Mechaniker-Team. Sie sind verantwortlich für Wartung und Reparatur mechanischer Anlagen.',
 'Technische Ausbildung im Bereich Mechanik, Selbständige Arbeitsweise, Teamfähigkeit', 2),

('Automatiker/in', 'Vollzeit', 'Emmenbrücke',
 'Für unsere Automation-Abteilung suchen wir eine/n erfahrene/n Automatiker/in.',
 'Erfahrung mit SPS-Programmierung (Siemens, Beckhoff), Gute Deutschkenntnisse, Bereitschaft für Pikett-Dienst', 3);

-- Beispiel-Bilder einfügen (Pfade anpassen)
INSERT INTO project_images (title, filename, description, sort_order) VALUES
('Elektrische Installation', 'projekt1.jpg', 'Moderne Elektroinstallation in Industrieanlage', 1),
('Schaltschrankbau', 'projekt2.jpg', 'Professioneller Schaltschrankbau nach Mass', 2),
('Automation Projekt', 'projekt3.jpg', 'SPS-Programmierung und Inbetriebnahme', 3),
('Mechanische Wartung', 'projekt4.jpg', 'Präventive Wartung von Produktionsanlagen', 4);

-- NEU: Tabelle für Benutzer
CREATE TABLE IF NOT EXISTS users (
  id INT AUTO_INCREMENT PRIMARY KEY,
  username VARCHAR(50) UNIQUE NOT NULL,
  password VARCHAR(255) NOT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Admin-User nur hinzufügen, wenn noch nicht vorhanden
INSERT INTO users (username, password)
SELECT 'admin', '$2y$10$eImiTXuWVxfM37uY4JANjQ6Yc7XgFQ/KD2k3r/d5eB7E4EXAMPLE'
WHERE NOT EXISTS (
  SELECT 1 FROM users WHERE username = 'admin'
);