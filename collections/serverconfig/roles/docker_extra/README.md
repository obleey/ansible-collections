Docker Extra
============

Adds simple, automated Docker maintenance using systemd timers and prune
commands.  The role deploys two service units and a shared timer which
periodically remove unused images and volumes according to configurable
filters.

Specifically the role will:

* render `docker-image-prune.service`, `docker-volume-prune.service` and
  `docker-prune.timer` from templates to `/etc/systemd/system`
* reload systemd to pick up the new units
* enable and start both timers (`docker-image-prune.timer` and
  `docker-volume-prune.timer`)

Requirements
------------

* Ansible 2.9 or later
* Host must have Docker installed and accessible via `/usr/bin/docker`

Role Variables
--------------

Defined in `defaults/main.yaml` and overrideable via inventory, group, or play
vars.

* `docker_prune_schedule` – systemd OnCalendar expression for when the timer
  fires (default `Sun *-*-* 00:00:00`)
* `docker_image_prune_filters` – filters passed to
  `docker image prune -af --filter` (default `until=24h`)
* `docker_volume_prune_filters` – filters passed to
  `docker volume prune -f --filter` (default `until=24h`)

Examples
--------

```yaml
- hosts: docker_hosts
  become: yes
  vars:
    docker_prune_schedule: "Mon *-*-* 03:00:00"
    docker_image_prune_filters: "until=48h"
  roles:
    - infra.serverconfig.docker_extra
```

Dependencies
------------

None.

Example Playbook
----------------

(Same as above.)

License
-------

BSD

Author Information
------------------

Miha Oblišar