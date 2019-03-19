# Base Image
From ubuntu:16.04

ARG workDirectory=/home

RUN echo "SET WORKDIR = $workDirectory"
WORKDIR $workDirectory

# Setup Npm Packages
COPY ./setup.bash .
RUN chmod u+x ./setup.bash && /bin/bash ./setup.bash

# sshd scrub the enviornments, push ENV variables to /etc/profile
# https://stackoverflow.com/questions/36292317/why-set-visible-now-in-etc-profile
ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

# Expose port
EXPOSE 22

# Setup ssh server
RUN mkdir /var/run/sshd
RUN echo 'root:*****************************************************************************************************' | chpasswd
RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

# Automatic Start Cron
ADD crontab /etc/cron.d/simple-cron
RUN chmod 0644 /etc/cron.d/simple-cron 
RUN touch /var/log/cron.log
CMD cron && tail -f /var/log/cron.log