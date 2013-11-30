* loop over storage nodes + devices / do delegation to proxy to add
* current playbook assumes swift client on keystone...
* fix verbose/debug in config files...
* move from grizzly to havana
* implement cinder, heat, ceilometer, moniker
* need to run quantum-ovs-cleanup before dhcp or l3
* configuration option for repo to allow use of different mirror
* script to bring up networking needs to re-add gateway device for real world
* script to bring up networking needs to run in the real-world...
* needs to not run virtualbox stuff in real world
* iptables?!
* admin user in admin network
* move setup.yaml to using demo (non-admin) user
    - quantum setup should create public network as shared
* performance issues with keystone/mysql ... mysql performance tuning and/or 
  switch to memcache?
* augeas instead of templates?
* make sure vm and ping out..
* allow possibility of separate rabbit/mysqld for each service...
