Base
====

Installs foundational configuration for servers:

* verifies required variables
* updates and upgrades the system
* installs a set of common utility packages (separate lists for Debian/RedHat)
* configures hostname based on `hostname` and `server_environment`
* enables automatic updates (`unattended-upgrades` on Debian, `dnf-automatic` on
  RedHat)
* sets up Fail2Ban with templates and service management
* hardens SSH configuration and kernel networking parameters for container
  workloads
* deploys a shared `aliases.sh` and optionally adds extra environment variables
* verifies SSH availability on the custom port

Requirements
------------

* Ansible 2.9 or later
* Hosts must have network access to package repositories

Role Variables
--------------

The following variables can be provided in `host_vars`, `group_vars`, or a
playbook:

* `hostname` **(required)** - base hostname string (e.g. `servarr`)
* `server_environment` **(required)** - environment suffix for hostname
  (e.g. `development`, forming `servarr-development`)
* `ssh_port` - custom SSH port (default `4042`)
* `env_bashrc_path` - location where `aliases.sh` will be sourced (default
  `/root`)
* `env_vars` - optional list of extra environment variables; each element is a
  map `{ name: VAR, value: value }`
* `f2b_maxretry` / `f2b_bantime` - Fail2Ban defaults (5 and 600)

Package lists are split to avoid installing unavailable packages on the wrong
platform:

* `base_packages_common` - packages available on both families (curl, htop,
  vim, jq, lsof, unzip, rsyslog, git, haveged, net-tools, fail2ban,
  python3-pip)
* `base_packages_debian` - additional Debian/Ubuntu packages
  (unattended-upgrades, python3-passlib, python3-debian, iotop)
* `base_packages_redhat` - additional RedHat/CentOS packages
  (dnf-automatic, python3-passlib, iotop)

Dependencies
------------

None (role handles its own package installations and configuration templates).

Example Playbook
----------------

```yaml
- hosts: all
  become: yes
  vars:
    hostname: alpina-pim
    server_environment: production
    base_packages_common:
      - curl
      - htop
    base_packages_redhat:
      - dnf-automatic
  roles:
    - infra.serverconfig.base
```

License
-------

BSD

Author Information
------------------

Miha Oblišar