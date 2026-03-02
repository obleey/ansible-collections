Mounts
======

This role manages filesystem mounts by ensuring entries are present in /etc/fstab,
creating mount point directories and mounting them.  It supports NFS (nfs/nfs4)
and CIFS filesystems and will automatically install the appropriate client
packages when necessary.

Requirements
------------

- Ansible 2.9 or later
- Inventory hosts must have network access to the mount sources
- `epel-release` repository for certain RedHat packages (handled by other roles)

Role Variables
--------------

The role relies on a single variable defined in host/group vars or playbook:

`mount_entries` *(required)*
: A list of dictionaries describing each mount.  Valid keys:

    path:   Destination directory on the local filesystem (required)
    src:    Remote source (e.g. server:/export or //srv/share) (required)
    fstype: Filesystem type, e.g. nfs, nfs4, cifs (required)
    opts:   Mount options (defaults to "defaults")
    state:  "mounted" or "present" (defaults to mounted)
    dump:   Dump frequency for fstab (defaults to 0)
    passno: Fsck order for fstab (defaults to 0)
    mode:   Mode for the mount point directory (defaults to 0755)

Examples
--------

NFS entry:

```yaml
mount_entries:
  - path: /mnt/serve
    src: "{{ nfs_server_ip }}:{{ nfs_share_path }}"
    fstype: nfs
    opts: rw,sync,noatime,nfsvers=4,rsize=1048576,wsize=1048576,hard,intr,timeo=600,retrans=2
    state: mounted
```

CIFS entry (credentials via host/group vars):

```yaml
mount_entries:
  - path: /mnt/cifs_share
    src: //fileserver.example.com/share
    fstype: cifs
    opts: credentials=/etc/smb-credentials.txt,uid=1000,gid=1000,file_mode=0644,dir_mode=0755
```

Dependencies
------------

None (role installs its own client packages based on mount types).

Example Playbook
----------------

```yaml
- hosts: all
  become: yes
  vars:
    mount_entries:
      - path: /mnt/data
        src: nfs.example.com:/export/data
        fstype: nfs4
        opts: defaults
  roles:
    - infra.serverconfig.mounts
```

License
-------

BSD

Author Information
------------------

Miha Oblišar