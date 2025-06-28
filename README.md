docker-compose run --rm certbot certonly \
  --webroot \
  --webroot-path=/var/www/certbot \
  --email ihre-email@beispiel.ch \
  --agree-tos \
  --no-eff-email \
  -d lsgag.chiaruzzi.ch