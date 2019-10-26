#! /bin/bash

while [[ `ps aux | grep -i apt | wc -l` != 1 ]] ; do
    echo 'apt is locked by another process.'
    sleep 15
    ps aux | grep -i apt | wc -l
done

echo 'apt is free. Let`s continue.'

echo $'\n'

echo "------Set time------"
region=Europe
city=Moscow

RESULT=`timedatectl | grep " Time zone" | awk '{print $3}'`
if  [[ "$RESULT" == "$region/$city" ]]; then
    echo 'Time zone is already correct.'
else
    unlink /etc/localtime
    ln -s /usr/share/zoneinfo/$region/$city /etc/localtime
    echo 'Time was zone corrected.'
fi
echo "------Finish setting time------"

echo $'\n'

echo "------Set locale------"
locale=en_US.UTF-8
lc=C.UTF-8

RESULT=`locale | grep LC_ALL=$lc`
if [[ "$RESULT" == "LC_ALL=$lc" ]] ; then
    echo 'Locale is set already.'
else
    locale-gen $locale
    update-locale LC_ALL=$lc
    update-locale LANGUAGE=$lc
    echo 'Locale is set. User must logout and login or reboot system.'
fi
echo "------Finish setting locale------"

echo $'\n'

echo "------Change ssh port and set root login deny------"
old_ssh=22
new_ssh=2498

RESULT=`netstat -tnulp | grep '$old_ssh' | awk '{print $4}' | cut -d : -f 2`
if [[ "$RESULT" == 22 ]] ; then
    echo 'SSH is configured already.'
else
    sed -i "s/#Port $old_ssh/Port $new_ssh/g" /etc/ssh/sshd_config
    sed -i "s/#PermitRootLogin prohibit-password/PermitRootLogin no/g" /etc/ssh/sshd_config
    systemctl restart sshd
    echo 'SSH is configured.'
fi
echo "------Finish setting ssh port and root permissions------"

echo $'\n'

echo "------Create serviceuser------"
new_user=serviceuser

RESULT=`awk -F: '{ print $1}' /etc/passwd | grep $new_user`
if [[ "$RESULT" == "$new_user" ]] ; then
    echo 'User is already created.'
else
    useradd -m -p $(openssl passwd -1 serviceuser) -s /bin/bash $new_user
    usermod -aG sudo serviceuser
    echo "$new_user ALL=NOPASSWD:/bin/systemctl" >> /etc/sudoers
    echo "$new_user is created."
fi
echo "------End of user creating and configuring------"

echo $'\n'

echo "------Install NGINX------"
package=nginx

if  systemctl is-active --quiet $package ; then
    echo 'NGINX already installed and running.'
else
    apt update
    apt upgrade -y
    apt install $package -y
    systemctl start $package
    systemctl enable $package;
    echo "$package is installed."
fi
echo "------Installed NGINX------"

echo $'\n'

echo "------Install Monit------"
package=monit

if  systemctl is-active --quiet $package ; then
    echo "Monit already installed and running."
else
    apt update
    apt upgrade -y
    apt install $package -y
    cp /etc/nginx/sites-available/default /etc/nginx/sites-available/default.back
    unlink /etc/nginx/sites-enabled/default
    echo \
        'server {
            listen 80;
            server_name 127.0.0.1;

            location / {
                proxy_pass http://127.0.0.1:2812;
                proxy_set_header Host $host;
            }
        }' > /etc/nginx/sites-available/monit
    ln -s /etc/nginx/sites-available/monit /etc/nginx/sites-enabled/monit
    nginx -s reload
    sed -i 's/# set httpd/set httpd/i; s/#     use address/use address/i; s/#     allow localhost/allow localhost/i; s/#     allow admin:monit/allow devops:test/i' /etc/monit/monitrc
    echo \
        'check process nginx with pidfile /var/run/nginx.pid
            start program = "/etc/init.d/nginx start"
            stop program = "/etc/init.d/nginx stop"' >> /etc/monit/monitrc
    monit reload
    systemctl enable $package
    echo "$package is installed."
fi
echo "------Installed Monit------"

echo $'\n'

echo "------UFW configure------"

RESULT=`ufw status | grep Status: |awk '{print $2}'`
if [[ "$RESULT" == "active" ]] ; then
    echo 'UFW is start and configured already.'
else
    ufw --force enable
    ufw allow 2498
    ufw allow http
    ufw default deny incoming
    ufw default allow outgoing
    echo 'UFW is configured.'
fi
echo "------UFW configured------"