# OpenStack on Ansible with Vagrant

This repository contains script that will deploy OpenStack into Vagrant virtual machines.

## Install prereqs

You'll need to install:

 * [Vagrant](http://vagrantup.com)
 * [Ansible](http://ansible.github.com)

The simplest way to get started with Ansible is to install the prequisities,  grab the git repo and source the appropriate file to set your environment variables, no other installation is required:

	sudo pip install paramiko PyYAML Jinja2
	git clone git://github.com/ansible/ansible.git
	cd ./ansible
	source ./hacking/env-setup

## Get an Ubuntu 12.04 (precise) image

Download a 64-bit Ubuntu image:

	vagrant box add precise64 http://files.vagrantup.com/precise64.box

## Grab this repository

	git clone http://github.com/lorin/openstack-ansible

## Bring up the VMs

	cd openstack-ansible/vms
	vagrant up

This will boot three VMs, which we will use as hosts:

 * 192.168.206.130 (our cloud controller)
 * 192.168.206.131 (compute host #1)
 * 192.168.206.132 (compute host #2)


You should be able to ssh to them (username: `vagrant`, password: `vagrant`).
You can also authenticate  with the vagrant private key, which is included
here as the file `vagrant_private_key`.


