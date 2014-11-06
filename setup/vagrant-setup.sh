#!/bin/bash

#Step by step instructions to building an environment and installing ss:
sudo apt-get -y install xvfb apache2 git fontconfig libapache2-mod-wsgi #ttf-mscorefonts-installer
sudo apt-get -y install python-imaging python-django python-pip python-sip python-qt4
sudo apt-get install libqtwebkit-dev

# Sadly the ms fonts provided within the mscorefonts lacks tahoma, so that needs to be manually copied from somewhere,
# there are 2 files (tahomabd.ttf, tahoma.ttf) that need to be copied to: /usr/share/fonts/truetype/msttcorefonts

# Copy the included xvfb init.d script to /etc/init.d, ensure it is marked executable
sudo cp /vagrant/setup/ubuntu/init.d/xvfb /etc/init.d

# Install the script into proper run levels
sudo update-rc.d xvfb defaults 50 50

# Install the backend web scraping library that wraps webkit:
sudo pip install webscraping

# Copy the included hostname.conf file to /etc/apache2/sites-available - make sure to rename the file to your hostname, once
# the file is in place edit the file and replace all references to "hostname" with your own hostname.
sudo cp /vagrant/setup/ubuntu/etc/apache2/sites-available/hostname.conf /etc/apache2/sites-available

# Once the configuration file is in place run the following:
sudo a2ensite hostname.conf

# Copy the included mpm_prefork.conf file to /etc/apache2/mods-available. Once the file is in place run the following:
sudo cp /vagrant/setup/ubuntu/etc/apache2/mods-available/mpm_prefork.conf /etc/apache2/mods-available
sudo a2dismod mpm_event
sudo a2enmod mpm_prefork

#From here the application needs to be dropped in the appropriate /var/www/hostname directory, either through tar ball or direct checkout from git (preferred):
mkdir /var/www/hostname
sudo cp -a /vagrant/. /var/www/hostname

# Finally log file ownership needs to be adjusted:
sudo chown www-data:www-data /var/www/hostname/logs/*.log

sudo service apache2 restart