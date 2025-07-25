
#--------------------------------------------------------
# Background: WSL UDP port forwarding
#--------------------------------------------------------

# Microsoft recommends "netsh interface portproxy" for port forwarding, but it does not support UDP for now.
# See https://learn.microsoft.com/en-us/windows/wsl/networking#accessing-a-wsl-2-distribution-from-your-local-area-network-lan.

# For UDP port forwarding, you can use Windows NAT mechanism.
# See https://gist.github.com/the-moog/e7a1b5150ce9017309afbcf91848e622.

#--------------------------------------------------------
# Configure Windows NAT for port forwarding
#--------------------------------------------------------

# It's hard to configure the default WSL NAT network, which is blackbox, to do port forwarding.
# Instead, set up a new NAT network for port forwarding.
# The new NAT network must not conflict with the default WSL NAT network.

$addr_wsl_switch = "192.168.1.107"

$addr_wsl_guest = "192.168.1.108"

$nat_addr = "192.168.1.0/24"

$bigport = 12000
$smallport = 11000
$nports= ($bigport-$smallport+1)
$njobs= 1
$ports_per_job= ($nports/$njobs)
$remaining_ports= ($nports%$njobs)
# Assign new IP address to WSL switch
# Two IP addresses must be configured, one for the WSL switch and one for the guest, as follows:
#   WSL switch: 192.168.100.1
#   WSL guest: 192.168.100.2
New-NetIPAddress -InterfaceAlias "vEthernet (WSL)" -IPAddress $addr_wsl_guest -PrefixLength 24

# Add NAT network
New-NetNat -Name "WSL-NAT" -InternalIPInterfaceAddressPrefix  $nat_addr

$curr_port=$small_port

For($j=1;$j -le $njobs;$j++){
   $start_port = $smallport + ($j * $ports_per_job)
    $end_port = $start_port + $ports_per_job - 1
    Start-Job -ScriptBlock {
        param($low_lim, $high_lim, $addr_wsl_guest)
        For ($i = $low_lim; $i -le $high_lim; $i++) {
            Add-NetNatStaticMapping -NatName "WSL-NAT" -Protocol UDP -ExternalIPAddress 0.0.0.0/0 -ExternalPort $i -InternalIPAddress $addr_wsl_guest -InternalPort $i
            Add-NetNatStaticMapping -NatName "WSL-NAT" -Protocol TCP -ExternalIPAddress 0.0.0.0/0 -ExternalPort $i -InternalIPAddress $addr_wsl_guest -InternalPort $i
        }
    } -ArgumentList $start_port, $end_port, $addr_wsl_guest | Wait-Job
}

#--------------------------------------------------------
# Configure WSL guest to assign IP address
#--------------------------------------------------------

# Configure new IP address on WSL
# The new IP address needs to be the same as the one specified in port forwarding

wsl -u root ip address add $addr_wsl_guest/24 dev eth0