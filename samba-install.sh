#!/bin/bash

# Instala o Samba
sudo apt install -y samba

# Adiciona as configurações ao smb.conf
echo -e "\n[share]\n    comment = Ubuntu File Server Share\n    path = /srv/samba/share\n    browsable = yes\n    guest ok = yes\n    read only = no\n    create mask = 0755" | sudo tee -a /etc/samba/smb.conf > /dev/null

# Cria o diretório de compartilhamento se não existir
sudo mkdir -p /srv/samba/share

# Define as permissões do diretório
sudo chown nobody:nogroup /srv/samba/share/

# Reinicia os serviços Samba
sudo systemctl restart smbd.service nmbd.service
