* loop over storage nodes + devices / do delegation to proxy to add
* move from grizzly to havana
* implement cinder, heat, ceilometer, moniker
* need to run quantum-ovs-cleanup before dhcp or l3
* needs to not run virtualbox stuff in real world
* admin user in admin network
* move setup.yaml to using demo (non-admin) user
    - quantum setup should create public network as shared
* performance issues with keystone/mysql ... mysql performance tuning and/or 
  switch to memcache?
* augeas instead of templates?
* make sure vm and ping out..
* iptables?!
* allow possibility of separate rabbit/mysqld for each service...
* script to bring up networking needs to re-add gateway device for real world
* script to bring up networking needs to run in the real-world...
