#TAGS=-t keystone
#CHECK=--check

ANSIBLE=ansible-playbook -v $(TAGS) $(CHECK)

.PHONY: all vms openstack controller keystone glance nova-controller vms compute destroy run

openstack: openstack-ansible-modules
	chmod 0600 vagrant_private_key
	$(ANSIBLE) openstack.yaml

openstack-ansible-modules:
	git submodule init
	git submodule update

all: openstack-ansible-modules vms openstack run

vms:
	cd vms; vagrant up
destroy:
	cd vms; vagrant destroy --force

run:
	./boot-cirros.sh

