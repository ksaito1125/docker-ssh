FROM ubuntu:16.04

# docker build -t <name> . --build-arg ROOTPWD=<root password>
ARG ROOTPWD=psswd

RUN apt-get update -y && apt-get install -y \
    openssh-server \
 && apt-get -y autoremove && rm -rf /var/lib/apt/lists/*
RUN mkdir /var/run/sshd
RUN echo "root:$ROOTPWD" | chpasswd
RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]