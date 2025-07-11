#!/bin/bash

#  @author ${Nafiur Rashid}
#  @email ${nafiurrashid@gmail.com}
#  ${Version: 1.00}
  
set -e

echo "🔄 Updating package index..."
sudo apt update

echo "📦 Installing Nginx..."
sudo apt install -y nginx

echo "⚙️ Enabling Nginx service on boot..."
sudo systemctl enable nginx

echo "🚀 Starting Nginx service..."
sudo systemctl start nginx

echo " Current status of Nginx service..."
sudo systemctl status nginx --no-pager

echo "Nginx is installed and running!"
echo "🌐 Visit: http://localhost or http://<your-server-ip>"

echo " Installing .NET Core..."
sudo apt install -y dotnet-sdk-8.0
sudo apt install -y dotnet-runtime-8.0
sudo apt install -y aspnetcore-runtime-8.0
dotnet --info

echo "📦 Cloning this repo..."
git clone https://github.com/Sadiq-code-nest/Art-Gallery
cd Art-Gallery

echo "📦 creating build file.."
dotnet build
dotnet run

echo "📦 moving the buildfile.."
sudo rm /var/www/html/index.nginx-debian.html
sudo cp -r build/* /var/www/html/

echo "🔄 Relaod & restart Nginx..."
sudo systemctl reload nginx
sudo systemctl restart nginx





