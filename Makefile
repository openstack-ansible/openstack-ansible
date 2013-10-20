ANSIBLE=ansible-playbook 

.PHONY: standard standard-vms openstack destroy setup

standard: openstack-ansible-modules standard-vms openstack setup

openstack-ansible-modules:
	git submodule init
	git submodule update

vagrant-private-key-perms:
	chmod 600 vagrant_private_key

standard-vms:
	cd testcases/standard; vagrant up

openstack: openstack-ansible-modules vagrant-private-key-perms
	$(ANSIBLE) -i testcases/standard/vagrant_hosts openstack.yaml

setup: vagrant-private-key-perms
	$(ANSIBLE) -i testcases/standard/vagrant_hosts setup.yaml

destroy:
	cd testcases/standard; vagrant destroy --force

