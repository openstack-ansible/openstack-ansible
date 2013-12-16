ANSIBLE=ansible-playbook

.PHONY: standard openstack-ansible-modules vagrant-private-key-perms frontback-vms openstack demo destroy

standard: openstack demo

openstack: openstack-ansible-modules vagrant-private-key-perms frontback-vms
	$(ANSIBLE) -i testcases/frontback/ansible_hosts openstack.yaml

openstack-ansible-modules:
	git submodule init
	git submodule update

vagrant-private-key-perms:
	chmod 600 vagrant_private_key

frontback-vms:
	cd testcases/frontback; vagrant up

demo: openstack-ansible-modules vagrant-private-key-perms frontback-vms openstack
	$(ANSIBLE) -i testcases/frontback/ansible_hosts demo.yaml

destroy:
	cd testcases/frontback; vagrant destroy --force
