#!/bin/bash

# @author Sadiqul Islam
# @email mdsadiq1221@gmail.com
# Version: 1.00
# Exit on any error
set -e

# Variables
APP_NAME="ArtGalleryWebsite"
APP_DIR="/var/www/dotnetApp"
GITHUB_REPO="https://github.com/Sadiq-code-nest/Art-Gallery.git"
TEMP_CLONE_DIR="/tmp/art-gallery-repo"
DOTNET_PORT="5000"

echo "🔄 Updating package index..."
sudo apt update

echo "📦 Installing Nginx..."
sudo apt install -y nginx

echo "⚙️ Enabling Nginx service on boot..."
sudo systemctl enable nginx

echo "🚀 Starting Nginx service..."
sudo systemctl start nginx

echo "📡 Current status of Nginx service..."
sudo systemctl status nginx --no-pager

echo "📦 Installing .NET Core..."
sudo apt install -y dotnet-sdk-8.0
sudo apt install -y dotnet-runtime-8.0
sudo apt install -y aspnetcore-runtime-8.0
dotnet --info

echo "📦 Installing Git..."
sudo apt install -y git

echo "📦 Cloning this repo..."
rm -rf $TEMP_CLONE_DIR
git clone $GITHUB_REPO $TEMP_CLONE_DIR
cd $TEMP_CLONE_DIR

echo "📦 Copying published files to $APP_DIR..."
sudo mkdir -p $APP_DIR
sudo cp -r publish/* $APP_DIR
sudo chmod 755 $APP_DIR
sudo chown ubuntu $APP_DIR
cd ..
rm -rf $TEMP_CLONE_DIR

echo "📦 Configuring Nginx..."
NGINX_CONFIG="/etc/nginx/sites-available/default"
sudo bash -c "cat > $NGINX_CONFIG <<EOL
server {
    listen 80;
    server_name _;
    location / {
        proxy_pass http://localhost:$DOTNET_PORT;
        proxy_http_version 1.1;
        proxy_set_header Upgrade \$http_upgrade;
        proxy_set_header Connection keep-alive;
        proxy_set_header Host \$host;
        proxy_cache_bypass \$http_upgrade;
        proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto \$scheme;
    }
}
EOL"
sudo nginx -t
sudo systemctl reload nginx

echo "📦 Creating systemd service..."
SYSTEMD_SERVICE="/etc/systemd/system/$APP_NAME.service"
sudo bash -c "cat > $SYSTEMD_SERVICE <<EOL
[Unit]
Description=$APP_NAME ASP.NET Core Application

[Service]
WorkingDirectory=$APP_DIR
ExecStart=/usr/bin/dotnet $APP_DIR/$APP_NAME.dll
Restart=always
RestartSec=10
KillSignal=SIGINT
SyslogIdentifier=dotnet-$APP_NAME
User=root
Environment=ASPNETCORE_ENVIRONMENT=Production
Environment=DOTNET_PRINT_TELEMETRY_MESSAGE=false

[Install]
WantedBy=multi-user.target
EOL"
sudo systemctl daemon-reload
sudo systemctl enable $APP_NAME.service
sudo systemctl start $APP_NAME.service

echo "📡 Current status of $APP_NAME service..."
sudo systemctl status $APP_NAME.service --no-pager

echo "🔓 Opening firewall for ports 80 and $DOTNET_PORT..."
sudo apt install -y ufw
sudo ufw allow 80
sudo ufw allow $DOTNET_PORT
sudo ufw --force enable

echo "✅ Deployment complete! Visit: http://13.221.159.96/"