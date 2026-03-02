FROM debian:13
LABEL authors="miha.oblisar@gmail.com"
WORKDIR /opt/ansible

# System variables
ENV ANSIBLE_FORCE_COLOR=true
ENV ANSIBLE_DEPRECATION_WARNINGS=false
ENV PIP_BREAK_SYSTEM_PACKAGES=1

# Install project requirements
RUN apt update
RUN apt install -y python3 python3-pip vim less openssh-client unzip curl python3-passlib
RUN apt clean

# Install Ansible
# @docs https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html
RUN python3 -m pip install ansible

# Ansible collections
# @docs https://docs.ansible.com/ansible/latest/dev_guide/developing_collections_creating.html
COPY ./collections ./ansible-collections/infra/
## build collections (each dir under infra is a collection with galaxy.yml)
RUN find ./ansible-collections/infra -mindepth 1 -maxdepth 1 -type d -exec sh -c 'ansible-galaxy collection build "$1"' _ {} \;
## install collections
RUN find . -maxdepth 1 -type f -name "*.tar.gz" -exec sh -c 'ansible-galaxy collection install -p /usr/share/ansible/collections {}' \;
## Clean
RUN rm -r ./*

# Galaxy roles (requires network at build time)
RUN mkdir -p /usr/share/ansible/roles && ansible-galaxy role install geerlingguy.docker -p /usr/share/ansible/roles
ENV ANSIBLE_ROLES_PATH=/usr/share/ansible/roles

# Debug
RUN ansible-galaxy collection list