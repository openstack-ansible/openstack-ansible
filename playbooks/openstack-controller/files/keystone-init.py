#!/usr/bin/env python
# Copyright 2012 Nimbis Services, Inc.
"""

Script for initializing OpenStack Identity service (keystone).

Usage: keystone-init.py config.yaml

Edit the provided config.yaml file for your setup.

"""
import sys
import yaml

from keystoneclient.v2_0 import client


def parse_config(fname):
    """Read the YAML config file and return a dict with the values"""
    data = yaml.load(open(fname))
    return data


def configure_keystone(config):
    """Configure keystone using a dict with config fvalues"""
    keystone = client.Client(token=config['token'],
                             endpoint=config['endpoint'])
    default_tenant = create_default_tenant(keystone, config)
    default_user = create_default_user(keystone, config, default_tenant)
    admin_role = create_default_roles(keystone, config, default_tenant,
                                      default_user)
    service_tenant = create_service_tenant(keystone, config)
    create_service_users(keystone, config, service_tenant, admin_role)
    create_services_and_endpoints(keystone, config)


def create_default_tenant(keystone, config):
    """Create the default tenant and return it"""
    tenant_dict = config['default tenant']
    name = tenant_dict['name']
    desc = tenant_dict['description']
    return keystone.tenants.create(tenant_name=name, description=desc,
                                   enabled=True)


def create_default_user(keystone, config, tenant):
    """Create the default (admin) user and return it"""
    name = config['default user']['name']
    password = config['default user']['password']
    user = keystone.users.create(name=name, password=password, email="None",
                                 tenant_id=tenant.id)
    return user


def create_default_roles(keystone, config, tenant, user):
    """Create the admin and member roles.

    Grant the admin role to the given user in the given tenant.

    Return the admin role
    """
    keystone.roles.create('memberRole')
    admin_role = keystone.roles.create('admin')
    keystone.roles.add_user_role(user, admin_role, tenant)
    return admin_role


def create_service_tenant(keystone, config):
    """Create the service tenant and return it"""
    return keystone.tenants.create(tenant_name="service",
                            description="Service Tenant", enabled=True)


def create_service_users(keystone, config, tenant, role):
    """Create a user for each service it and grant it a role in the tenant"""
    for d in config['service users']:
        user = keystone.users.create(name=d['name'], password=d['password'],
                                     email="None", tenant_id=tenant.id)
        keystone.roles.add_user_role(user, role, tenant)


def create_services_and_endpoints(keystone, config):
    for d in config['services and endpoints']:
        service = keystone.services.create(name=d['name'],
                                           service_type=d['type'],
                                           description=d['description'])
        keystone.endpoints.create(region=d['region'], service_id=service.id,
                                  publicurl=d['publicurl'],
                                  adminurl=d['adminurl'],
                                  internalurl=d['internalurl'])

if __name__ == '__main__':
    if len(sys.argv) != 2:
        print "Usage: keystone-init.py config-file.yaml"
        sys.exit(-1)
    config = parse_config(sys.argv[1])
    configure_keystone(config)
