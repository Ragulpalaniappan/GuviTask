#!/bin/bash

# Log file
LOG_FILE="/var/log/user_data.log"

# Update the system
echo "Updating the system..." >> $LOG_FILE 2>&1
sudo yum update -y >> $LOG_FILE 2>&1

# Install Nginx
echo "Installing Nginx..." >> $LOG_FILE 2>&1
sudo yum install -y nginx >> $LOG_FILE 2>&1

# Start the Nginx service
echo "Starting Nginx service..." >> $LOG_FILE 2>&1
sudo systemctl start nginx >> $LOG_FILE 2>&1

# Enable Nginx to start on boot
echo "Enabling Nginx to start on boot..." >> $LOG_FILE 2>&1
sudo systemctl enable nginx >> $LOG_FILE 2>&1

# Check Nginx status
echo "Checking Nginx status..." >> $LOG_FILE 2>&1
sudo systemctl status nginx >> $LOG_FILE 2>&1

