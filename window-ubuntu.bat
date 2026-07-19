@echo off

:: C:\Program path the tailscale execute.

echo Starting Tailscale connection...
"C:\Program Files\Tailscale IPN\tailscale.exe" up

echo Connecting to Ubuntu...
ssh minipc@100.119.121.108

echo SSH session ended. Disconnecting Tailscale...
"C:\Program Files\Tailscale IPN\tailscale.exe" down

echo Done.
pause
