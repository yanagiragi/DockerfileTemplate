# Base Image
From ubuntu:16.04

# Setup Necessary Tools & SSH
RUN add-apt-repository ppa:djcj/hybrid -y
RUN apt-get update && apt-get upgrade -y 
RUN apt-get install -y openssh-server git vim npm curl wget ffmpeg
RUN curl -sL https://deb.nodesource.com/setup_11.x | bash -
RUN apt-get install -y nodejs
RUN mkdir /var/run/sshd
RUN echo 'root:*****************************************************************************************************' | chpasswd
RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# TODO
# Get bashrc settings
# Get Vim settings

WORKDIR /home

# Setup Npm Packages
COPY package.json /home
RUN npm install
COPY . /home

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

# Expose port
EXPOSE 22

# Run SSH Server By Default
CMD ["/usr/sbin/sshd", "-D"]
