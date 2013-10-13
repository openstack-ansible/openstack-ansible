from netaddr import IPNetwork, IPAddress

def find_ip(*a, **kw):
    facts = a[0]
    network = IPNetwork(a[1])
    for addr_txt in facts['ansible_all_ipv4_addresses']:
        if IPAddress(addr_txt) in network:
            return addr_txt
    return None

def find_ipnet(*a, **kw):
    facts = a[0]
    network = IPNetwork(a[1])
    for addr_txt in facts['ansible_all_ipv4_addresses']:
        if IPAddress(addr_txt) in network:
            return addr_txt + "/" + str(network.prefixlen)
    return None

# FIXME: this could be more general. Right now, check if br-ex is there
# and has an address, if so, look for an interface w/out an ip, otherwise
# look for the matching one
def find_netdev(*a, **kw):
    facts = a[0]
    network = IPNetwork(a[1])
    if ('br-ex' in facts['ansible_interfaces'] and 
        'ipv4' in facts['ansible_br_ex']):

        for netdev in facts['ansible_interfaces']:
            if (netdev[:3] != 'br-' and 
                'ipv4' not in facts['ansible_' + netdev.replace('-', '_')]):
                return netdev
    else:

        for netdev in facts['ansible_interfaces']:
            devinfo = facts['ansible_' + netdev.replace('-', '_')]
            if ('ipv4' in devinfo and 
                IPAddress(devinfo['ipv4']['address']) in network):
                return netdev

    return None

class FilterModule(object):
    ''' utility filter to filter list of ips and get the one on the right
network '''

    def filters(self):
        return { 'find_ip' : find_ip,
                 'find_ipnet' : find_ipnet,
                 'find_netdev' : find_netdev }

