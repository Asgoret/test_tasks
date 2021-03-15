# Case

Create 3 VMs with different OS (Ubuntu|CentOS) all latest versions in the cloud with two networks (public|private). Use terraform for creating cloud infrastructure and ansible for configuration.

## Tasks

1. Setup PostgreSQL server using last stable version (1 instance) additional setup on similar VM pgadmin;
2. Use special demo database dump to populate installed DB host:
    * for dev use demo-small link
    * for stage use demo-medium link
    * for big use demo-big link
3. Setup 2 VMs with nginx server installed inside Docker container (use official image). Setup virtual servers with different names depending on existing VM hostname and environment name (like web-0[1-2]). Configure nginx special way to return “Hello ”, where is the same name like web-0[1-2] for all requests to virtual server no matter path name.
4. Add local ssh users for each server: fred, mark, adam and setup authorized keys for them. Make sure they can use sudo.

```bash
    fred: ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICn2jLmrDKYwt1zouEjyAwdItBJ2A2MyULwLr1IbF5rz
    mark: ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBQh0DIHOIs4ZBok6F8I2JmZGcdu6NPS8R7cY5ndQaID
    adam: ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPY89d+z8ZjNPuqNUJ/Ny3X4PxDGz1LAWzSeMWBD1iwG
```
