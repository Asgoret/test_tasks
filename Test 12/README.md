# Solution

## Migrate to Kubernetes

### Available technologies

#### VMs or instances

* AWS EC2
* GCP GCE

### Load balancing

* AWS ELB
* GCP CLB

### Kubernetes as a service

* AWS EKS
* GCP GKE
* Red Hat Openshift

### Kubernetes on-premise

* Kubernetes
* OKD

### Tools

* Ansible
* Terraform

### Cloud DB

* AWS RDS
* GCP SQL

### Prerequirements steps

1. Create a docker image of PHP application;
2. Test the image locally|minikube or in one of kubernetes-as-a-service service;
3. Specify all necessary kube-objects (e.g.: ingressroute\service\service account\role\role binding\etc);
4. Write all necessary yamls (another way is to write jsonnet template);
5. Write makefile with all deployment steps;
6. Write a simple pipeline for CI\CD tool.

### Scenarios for migration

#### Notes

Difference between self-hosted and cloud installations in abstraction levels. At self-hosted we create VMs for our k8s installation and at the cloud we get k8s as a service. Both methods have own strong and weak sides. For example, at self-hosted we can change SDN to whatever we want and have full control over the cluster. At cloud installation we don’t think about upgrades or troubleshooting.
Everything just works as expected.
Both methods have zero-downtime or minimum downtime on restart the PHP application (point #14 in a self-hosted way).

#### Self-hosted kubernetes

1. Create instance via terraform and configure it via ansible (install packages, configure docker, etc.);
2. Deploy kube-prometheus stack for monitoring and ELK stack for logging; 
3. Deploy app via CI\CD tool;
4. Make a dump of production base and create test DB for application in k8s (if DB is not very big);
5. Test deployed application with prod.information;
6. Replicate production DB to test DB;
7. Automate build and deploy to k8s (it can be additional stages in the old pipeline or post-action to trigger new job);
8. Again test that’s all works fine;
9. Reconnect app in the k8s to production DB;
10. Use on of load balancers and create canary deployment;
11. Wait for several days and ensure that there are no problems on client-side or in server-side; 
12. Ensure that DB in a new environment is same as old-master;
13. Switch master in DB cluster to a new DB instance;
14. Reconnect all applications;
15. Switch off old installation;
16. Delete all old endpoints (DB\application\etc.).

#### Cloud Kubernetes

1. Create a kubernetes cluster via terraform;
2. Deploy app via CI\CD tool;
3. Make a dump of production base and create test DB for application in k8s (if DB is not very big if it’s big we need part of data);
4. Test deployed application with prod.information;
5. Replicate production DB to test DB;
6. Automate build and deploy to k8s (it can be additional stages in the old pipeline or post-action to trigger new job);
7. Again test that’s all works fine;
8. Reconnect app in the cloud to production DB;
9. Use on of load balancers and create canary deployment;
10. Wait for several days and ensure that there are no problems on client-side or on server-side;
11. Ensure that DB in a new environment is same as old-master;
12. Switch master in DB cluster to a new DB instance;
13. Reconnect all applications;
14. Switch off old installations (app\DB);
15. Delete all old endpoints (DB\application\etc).

### Maintain and development

After migration into k8s maintains depends on the chosen scenario. If we choose the self-hosted k8s way we must think about the system and kernel update of host machines and so on. Also, don’t forget about k8s updates. If we choose cloud k8s we won’t need to think about maintains. We get k8s as a service. Simple CI\CD pipeline will be written in the migration process, so when we end the migration we will already have a new pipeline for building and deploying the application to k8s. As a future development plan I can define several milestones (each milestone have research and development step for choosing the correct tool):

* Add tool for searching sensitive data in source code (e.g.: truffleHog);
* Add static code analyzer (e.g.: sonarqube);
* Add unit tests (e.g.: PHPunit + Allure report);
* Container checks for vulnerabilities (e.g.: Harbor\JFROG Xray);
* Auto creating dev stand and run integration tests (e.g.: Aerocube Moon); ● Run stress testing (e.g.; JMeter);
* Add Continuous Deployment new code to production (if all previous steps were successful). So each commit or pull request can get to production fully automated.

As we use terraform, all information about our infrastructure will be stored in tfstate file, so we can push every change to the git repository and get version control over the infrastructure. For cases when somebody does something by manual work, terraform have import process, so we update our tfstate to the actual state or just destroy manual changes. Ansible is a little bit different tool. It hasn’t any state file and it’s his strong and weak point at the same time. With ansible we can just reconfigure the environment and know that it’s exactly as we wrote in the ansible. So every change in ansible playbooks must be pushed to the git repo and we get version control. There is an important thing with application in k8s, that in k8s have operators. It’s a simple system which controls his environment and makes sure that the manifest inside operator and the environment are the same. So when we deploy operator it deploys application by his own and controls its state. If you add manual changes, the operator simply erases it and bring the environment into accordance with his manifest.

### Culture and communication

Basing on my experience working on remote for the last several months I can say, that the best communication is a mix of voice and text chats. Discord will be the best option. He has some useful feature:

* Screen or window sharing;
* Mode walky-talky (when you press a button for talking. In skype, for example, you always talks, unless you mute yourself);
* RBAC for creating close channels for teams or managers or team leads;
* Good balance between voice and video (screen sharing);
* Flexible invitations (e.g.: expose time\usage limit);

Every morning I connect to team voice chat, say everybody hello and start working. When everybody is connected we have a maximum 30 minutes sink stand up where all team members say what they have done yesterday, what issues or problems they have and what they are going to do today. If we have some questions we just press the button and talk. All team members are hearing the conversation and can add some useful information or just be on the same page with all colleges. If there is some meeting, we just moving to another voice chat and start discussing. For fixing the results of meetings we use jira tickets or confluence. For not very important questions we can use the chat. Just wrote there your question with mention person from whom you want to get the answer and wait. Also, there is an important moment on remote work that you don’t know is your college at the computer now. To solve this problem we send “AFK” (Away From Keyboard) to the chat when somebody goes away and “BAK” (Back At Keyboard) when somebody comes back. Also, we write when we end work for today.
