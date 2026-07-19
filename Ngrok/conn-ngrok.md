## Check firewall

Make sur firewall is enable allow

```bash
sudo ufw status
```

## Install the ngrok in Ubuntu 

```bash
curl -sSL https://ngrok-agent.s3.amazonaws.com/ngrok.asc \
  | sudo tee /etc/apt/trusted.gpg.d/ngrok.asc >/dev/null \
  && echo "deb https://ngrok-agent.s3.amazonaws.com bookworm main" \
  | sudo tee /etc/apt/sources.list.d/ngrok.list \
  && sudo apt update \
  && sudo apt install ngrok
```

## Bring your domain

```bash
http ngrok 3000
```

## Add your authtoken

After you signup ngrok.com

```bash
ngrok config add-authtoken $YOUR_AUTHTOKEN
```