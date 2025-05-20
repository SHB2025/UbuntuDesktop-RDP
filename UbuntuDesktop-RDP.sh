#!/bin/bash

# Omogućavanje RDP konekcije putem xrdp na Ubuntu desktop sistemu

set -e

echo "[*] Ažuriranje paketa..."
sudo apt update

echo "[*] Instalacija xrdp..."
sudo apt install -y xrdp

echo "[*] Pokretanje i omogućavanje xrdp servisa..."
sudo systemctl start xrdp
sudo systemctl enable xrdp

echo "[*] Ponovno pokretanje xrdp servisa..."
sudo systemctl restart xrdp

echo "[*] Provjera statusa xrdp servisa..."
sudo systemctl status xrdp

echo "[*] Dodavanje xrdp korisnika u ssl-cert grupu..."
sudo adduser xrdp ssl-cert

echo "[*] Ponovno pokretanje xrdp radi primjene grupa..."
sudo systemctl restart xrdp

echo "[*] Konfiguracija UFW vatrozida..."
sudo ufw allow 3389/tcp

echo "[*] Aktivacija UFW ako već nije aktivirana..."
sudo ufw --force enable

echo "[*] Ponovno učitavanje UFW pravila..."
sudo ufw reload

echo "[*] Prikaz statusa UFW-a..."
sudo ufw status verbose

# Ispis IP adrese
IP_ADDR=$(hostname -I | awk '{print $1}')

echo ""
echo "[✓] RDP je konfigurisan i spreman."
echo "[i] Možete se povezati sa sljedećom IP adresom preko RDP klijenta:"
echo "    IP adresa: $IP_ADDR"
echo "    Port: 3389"
