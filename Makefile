ANSIBLE=ansible-playbook -i ansible_hosts --private-key vagrant_private_key

.PHONY: controller keystone glance vms

controller: keystone glance nova-controller

keystone:
	$(ANSIBLE) playbooks/keystone/setup.yaml

glance:
	$(ANSIBLE) playbooks/glance/setup.yaml

nova-controller:
	$(ANSIBLE) playbooks/nova/controller.yaml

vms:
	cd vms; vagrant up controller

