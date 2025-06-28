#!/bin/bash

# Setup-Script für LSG AG Docker-Umgebung

echo "LSG AG Docker Setup"
echo "=================="

# Erstelle notwendige Verzeichnisse
echo "Erstelle Verzeichnisstruktur..."
mkdir -p docker/nginx
mkdir -p docker/mysql
mkdir -p docker/certbot/conf
mkdir -p docker/certbot/www
mkdir -p api
mkdir -p uploads

# Setze Berechtigungen
chmod -R 755 docker
chmod -R 755 api
chmod -R 777 uploads

echo "Verzeichnisse erstellt!"

# Erstelle .env Datei für Docker
cat > .env << EOF
# MySQL Konfiguration
MYSQL_ROOT_PASSWORD=RootPassword123!
MYSQL_DATABASE=lsgag_db
MYSQL_USER=lsgag_user
MYSQL_PASSWORD=SecurePassword123!

# Domain
DOMAIN=lsgag.chiaruzzi.ch
EOF

echo ".env Datei erstellt!"

# Hinweise für den Benutzer
echo ""
echo "=== WICHTIGE SCHRITTE ==="
echo ""
echo "1. Kopieren Sie die Konfigurationsdateien:"
echo "   - docker-compose.yml ins Hauptverzeichnis"
echo "   - default.conf nach docker/nginx/"
echo "   - init.sql nach docker/mysql/"
echo "   - API PHP-Dateien nach api/"
echo ""
echo "2. Für das erste SSL-Zertifikat:"
echo "   a) Kommentieren Sie in docker/nginx/default.conf den HTTPS-Block aus"
echo "   b) Aktivieren Sie den auskommentierten HTTP-Block"
echo "   c) Starten Sie die Container: docker-compose up -d"
echo "   d) Führen Sie aus: docker-compose run --rm certbot certonly --webroot --webroot-path=/var/www/certbot -d lsgag.chiaruzzi.ch"
echo "   e) Aktivieren Sie wieder den HTTPS-Block und deaktivieren den HTTP-Block"
echo "   f) Neustarten: docker-compose restart nginx"
echo ""
echo "3. Starten Sie die Container:"
echo "   docker-compose up -d"
echo ""
echo "4. Prüfen Sie die Logs:"
echo "   docker-compose logs -f"
echo ""

# Erstelle eine README für Docker
cat > docker/README.md << EOF
# LSG AG Docker Setup

## Struktur
- **nginx**: Webserver mit SSL
- **php**: PHP-FPM für API
- **mysql**: Datenbank für Bilder und Stellen
- **certbot**: Automatische SSL-Zertifikate

## Datenbank
- Nur für Bilder und Stellenangebote
- Zugriff über phpMyAdmin: http://localhost:8080

## API Endpoints
- /api/jobs.php - Stellenangebote
- /api/images.php - Projektbilder

## Wartung
- SSL-Zertifikat wird automatisch erneuert
- Backups: docker exec lsgag_mysql mysqldump -u root -p lsgag_db > backup.sql
EOF

echo "Setup abgeschlossen!"