# Set the base image to Debian
FROM debian:wheezy

# File Author / Maintainer
MAINTAINER opensource.knihovna.cz

################## BEGIN INSTALLATION ######################
# Install ILS Koha with Czech language
# Ref: http://opensource.knihovna.cz/wiki

# Add the Koha repostitory to the sources list
RUN echo deb http://debian.koha-community.org/koha squeeze main | sudo tee /etc/apt/sources.list.d/koha.list

# Add key
RUN wget -O- http://debian.koha-community.org/koha/gpg.asc | sudo apt-key add -

# Update the repository sources list
RUN apt-get update

# Upgrade Debian
RUN apt-get upgrade

# Set Apache rewrite
RUN a2enmod rewrite

# Restart Apache
RUN service apache2 restart

# Install Koha package
RUN apt-get install koha-common

# Install MySQL server package
RUN apt-get install mysql-server


# Create instance of Koha
RUN koha-create --create-db knihovna

# Install Czech language
RUN koha-translate –-install cs-CZ



##################### INSTALLATION END #####################
# Expose the default port
EXPOSE 27017

# Default port to execute the entrypoint (MongoDB)
CMD ["--port 27017"]

# Set default container command
ENTRYPOINT usr/bin/mongod

