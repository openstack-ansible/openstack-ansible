from netaddr import IPNetwork, IPAddress

def ipmatch(*a, **kw):
    addr_list = a[0]
    network = a[1]
    return next((addr for addr in addr_list 
                 if IPAddress(addr) in IPNetwork(network)), None)

class FilterModule(object):
    ''' utility filter to filter list of ips and get the one on the right
network '''

    def filters(self):
        return { 'ipmatch' : ipmatch }
            
