# Pulling Alpine image
FROM python:3.10-alpine

RUN ln -sf python3 /usr/bin/python

RUN pip3 install "requests==2.28.0"

#Copy the connection file
COPY ./connection.py /app/connection.py

#Create cron job
COPY ./cronfile /app/mycron
RUN crontab /app/mycron

#Create process to ensure the container keeps working
RUN touch /tmp/out.log


CMD crond && tail -f /tmp/out.log