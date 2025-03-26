

New-NetFirewallRule -DisplayName 'Custom Inbound emotion streamer' -Profile @('Domain', 'Private') -Direction Inbound -Action Allow -Protocol TCP -LocalPort 30000-60000

New-NetFirewallRule -DisplayName 'Custom Inbound emotion streamer' -Profile @('Domain', 'Private') -Direction Outbound -Action Allow -Protocol TCP -LocalPort 30000-60000

New-NetFirewallRule -DisplayName 'Custom Inbound emotion streamer' -Profile @('Domain', 'Private') -Direction Inbound -Action Allow -Protocol UDP -LocalPort 30000-60000

New-NetFirewallRule -DisplayName 'Custom Inbound emotion streamer' -Profile @('Domain', 'Private') -Direction Outbound -Action Allow -Protocol UDP -LocalPort 30000-60000