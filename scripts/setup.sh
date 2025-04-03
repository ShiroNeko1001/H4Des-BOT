#!/bin/bash

# Fungsi untuk menampilkan pesan
print_message() {
    echo -e "\n\033[1;32m$1\033[0m"
}

# Fungsi untuk menampilkan error
print_error() {
    echo -e "\n\033[1;31mError: $1\033[0m"
    exit 1
}

# Cek apakah script dijalankan sebagai root
if [ "$EUID" -ne 0 ]; then
    print_error "Script ini harus dijalankan sebagai root. Gunakan sudo!"
fi

print_message "Memulai instalasi Linux Server Bot..."

# Update package lists
print_message "Mengupdate daftar paket..."
apt-get update || print_error "Gagal mengupdate daftar paket"

# Install dependensi sistem dan Gnome
print_message "Menginstal dependensi sistem dan Gnome..."
apt-get install -y \
    python3-pip \
    python3-venv \
    openssh-server \
    tightvncserver \
    gnome-session \
    gnome-shell \
    gnome-terminal \
    gnome-tweaks \
    gnome-control-center \
    gnome-backgrounds \
    gnome-system-monitor \
    nautilus \
    gedit \
    git \
    curl \
    wget \
    net-tools \
    ufw \
    fail2ban \
    nginx \
    certbot \
    python3-certbot-nginx \
    build-essential \
    python3-dev \
    libssl-dev \
    libffi-dev \
    python3-setuptools \
    python3-wheel \
    python3-cryptography \
    python3-openssl \
    python3-paramiko \
    python3-flask \
    python3-flask-socketio \
    python3-yaml \
    python3-dotenv \
    python3-gi \
    python3-gi-cairo \
    gir1.2-gtk-3.0 \
    gir1.2-glib-2.0 \
    gir1.2-gdkpixbuf-2.0 \
    gir1.2-pango-1.0 \
    gir1.2-atk-1.0 || print_error "Gagal menginstal dependensi sistem"

# Konfigurasi SSH
print_message "Mengkonfigurasi SSH..."
sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin no/' /etc/ssh/sshd_config
sed -i 's/#PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config
systemctl restart ssh || print_error "Gagal merestart SSH"

# Konfigurasi Firewall
print_message "Mengkonfigurasi Firewall..."
ufw default deny incoming
ufw default allow outgoing
ufw allow ssh
ufw allow 5000/tcp  # Port web interface
ufw allow 5900/tcp  # Port VNC
ufw --force enable || print_error "Gagal mengaktifkan firewall"

# Konfigurasi Fail2ban
print_message "Mengkonfigurasi Fail2ban..."
cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.local
sed -i 's/bantime  = 10m/bantime  = 1h/' /etc/fail2ban/jail.local
sed -i 's/findtime  = 10m/findtime  = 10m/' /etc/fail2ban/jail.local
sed -i 's/maxretry = 5/maxretry = 3/' /etc/fail2ban/jail.local
systemctl restart fail2ban || print_error "Gagal merestart Fail2ban"

# Buat virtual environment
print_message "Membuat virtual environment Python..."
python3 -m venv venv || print_error "Gagal membuat virtual environment"
source venv/bin/activate || print_error "Gagal mengaktifkan virtual environment"

# Install dependensi Python
print_message "Menginstal dependensi Python..."
pip install --upgrade pip || print_error "Gagal mengupgrade pip"
pip install -r requirements.txt || print_error "Gagal menginstal dependensi Python"

# Buat direktori yang diperlukan
print_message "Membuat direktori yang diperlukan..."
mkdir -p logs
mkdir -p data
mkdir -p backups

# Konfigurasi VNC dengan Gnome
print_message "Mengkonfigurasi VNC dengan Gnome..."
cat > ~/.vnc/xstartup << EOL
#!/bin/sh
unset SESSION_MANAGER
unset DBUS_SESSION_BUS_ADDRESS
export XKL_XMODMAP_DISABLE=1
export XDG_CURRENT_DESKTOP="GNOME-Flashback:GNOME"
export XDG_MENU_PREFIX="gnome-flashback-"
[ -x /etc/vnc/xstartup ] && exec /etc/vnc/xstartup
[ -r $HOME/.Xresources ] && xrdb $HOME/.Xresources
vncconfig -iconic &
dbus-launch --exit-with-session gnome-session --session=gnome-flashback-metacity &
EOL
chmod +x ~/.vnc/xstartup

# Konfigurasi Gnome
print_message "Mengkonfigurasi Gnome..."
gsettings set org.gnome.desktop.interface enable-animations false
gsettings set org.gnome.desktop.interface clock-show-seconds true
gsettings set org.gnome.desktop.interface show-battery-percentage true
gsettings set org.gnome.desktop.wm.preferences button-layout 'appmenu:minimize,maximize,close'
gsettings set org.gnome.desktop.background show-desktop-icons true
gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-type 'nothing'
gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-battery-type 'nothing'

# Buat service systemd
print_message "Membuat service systemd..."
cat > /etc/systemd/system/linux-server-bot.service << EOL
[Unit]
Description=Linux Server Bot Service
After=network.target

[Service]
Type=simple
User=$SUDO_USER
WorkingDirectory=$(pwd)
ExecStart=$(pwd)/venv/bin/python src/server_bot.py
Restart=always
RestartSec=10
Environment=PYTHONUNBUFFERED=1
Environment=DISPLAY=:1
Environment=XAUTHORITY=/home/$SUDO_USER/.Xauthority

[Install]
WantedBy=multi-user.target
EOL

# Reload systemd dan aktifkan service
print_message "Mengaktifkan service..."
systemctl daemon-reload
systemctl enable linux-server-bot
systemctl start linux-server-bot || print_error "Gagal memulai service"

# Buat backup otomatis
print_message "Membuat script backup otomatis..."
cat > scripts/backup.sh << EOL
#!/bin/bash
BACKUP_DIR="backups/\$(date +%Y%m%d_%H%M%S)"
mkdir -p \$BACKUP_DIR
cp -r config \$BACKUP_DIR/
cp -r data \$BACKUP_DIR/
tar -czf \$BACKUP_DIR/backup.tar.gz \$BACKUP_DIR
find backups -type d -mtime +7 -exec rm -rf {} \;
EOL
chmod +x scripts/backup.sh

# Tambahkan ke crontab
(crontab -l 2>/dev/null; echo "0 0 * * * $(pwd)/scripts/backup.sh") | crontab -

# Buat script update otomatis
print_message "Membuat script update otomatis..."
cat > scripts/update.sh << EOL
#!/bin/bash
git pull
source venv/bin/activate
pip install -r requirements.txt
systemctl restart linux-server-bot
EOL
chmod +x scripts/update.sh

print_message "Instalasi selesai! Berikut langkah selanjutnya:"
echo "1. Konfigurasi file config.yaml dengan pengaturan Anda"
echo "2. Buat password VNC dengan menjalankan: vncpasswd"
echo "3. Akses antarmuka web di: http://localhost:5000"
echo "4. Untuk update otomatis, jalankan: ./scripts/update.sh"
echo "5. Backup otomatis akan berjalan setiap hari di jam 00:00"
echo "6. Desktop Environment Gnome telah diinstal dan dikonfigurasi"
echo "7. Untuk melihat status sistem, jalankan: ./scripts/system_status.sh"

print_message "Instalasi berhasil diselesaikan!" 