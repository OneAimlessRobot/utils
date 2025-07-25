
# Replace with your desired ports and WSL IP
$ports = "11007", "11008" # Example: forward ports 8080 and 8081
$wslIp = "$(wsl hostname -I)".Trim() #Get the WSL IP
$ports | ForEach-Object {
    $port = $_
    # Add port proxy
    netsh interface portproxy add v4tov4 listenport=$port listenaddress=0.0.0.0 connectport=$port connectaddress=$wslIp
    # Allow inbound firewall rule
    New-NetFirewallRule -DisplayName "WSL2 Port Bridge - UDP" -Direction Inbound -Action Allow -Protocol UDP -LocalPort $port
    New-NetFirewallRule -DisplayName "WSL2 Port Bridge - UDP" -Direction Outbound -Action Allow -Protocol UDP -LocalPort $port
}
Write-Host "UDP ports forwarded: $($ports -join ', ')"