FROM fedora
MAINTAINER bnaylor <brian@sackheads.org>

RUN dnf -y update && dnf clean all
RUN dnf install -y ansible tar less openssh-clients git python-pip
RUN pip install dopy==0.3.5 markupsafe

RUN mkdir /streisander
WORKDIR /streisander

RUN git clone https://github.com/jlund/streisand.git

COPY wrapper.sh /streisander/
RUN chmod +x /streisander/wrapper.sh

CMD [ "/usr/bin/ssh-agent", "./wrapper.sh" ]

