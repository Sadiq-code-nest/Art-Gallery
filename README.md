# Project Overview
ArtGalleryWebsite provides a seamless experience for browsing and managing art collections. Deployed on an Ubuntu server with Nginx as a reverse proxy, it uses pre-published application files from the GitHub repository for quick setup.

Repository: github.com/Sadiq-code-nest/Art-Gallery
Live Deployment: http://54.161.71.139 (Master branch)

# Quick Deployment
Deploy ArtGalleryWebsite on an Ubuntu server with automated scripts for both development and production environments. Follow the steps below to get started.
prerequisites

Ubuntu Server: Version 20.04 or 22.04 with SSH access.
SSH Key: Located at C:\Users\User\Downloads\Others\key-ssh.pem on your local machine.
GitHub Repository: Ensure the publish folder in github.com/Sadiq-code-nest/Art-Gallery contains pre-published ASP.NET Core files.
Port Configuration: Set port 5000 in Properties/launchSettings.json and comment out app.UseHttpsRedirection() in Program.cs.
Internet Access: Required for downloading dependencies and cloning the repository.

development server
Run these commands on your Ubuntu server to deploy in a development environment:
wget https://raw.githubusercontent.com/Sadiq-code-nest/Art-Gallery/main/deploy_aspnetcore.sh
chmod +x deploy_aspnetcore.sh
./deploy_aspnetcore.sh

This script:

Installs Nginx and .NET Core (SDK and runtime).
Clones the publish folder from the GitHub repository.
Configures Nginx as a reverse proxy and sets up a systemd service.

production server
Use the same script for production, as it includes production settings (ASPNETCORE_ENVIRONMENT=Production) and automatic service restarts:
wget https://raw.githubusercontent.com/Sadiq-code-nest/Art-Gallery/main/deploy_aspnetcore.sh
chmod +x deploy_aspnetcore.sh
./deploy_aspnetcore.sh

one-step setup
For a fully automated deployment, use this script to download and run the deployment script:
wget https://raw.githubusercontent.com/Sadiq-code-nest/Art-Gallery/main/setup_and_deploy.sh
chmod +x setup_and_deploy.sh
./setup_and_deploy.sh

Local Development
Set up and run ArtGalleryWebsite locally for development or testing.
prerequisites

.NET SDK 8.0
Visual Studio Code or Visual Studio
Git

installation

Clone the Repository:
git clone https://github.com/Sadiq-code-nest/Art-Gallery.git
cd Art-Gallery/ArtGalleryWebsite/ArtGalleryWebsite


Restore Dependencies:
dotnet restore


Run the Application:
dotnet run

Open http://localhost:5000 in your browser.

Build for Production:
dotnet publish -c Release -o ./publish

The publish folder contains files ready for deployment.


Testing
Run unit tests (if included) to verify functionality:
dotnet test

Resources

ASP.NET Core: Web framework (learn.microsoft.com/en-us/aspnet/core/)
Nginx: Reverse proxy server (nginx.org)
.NET SDK 8.0: Development kit (dotnet.microsoft.com/en-us/download/dotnet/8.0)
GitHub: Source control (github.com)
Systemd: Service management (systemd.io)

Security Notes

Permissions: The deployment script uses chmod 777 for simplicity. Use 755 or 750 in production.
User: The systemd service runs as root. Consider a non-root user for production.
HTTPS: Enable SSL/TLS in Nginx for secure production deployments.

Contributing
We welcome contributions! To contribute:

Fork the repository.
Create a branch: git checkout -b feature/your-feature.
Commit changes: git commit -m "Add your feature".
Push to the branch: git push origin feature/your-feature.
Open a pull request.

License
This project is licensed under the MIT License. See the LICENSE file for details.
Contact
For questions or support, open an issue on GitHub or email your-email@example.com.

ArtGalleryWebsite - Bringing art to life with ASP.NET Core! 🎨