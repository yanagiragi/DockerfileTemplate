# Base Image
From ubuntu:16.04

ARG workDirectory=/home

RUN echo "SET WORKDIR = $workDirectory"
WORKDIR $workDirectory

# Setup Npm Packages
COPY ./setup.sh .
RUN chmod u+x ./setup.sh && /bin/bash ./setup.sh

# sshd scrub the enviornments, push ENV variables to /etc/profile
# https://stackoverflow.com/questions/36292317/why-set-visible-now-in-etc-profile
ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

# Copy run.sh only
COPY ./run.sh .
RUN chmod u+x ./run.sh

# Expose port
EXPOSE 22

# Run SSH Server By Default
CMD ["/bin/bash", "./run.sh"]
