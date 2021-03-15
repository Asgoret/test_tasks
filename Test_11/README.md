# Solution documentation

## Requirements

* Terraform version with providers:
  * terraform: `v0.14.7`
    * digitalocean: `v2.5.1`
    * null: `v3.1.0`
    * template: `v2.2.0`
* Python & ansible:
  * Python: `3.8.5`
    * GCC: `9.3.0`
  * Ansible: `2.9.6`
* Make version:
  * GNU Make: `4.2.1`

## Folder structure

```bash
Test_11/                # Root directory
├─ ansible/             # Ansible folder with roles
│  ├─ ansible.cfg       # Ansible configuration file
│  ├─ group_vars        # Folder with group variables
│  │  ├─ ATA.yml        # Variable file for group ATA
│  ├─ main.yml          # Root ansible file with included roles
│  ├─ roles             # Folder with ansible roles
│  │  ├─ front          # Role for front nodes
│  │  ├─ prepare        # Common role for node prepares
│  │  ├─ rdbms          # Role for RDBMS nodes
├─ infrastructure/      # Root terraform folder
│  ├─ template          # Folder for templates between terraform and ansible
│  │  ├─ inventory      # Template for inventory
│  ├─ terraform         # Root terraform folder for tf files
│  │  ├─ *.tf           # Multiple tf files
├─ Makefile             # Makefile with all commands
├─ README.md            # File with solution description
├─ solution.md          # File with task description
├─ check.sh             # Small script for checking droplets available for ssh connection
```

## Makefile commands

* Main commands
  * Create `mainCreate`
  * Recreate `mainRecreate`
* Terraform solo commands
  * Initialization `terI`
  * Plan `terP`
  * Apply `terA`
  * Destroy `terD`
* Ansible solo commands
  * Create all roles `ansAll`
  * Configure RDBMS `ansDB`
  * Configure front `ansOCI`
