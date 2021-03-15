CLOUD_SSH_TOKEN_NAME_ASK ?= $(shell bash -c 'read -p "Name of SSH access token [mock]: "  ssh_token;echo $$ssh_token')
CLOUD_ACCESS_TOKEN ?= $(shell bash -c 'read -p "Cloud access token: " access_token; echo $$access_token')

ifeq ($(CLOUD_SSH_TOKEN_NAME_ASK),)
CLOUD_SSH_TOKEN_NAME_ASK := mock
endif

dropletCheck:
	@echo "-------------Check VMs are ready for SSH connection-------------"
	./check.sh
	@echo "-------------VMs ready for ssh connection-----------------------"

terI:
	@echo "-------------Initialization terrafrom-------------"
	terraform init infrastructure/terraform/ 
	@echo "-------------Terraform initilizated---------------"

terP:
	@echo "-------------Create terraform plan----------------"
	terraform plan \
		-var ssh_token=${CLOUD_SSH_TOKEN_NAME_ASK} \
		-var at=${CLOUD_ACCESS_TOKEN} \
		infrastructure/terraform/
	@echo "-------------Terraform plan created---------------"

terA:
	@echo "-------------Create VMs via terraform-------------"
	terraform apply -auto-approve \
		-var ssh_token=${CLOUD_SSH_TOKEN_NAME_ASK} \
		-var at=${CLOUD_ACCESS_TOKEN} \
		infrastructure/terraform/
	@echo "-------------VMs created via terraform-------------"

terD:
	@echo "-------------Destroy infrastructure----------------"
	terraform destroy -auto-approve \
		-var at=${CLOUD_ACCESS_TOKEN} \
		infrastructure/terraform/
	@echo "-------------Infrastructure destroyed-------------"

terRecreate: terD terA
	@echo "-------------Infrastructure recreated-------------"

terAll: terI terP terA
	@echo "-------------All terraform steps completed-------------"

ansAll:
	@echo "-------------First run ansible playbook-------------------"
	ANSIBLE_CONFIG=./ansible/ansible.cfg \
	ansible-playbook \
		-i ./ansible/inventory_ata \
		-e vms_update=true \
		-e add_users=true \
		-e psql_install=true \
		-e pgadmin_install=true \
		-e docker_install=true \
		-e nginx_install=true \
		./ansible/main.yml
	@echo "-------------Ansible playbook completed-------------"

ansDB:
	@echo "-------------Run ansible role RDBMS-------------------"
	ANSIBLE_CONFIG=./ansible/ansible.cfg \
	ansible-playbook \
		-i ./ansible/inventory_ata \
		--tags db \
		-e vms_update=true \
		-e add_users=true \
		-e psql_install=true \
		./ansible/main.yml
	@echo "-------------Ansible role RDBMS completed-------------"

ansOCI:
	@echo "-------------Run ansible role web-------------------"
	ANSIBLE_CONFIG=./ansible/ansible.cfg \
	ansible-playbook \
		-i ./ansible/inventory_ata \
		-e vms_update=true \
		-e add_users=true \
		-e docker_install=true \
		-e nginx_install=true \
		--tags web \
		./ansible/main.yml
	@echo "-------------Ansible role web completed-------------"

mainCreate: terAll dropletCheck ansAll
	@echo "-------------All created-------------"
	@echo "RDBMS listen on the internal IP and user postgres:mock as login:password combination. PGADMIN on the public IP and default location."

mainRecreate: terRecreate  dropletCheck ansAll
	@echo "-------------All recreated-------------"
	@echo "RDBMS listen on the internal IP and user postgres:mock as login:password combination. PGADMIN on the public IP and default location."