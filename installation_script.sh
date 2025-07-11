#!/bin/bash

# Simple script to deploy an ASP.NET Core application (ArtGalleryWebsite) on Ubuntu
# Clones from GitHub, sets up Nginx, .NET Core, and systemd service
# Run this on your Ubuntu server (e.g., via SSH) after updating variables

# Exit on any error
set -e

# Variables (customize if needed)
APP_NAME="ArtGalleryWebsite"
APP_DIR="/var/www/dotnetApp"
REMOTE_USER="ubuntu"
REMOTE_HOST="13.221.159.96"
DOTNET_PORT="5000"
SSH_KEY_PATH="C:\\Users\\User\\Downloads\\Others\\key-ssh.pem"  # Local machine SSH key path
GITHUB_REPO="https://github.com/Sadiq-code-nest/Art-Gallery.git"
TEMP_CLONE_DIR="/tmp/art-gallery-repo"

# Step 1: Update system packages
echo "Updating system packages..."
sudo apt update
echo "System updated."

# Step 2: Install Nginx
echo "Installing Nginx web server..."
sudo apt install -y nginx
sudo systemctl enable nginx
sudo systemctl start nginx
sudo systemctl status nginx
echo "Nginx installed and running."

# Step 3: Install .NET Core
echo "Installing .NET Core (SDK and runtime)..."
sudo apt install -y dotnet-sdk-8.0
sudo apt install -y dotnet-runtime-8.0
sudo apt install -y aspnetcore-runtime-8.0
dotnet --info
echo ".NET Core installed."

# Step 4: Configure Nginx as a reverse proxy
echo "Setting up Nginx to forward requests to your app..."
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
echo "Nginx configured."

# Step 5: Create application directory and set permissions
echo "Creating directory for the app and setting permissions..."
sudo mkdir -p $APP_DIR
sudo chmod 777 $APP_DIR  # Full permissions (use 755 for better security in production)
sudo chown $REMOTE_USER $APP_DIR
echo "Application directory ready at $APP_DIR."

# Step 6: Clone GitHub repository and copy published files
echo "Cloning GitHub repository and copying published files..."
sudo apt install -y git  # Install git if not already present
rm -rf $TEMP_CLONE_DIR  # Clean up any existing temp directory
git clone $GITHUB_REPO $TEMP_CLONE_DIR
echo "Copying files from $TEMP_CLONE_DIR/publish to $APP_DIR..."
sudo cp -r $TEMP_CLONE_DIR/publish/* $APP_DIR
rm -rf $TEMP_CLONE_DIR  # Clean up temp directory
echo "Published files copied."

# Step 7: Create and start systemd service
echo "Creating systemd service to run the app..."
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
echo "$APP_NAME service created and started."

# Step 8: Verify everything is working
echo "Checking if everything is running..."
sudo systemctl status $APP_NAME.service
curl http://localhost || echo "Warning: Could not access the app. Check configuration."
echo "Deployment complete! Your app should be live at http://$REMOTE_HOST"