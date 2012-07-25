ANSIBLE=ansible-playbook -i ansible_hosts --private-key vagrant_private_key

.PHONY: controller keystone glance vms

controller: keystone glance

keystone:
	$(ANSIBLE) playbooks/keystone/setup.yaml


glance:
	$(ANSIBLE) playbooks/glance/setup.yaml

vms:
	cd vms; vagrant up controller

