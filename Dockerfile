FROM registry.centos.org/che-stacks/centos-stack-base

EXPOSE 8443

USER root

#RUN yum -y update && \
#    yum clean all

RUN yum -y install epel-release && \
    yum -y install python-pip jq openssh-clients && \
    yum clean all

RUN pip install --no-cache --no-cache-dir --upgrade ansible boto boto3 botocore f5-sdk pyapi-gitlab netaddr hvac ansible-tower-cli

COPY install_tower.yml /tmp/

RUN ansible-playbook install_tower.yml

RUN echo "'PS1='\\w\\$ '" >> /root/.bashrc
