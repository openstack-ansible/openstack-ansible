from netaddr import IPNetwork, IPAddress

# FIXME: semantically loose since addr refers to text not addy object, unlike
# network...also, would be better to have simpler calling semantics...

def ipmatch(*a, **kw):
    addr_list = a[0]
    network = IPNetwork(a[1])
    return next((addr for addr in addr_list 
                 if IPAddress(addr) in network), None)

def ipnetmatch(*a, **kw):
    addr_list = a[0]
    network = IPNetwork(a[1])
    ipaddr =  next((addr for addr in addr_list 
                    if IPAddress(addr) in network), None)

    return ipaddr + "/" + str(network.prefixlen)

def netdevmatch(*a, **kw):
    facts = a[0]
    network = IPNetwork(a[1])
    for netdev in facts['ansible_interfaces']:
        if ('ansible_' + netdev in facts and
            'ipv4' in facts['ansible_' + netdev] and
            IPAddress(facts['ansible_' + netdev]['ipv4']['address']) 
            in network):
            return netdev
    return None

class FilterModule(object):
    ''' utility filter to filter list of ips and get the one on the right
network '''

    def filters(self):
        return { 'ipmatch' : ipmatch,
                 'ipnetmatch' : ipnetmatch,
                 'netdevmatch' : netdevmatch }
