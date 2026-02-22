#!/bin/bash

# ============================================================
# Ubuntu Dev Environment Setup Script
# Author: Thirupathi Rao Sravanam
# Date:02/22/2026
# Installs:
#   - Basic utilities (tree, zip, wget)
#   - OpenJDK 21 (LTS)
#   - Apache Maven 3.9.12
# ============================================================

set -e  # Exit immediately if a command exits with a non-zero status

echo "============================================================"
echo "Updating system package index..."
echo "============================================================"

# Update package list
sudo apt update -y


echo "============================================================"
echo "Installing essential utilities: tree, zip, wget..."
echo "============================================================"

# Install commonly used utilities
sudo apt install -y tree zip wget unzip


echo "============================================================"
echo "Installing OpenJDK 21 (LTS version)..."
echo "============================================================"

# Install Java 21 JDK (includes compiler + runtime)
sudo apt install -y openjdk-21-jdk


echo "============================================================"
echo "Configuring JAVA_HOME environment variable..."
echo "============================================================"

# Define Java Home path (standard Ubuntu location)
JAVA_HOME_PATH="/usr/lib/jvm/java-21-openjdk-amd64"

# Add JAVA_HOME only if not already present (avoid duplicates)
if ! grep -q "JAVA_HOME" ~/.bashrc; then
    echo "export JAVA_HOME=${JAVA_HOME_PATH}" >> ~/.bashrc
    echo 'export PATH=$JAVA_HOME/bin:$PATH' >> ~/.bashrc
    echo "JAVA_HOME added to ~/.bashrc"
else
    echo "JAVA_HOME already configured. Skipping..."
fi

# Apply changes
source ~/.bashrc

echo "Java installation completed."


echo "============================================================"
echo "Installing Apache Maven 3.9.12..."
echo "============================================================"

# Move to /opt for third-party installations (Linux standard practice)
cd /opt

# Define Maven version and download URL
MAVEN_VERSION="3.9.12"
MAVEN_DIR="apache-maven-${MAVEN_VERSION}"
MAVEN_URL="https://dlcdn.apache.org/maven/maven-3/${MAVEN_VERSION}/binaries/${MAVEN_DIR}-bin.zip"

echo "Downloading Maven from: $MAVEN_URL"

# Download Maven binary
sudo wget $MAVEN_URL

echo "Extracting Maven archive..."
sudo unzip ${MAVEN_DIR}-bin.zip

# Remove zip file after extraction (cleanup best practice)
sudo rm ${MAVEN_DIR}-bin.zip


echo "============================================================"
echo "Configuring MAVEN_HOME environment variable..."
echo "============================================================"

MAVEN_HOME_PATH="/opt/${MAVEN_DIR}"

# Add MAVEN_HOME only if not already present
if ! grep -q "MAVEN_HOME" ~/.bashrc; then
    echo "export MAVEN_HOME=${MAVEN_HOME_PATH}" >> ~/.bashrc
    echo 'export PATH=$MAVEN_HOME/bin:$PATH' >> ~/.bashrc
    echo "MAVEN_HOME added to ~/.bashrc"
else
    echo "MAVEN_HOME already configured. Skipping..."
fi

# Apply changes
source ~/.bashrc

echo "Maven installation completed."

echo "============================================================"
echo "Setup completed successfully!"
echo "If environment variables are not reflected,"
echo "run: source ~/.bashrc"
echo "====================================================================="
