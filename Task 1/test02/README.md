# Test 02

Create an CM role that sets up the following system properties on Ubuntu 18.04 server:

* Time zone
* Locale
* Move sshd to listen port 2498 instead of 22
* Deny remote login as `root` user
* Add the `serviceuser` account to system
* Grant sudo rights to the `serviceuser`
* Limit `serviceuser` sudo rights to start|stop|restart services
* Deploy Nginx server and make it autostart on reboot
* Deploy Monit server and make it autostart on reboot
* Set Nginx to proxy requests to the Monit server with the basic auth using `devops`/`test` credentials.

## Bonus track

* Configure UFW
