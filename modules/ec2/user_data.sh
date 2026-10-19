#!/bin/bash
set -euxo pipefail

dnf install -y nginx
systemctl enable --now nginx

cat > /usr/share/nginx/html/index.html <<'HTML'
<!doctype html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Terraform-1</title>
</head>
<body>
  <h1>Nginx is running!</h1>
  <p>Private EC2 instance deployed with Terraform.</p>
</body>
</html>
HTML

systemctl restart nginx
