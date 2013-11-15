ANSIBLE=ansible-playbook 

.PHONY: standard openstack-ansible-modules vagrant-private-key-perms standard-vms openstack setup destroy

standard: openstack setup

openstack: openstack-ansible-modules vagrant-private-key-perms standard-vms
	$(ANSIBLE) -i testcases/standard/ansible_hosts openstack.yaml

openstack-ansible-modules:
	git submodule init
	git submodule update

vagrant-private-key-perms:
	chmod 600 vagrant_private_key

standard-vms:
	cd testcases/standard; vagrant up

setup: openstack-ansible-modules vagrant-private-key-perms standard-vms openstack
	$(ANSIBLE) -i testcases/standard/ansible_hosts setup.yaml

destroy:
	cd testcases/standard; vagrant destroy --force

