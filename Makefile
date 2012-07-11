ANSIBLE=ansible-playbook -i ../../ansible_hosts --private-key ~/.vagrant.d/insecure_private_key setup.yaml

.PHONY: controller keystone

controller: keystone glance

keystone:
	cd playbooks/keystone; $(ANSIBLE)

glance:
	cd playbooks/glance; $(ANSIBLE)
