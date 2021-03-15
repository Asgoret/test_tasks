#! /bin/bash

# Create list VMs IP
mapfile -t droplets < <(grep 'ansible_host=' ./ansible/inventory_ata | awk '{print $2}' | sed 's/ansible_host=//' | sort | uniq)

for i in "${droplets[@]}"; do
    while ! nmap $i -PN -p ssh | egrep 'open' > /dev/null
    do
        echo "VM $i not ready for SSH connection."
        echo "Sleep for 15 sec"
        sleep 15s
    done
done