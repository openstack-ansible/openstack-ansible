ANSIBLE=ansible-playbook -i ansible_hosts --private-key vagrant_private_key

.PHONY: controller keystone glance vms ssh

all: vms controller compute

controller: keystone glance nova-controller

keystone:
	$(ANSIBLE) playbooks/keystone/setup.yaml

glance:
	$(ANSIBLE) playbooks/glance/setup.yaml

nova-controller:
	$(ANSIBLE) playbooks/nova/controller.yaml

vms:
	cd vms; vagrant up

compute:
	$(ANSIBLE) playbooks/nova/compute-host.yaml

ssh:
	cd vms; vagrant ssh controller

destroy:
	cd vms; vagrant destroy --force

