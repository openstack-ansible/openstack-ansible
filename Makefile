ANSIBLE=ansible-playbook

.PHONY: standard openstack-ansible-modules vagrant-private-key-perms standard-vms openstack demo destroy

standard: openstack demo

openstack: openstack-ansible-modules vagrant-private-key-perms standard-vms
	$(ANSIBLE) -i testcases/standard/ansible_hosts openstack.yaml

openstack-ansible-modules:
	git submodule init
	git submodule update

vagrant-private-key-perms:
	chmod 600 vagrant_private_key

standard-vms:
	cd testcases/standard; vagrant up

demo: openstack-ansible-modules vagrant-private-key-perms standard-vms openstack
	$(ANSIBLE) -i testcases/standard/ansible_hosts demo.yaml

destroy:
	cd testcases/standard; vagrant destroy --force
