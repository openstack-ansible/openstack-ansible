# OpenStack on Ansible with Vagrant

This repository contains script that will deploy OpenStack into Vagrant virtual
machines. These scripts are based on the [Official OpenStack
Docmentation](http://docs.openstack.org/), havana release, except where
otherwise noted.

See also [Vagrant, Ansible and OpenStack on your laptop]
(http://www.slideshare.net/lorinh/vagrant-ansible-and-openstack-on-your-laptop)
on SlideShare, though this refers to a much older version of this repo and so is 
now out of date.

## Install prereqs

You'll need to install:

* [Vagrant](http://vagrantup.com)
* [Ansible](http://ansible.github.com)
* [python-netaddr](https://pypi.python.org/pypi/netaddr/)
* [python-novaclient](https://pypi.python.org/pypi/python-novaclient) (recommended)

To get started with the development branch of Ansible, install the prerequisites,
grab the git repo and source the appropriate file to set your environment
variables, no other installation is required:

	sudo pip install paramiko PyYAML Jinja2 netaddr python-novaclient
	git clone git://github.com/ansible/ansible.git
	cd ./ansible
	source ./hacking/env-setup


## Get an Ubuntu 12.04 (precise) Vagrant box

Download a 64-bit Ubuntu Vagrant box:

	vagrant box add precise64 http://files.vagrantup.com/precise64.box

## Grab this repository

This repository uses a submodule that contains some custom Ansible modules for
OpenStack, so there's an extra command required after cloning the repo:

    git clone http://github.com/openstack-ansible/openstack-ansible.git
    cd openstack-ansible
    git submodule update --init

## Bring up the cloud

    make

This will boot three VMs (controller, network, storage, and a compute node),
install OpenStack, and attempt to boot a test VM inside of OpenStack.

If everything works, you should be able to ssh to the instance from any
of your vagrant hosts:

 * username: `cirros`
 * password: `cubswin:)`

Note: You may get a "connection refused" when attempting to ssh to the instance.
It can take several minutes for the ssh server to respond to requests, even
though the cirros instance has booted and is pingable.

## Vagrant hosts

The hosts for the standard configuration are:

 * 10.1.0.2 (our cloud controller)
 * 10.1.0.3 (compute node #1)
 * 10.1.0.4 (the quantum network host)
 * 10.1.0.5 (the swift storage host)

You should be able to ssh to these VMs (username: `vagrant`, password:
`vagrant`). You can also authenticate  with the vagrant private key, which is
included here as the file `vagrant_private_key` (NOTE: git does not manage file
permissions, these must be set to using "chmod 0600 vagrant_private_key" or ssh
and ansible will fail with an error).

## Interacting with your cloud

You can interact with your cloud directly from your desktop, assuming that you
have the [python-novaclient](http://pypi.python.org/pypi/python-novaclient/)
installed.

Note that the openrc file will be created on the controller by default.
