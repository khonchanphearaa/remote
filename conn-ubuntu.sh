#!/bin/bash

# ssh remote Ubuntu via tailscale applications conenction with start conn and close conntions

echo "Start tailscale connection..."
tailscale up

echo "Connection Ubuntu..."
ssh -t minipc@YOU_IP_UBUNTU 'bash -s' < ~/insert_admin.sh

echo "Stop disconnect tailscale..."
tailscale down

echo "Done."
 


