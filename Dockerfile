# Dockerfile to create image with cron services
FROM ubuntu:latest
MAINTAINER baeldung.com

# Add the script to the Docker Image
ADD connection.py /root/connection.py

# Give execution rights on the cron scripts
RUN chmod 0644 /root/connection.py

#Install Cron
RUN apt-get update
RUN apt-get -y install cron
RUN apt-get install -y python3
RUN apt-get install -y pip
RUN pip3 install requests

# Add the cron job
RUN crontab -l | { cat; echo "* * * * * /bin/python3 /root/connection.py"; } | crontab -
RUN cron

# Run the command on container startup
CMD cron