# Ansible Collections (infra)

![Ansible Logo](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhjEuTwcMQYoiGCEOdEvd6FmTSZxsj4C-ye2z0AI7cK0etP3_6Sz7RPThxS9x2kqW7-lDcJu67ql2s2CipTQIzgnnMD7X2GzYCTw8zO3EV-BpYFqv7VH1hOHdirQMQSFcwEmpp6FKHVP0upwAQ5cST3_nChyphenhyphenE3LjVDpW9Z8_apv-zyJmHufBEbF8VnByg/s2256/Logo%20Ansible.png)

**Namespace:** infra  
**Author:** Miha Oblišar <miha.oblisar@obleey.com>

## Collections

- **[infra.serverconfig](serverconfig/README.md)** – Server configuration (base, identity, docker_extra, mounts).
- **[infra.stack](stack/README.md)** – Application stacks (WordPress, Django etc.)

## Installation

Install or update from Git (all collections):

```bash
ansible-galaxy collection install git+https://github.com/obleey/ansible-collections.git#/collections
```

Install a single collection by name (use a URL fragment for the path; comma is for branch/tag):

```bash
ansible-galaxy collection install git+https://github.com/obleey/ansible-collections.git#/collections/serverconfig
```

Build and install from a local clone:

```bash
cd ansible-collections
ansible-galaxy collection build serverconfig
ansible-galaxy collection build stack
ansible-galaxy collection install infra-serverconfig-*.tar.gz
ansible-galaxy collection install infra-stack-*.tar.gz
```

## Build with Docker

Build the Ansible runner image (includes Ansible and this repo’s collections):

```bash
docker build -t ansible-runner .
```

Run a playbook (mount your project and SSH key):

```bash
docker run -it --rm \
  -v "$(pwd):/opt/ansible" \
  -v "$HOME/.ssh:/root/.ssh:ro" \
  ansible-runner \
  ansible-playbook path/to/playbook.yaml -i path/to/inventory
```
