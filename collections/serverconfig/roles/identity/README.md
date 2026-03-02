Base User
=========

Manages a privileged non-root account and associated configuration.  Primary
use is to create a stable ``deployer``-style user with sudo access and secure
SSH settings while discouraging direct root logins.

The role handles:

* ensuring the base user exists with `/bin/bash` shell, home directory and
  membership in the `sudo` group on Debian-based systems or `wheel` on
  RedHat-based systems.
* optionally creating a “breakglass” account for emergency access
* applying a password hash (or locking the account) and marking the password
  to expire on first login
* deploying any supplied SSH public keys to the user's `~/.ssh/authorized_keys`
* installing a restrictive `authorized_keys` entry for root that displays a
  warning message and prevents port/agent/X11 forwarding
* optionally installing a colorful PS1 prompt for both the base and root
  users

Requirements
------------

* Ansible 2.9 or later
* No special external dependencies (packages installed using built-in
  `user`/`authorized_key` modules)

Role Variables
--------------

Variables may be defined in host/group vars or a playbook.

* `base_user` (default `deployer`) – username of the privileged account.
* `base_user_password_hash` – SHA512 hash to set as the initial password.
  Leaving it unset or set to `'!'` results in a locked account; SSH keys should
  then be used for authentication.
* `base_user_keys` – list of public key strings to add to the user's
  `authorized_keys`.

* `breakglass_user` (default `breakglass`) – alternate emergency account.
* `breakglass_keys` – public keys for the breakglass user.

* `enable_custom_prompts` (boolean, default true) – toggle installation of the
  colourful PS1 modifications.

Examples
--------

```yaml
- hosts: all
  become: yes
  vars:
    base_user: deployer
    base_user_password_hash: "{{ 'password123' | password_hash('sha512') }}"
    base_user_keys:
      - "ssh-rsa AAAA... user@example.com"
    breakglass_user: emergency
    breakglass_keys:
      - "ssh-ed25519 AAAA... admin@example.com"
  roles:
    - infra.serverconfig.identity
```

Dependencies
------------

None.  The role is self‑contained and uses only core Ansible modules.

Example Playbook
----------------

(Same as above.)

License
-------

BSD

Author Information
------------------

Miha Oblišar