

New-NetFirewallRule -DisplayName 'Custom Inbound emotion streamer' -Profile @('Domain', 'Private') -Direction Inbound -Action Allow -Protocol TCP -LocalPort 8001

New-NetFirewallRule -DisplayName 'Custom Outbound emotion streamer' -Profile @('Domain', 'Private') -Direction Outbound -Action Allow -Protocol TCP -LocalPort 8001