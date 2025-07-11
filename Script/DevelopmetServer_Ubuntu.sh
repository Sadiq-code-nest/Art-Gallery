#!/bin/bash  
#  @author ${Sadiqul Islam}
#  @email ${mdsadiq1221@gmail.com}
#  ${Version: 1.00}
set -e

echo "Updating package index..."
sudo apt update

echo "📦 Cloning this repo..."
git clone https://github.com/Sadiq-code-nest/Art-Gallery
cd Art-Gallery

echo "📦 Installing dependency.."
echo "Installing .NET Core..."
sudo apt install -y dotnet-sdk-8.0
dotnet build
dotnet run