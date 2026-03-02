# infra.serverconfig

![Ansible Logo](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhjEuTwcMQYoiGCEOdEvd6FmTSZxsj4C-ye2z0AI7cK0etP3_6Sz7RPThxS9x2kqW7-lDcJu67ql2s2CipTQIzgnnMD7X2GzYCTw8zO3EV-BpYFqv7VH1hOHdirQMQSFcwEmpp6FKHVP0upwAQ5cST3_nChyphenhyphenE3LjVDpW9Z8_apv-zyJmHufBEbF8VnByg/s2256/Logo%20Ansible.png)

**Namespace:** infra  
**Collection Name:** serverconfig  
**Author:** Miha Oblišar <miha.oblisar@obleey.com>

## Description

Server configuration roles for base system setup, identity (users, SSH, sudo), Docker extras, and remote mounts (NFS/CIFS). Supports Debian and Red Hat family (RHEL, Rocky, Alma, etc.).

**Roles:** base, identity, docker_extra, mounts.

## Installation

```bash
ansible-galaxy collection install git+https://github.com/obleey/ansible-collections.git
```

Then use in plays as `infra.serverconfig.base`, `infra.serverconfig.identity`, etc.
