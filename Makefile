ANSIBLE=ansible-playbook
TAGS=-t mysql

.PHONY: all vms controller keystone glance nova-controller vms compute destroy run

openstack: openstack-ansible-modules
	ansible-playbook openstack.yaml $(TAGS)

openstack-ansible-modules:
	git submodule init
	git submodule update

all: vms controller compute run

controller: vms keystone glance nova-controller

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

destroy:
	cd vms; vagrant destroy --force

run:
	./boot-cirros.sh

