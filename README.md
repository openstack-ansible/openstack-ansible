# OpenStack on Ansible with Vagrant

This repository contains script that will deploy OpenStack into Vagrant
virtual machines. These scripts are based on the [OpenStack Install and
Deploy Manual](http://docs.openstack.org/essex/openstack-compute/install/apt/content/),
Essex release.

## Install prereqs

You'll need to install:

 * [Vagrant](http://vagrantup.com)
 * [Ansible](http://ansible.github.com)
 * [python-novaclient](http://pypi.python.org/pypi/python-novaclient/2.6.10) so you can control your instances with the `nova` command-line tool.

The simplest way to get started with Ansible is to install the prequisities,  grab the git repo and source the appropriate file to set your environment variables, no other installation is required:

	sudo pip install paramiko PyYAML Jinja2
	git clone git://github.com/ansible/ansible.git
	cd ./ansible
	source ./hacking/env-setup



## Get an Ubuntu 12.04 (precise) Vagrant box

Download a 64-bit Ubuntu Vagrant box:

	vagrant box add precise64 http://files.vagrantup.com/precise64.box

## Grab this repository

	cd ~
	git clone http://github.com/lorin/openstack-ansible

## Bring up the cloud

	cd ~/openstack-ansible
	make all

This will boot two VMs, install OpenStack, and attempt to boot a test VM
inside of OpenStack.

If everything works, you should be able to ssh to the instance:

 * username: `cirros`
 * password: `cubswin:)`

Note: You may get a "connection refused" when attempting to ssh to the instance. It can take several minutes for the ssh server to respond to requests, even though the cirros instance has booted and is pingable.


## Vagrant hosts

The hosts are:

 * 192.168.206.130 (our cloud controller)
 * 192.168.206.131 (compute host #1)

You should be able to ssh to these VMs (username: `vagrant`, password: `vagrant`).
You can also authenticate  with the vagrant private key, which is included
here as the file `vagrant_private_key`.

