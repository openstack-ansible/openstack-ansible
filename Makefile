controller:
	cd playbooks/openstack-controller; \
	ansible-playbook -i ../../ansible_hosts --private-key ~/.vagrant.d/insecure_private_key setup.yaml