#!/bin/bash
# Efehan Pi 4B - Tek Seferlik Hotspot ve Internet Paylaşım Kurulumu

echo "Kurulum başlıyor..."

# 1. Hotspot yapılandırması
sudo nmcli con add type wifi ifname wlan0 con-name "Efehan_Hotspot" autoconnect yes ssid "Efehan Raspberry Pi 4B 8Gb"
sudo nmcli con modify "Efehan_Hotspot" ipv4.addresses 10.42.0.1/24 ipv4.method shared
sudo nmcli con modify "Efehan_Hotspot" 802-11-wireless.mode ap 802-11-wireless.band bg
sudo nmcli con modify "Efehan_Hotspot" wifi-sec.key-mgmt wpa-psk
sudo nmcli con modify "Efehan_Hotspot" wifi-sec.psk "*Efehan*"

# 2. IP yönlendirmeyi kalıcı hale getir
echo "net.ipv4.ip_forward=1" | sudo tee /etc/sysctl.d/99-ip-forward.conf
sudo sysctl -p /etc/sysctl.d/99-ip-forward.conf

# 3. Güç optimizasyonu
sudo iwconfig wlan0 power off

# 4. Bağlantıyı başlat
sudo nmcli con up "Efehan_Hotspot"

echo "Kurulum bitti! Pi artık 'Efehan Raspberry Pi 4B 8Gb' olarak yayında."
echo "Diğer ağlara bağlanmak istediğinde ağ simgesine tıklayıp seçmen yeterli."