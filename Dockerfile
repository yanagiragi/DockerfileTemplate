# Base Image
From ubuntu:16.04

WORKDIR /home

# Setup Npm Packages
COPY ./setup.sh .
RUN chmod u+x ./setup.sh && /bin/bash ./setup.sh

COPY ./run.sh .
RUN chmod u+x ./run.sh

ENV NOTVISIBLE "in users profile"

# Expose port
EXPOSE 22

# Run SSH Server By Default
CMD ["/bin/bash", "./run.sh"]
