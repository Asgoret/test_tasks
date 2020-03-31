# Task 2

## Standard track

1. Crete vagrantfile for six hosts (based on `ubuntu/xenial64`) with ip adreses from one ip pool and put in near readme file
2. Create ansible playbook for:

    - On three hosts configure vrrp neighborhood with three virtual hosts
    - deploy two tenants (one, two) Distributed Minio on six hosts (use systemd unit files)
    - Configure instances of Nginx in reverse proxy mode and balancing mode for all deployed tenants
    - On health checks on nginx for vrrp daemon
    - playbook put in root of task near vagrantfile
    - Create make file with commands for start deploying instances and for ansible playbook

3. Use ad-hoc ansible commands:

    - create users and grant them read\write permissions
    - upload random files into tenant two of minio
    - all command write into documentation file

4. Prepare script on python\go\bash, which will download file from minio
