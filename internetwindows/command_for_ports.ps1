
netsh interface portproxy add v4tov4 listenport=11001 listenaddress=0.0.0.0 connectport=11001 connectaddress="wsl hostname -I"